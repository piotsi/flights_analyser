data "aws_msk_cluster" "msk_cluster" {
  cluster_name = var.msk_cluster_name
  depends_on = [
    aws_msk_cluster.msk_cluster
  ]
}

output "zookeeper_url" {
  value = aws_msk_cluster.msk_cluster.zookeeper_connect_string
}

output "msk_bootstrap_url" {
  value = aws_msk_cluster.msk_cluster.bootstrap_brokers_tls
}

resource "aws_msk_cluster" "msk_cluster" {
  cluster_name           = var.msk_cluster_name
  kafka_version          = var.msk_kafka_version
  number_of_broker_nodes = var.msk_broker_nodes

  broker_node_group_info {
    instance_type   = var.msk_kafka_instance_type
    ebs_volume_size = var.msk_ebs_volume_size
    client_subnets = [
      aws_subnet.sn_private_one.id,
      aws_subnet.sn_private_two.id,
    ]
    security_groups = [aws_security_group.sg_msk.id]
  }
}