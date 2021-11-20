resource "tls_private_key" "tls_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_pair_ec2
  public_key = tls_private_key.tls_pk.public_key_openssh

  provisioner "local-exec" {
    command = <<-EOT
      echo '${tls_private_key.tls_pk.private_key_pem}' > ./myKey.pem
      chmod 400 myKey.pem
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm ./myKey.pem"
  }
}

resource "aws_instance" "ec2_kafka_client" {
  ami                         = var.ami_us_east_1
  instance_type               = var.ec2_kafka_client_type
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  subnet_id                   = aws_subnet.sn_public_one.id
  vpc_security_group_ids      = [aws_security_group.sg_kafka_ec2.id]
  key_name                    = aws_key_pair.generated_key.key_name
  associate_public_ip_address = true
  user_data = templatefile("nifi_user_data.tftpl",
    {
      nifi_sensitive_properties_key = var.nifi_sensitive_properties_key,
      opensky_username              = var.opensky_username,
      opensky_password              = var.opensky_password,
      kafka_topic_name              = var.kafka_topic_name
      zookeeper_url                 = split(",", data.aws_msk_cluster.msk_cluster.zookeeper_connect_string)[0],
      msk_bootstrap_url             = split(",", data.aws_msk_cluster.msk_cluster.bootstrap_brokers_tls)[0]
    }
  )

  depends_on = [
    # MSK URL is needed for configuring NiFi Kafka processor
    data.aws_msk_cluster.msk_cluster
  ]

  tags = {
    Name = "ec2_kafka_client"
  }
}

output "ec2_kafka_client_public_ip" {
  description = "Public IP address of the ec2_kafka_client instance"
  value       = aws_instance.ec2_kafka_client.public_ip
}
