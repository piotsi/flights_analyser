resource "tls_private_key" "tls_pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_pair_ec2
  public_key = tls_private_key.tls_pk.public_key_openssh

  provisioner "local-exec" {
    command = <<-EOT
      echo '${tls_private_key.tls_pk.private_key_pem}' > ./kafkaKey.pem
      chmod 400 kafkaKey.pem
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm ./kafkaKey.pem"
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
  user_data                   = file("install_nifi.sh")

  tags = {
    Name = "ec2_kafka_client"
  }
}

output "ec2_kafka_client_public_ip" {
  description = "Public IP address of the ec2_kafka_client instance"
  value       = aws_instance.ec2_kafka_client.public_ip
}