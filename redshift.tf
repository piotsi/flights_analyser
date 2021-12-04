data "aws_redshift_cluster" "flights_analyser_cluster" {
  cluster_identifier = var.redshift_cluster_name
  depends_on = [
    aws_redshift_cluster.flights_analyser_cluster
  ]
}

resource "aws_redshift_cluster" "flights_analyser_cluster" {
  cluster_identifier           = var.redshift_cluster_name
  database_name                = var.redshift_db_name
  master_username              = var.redshift_username
  master_password              = var.redshift_password
  node_type                    = var.redshift_ec2_type
  vpc_security_group_ids       = [aws_security_group.sg_msk.id]
  cluster_parameter_group_name = aws_redshift_parameter_group.flights_analyser_cluster.name
  cluster_subnet_group_name    = aws_redshift_subnet_group.flights_analyser_cluster.name
  cluster_type                 = "single-node"
  skip_final_snapshot          = true
}

output "redshift_cluster_endpoint" {
  description = "Redshift cluster endpoint"
  value       = aws_redshift_cluster.flights_analyser_cluster.endpoint
}

output "redshift_cluster_jdbc" {
  description = "Redshift cluster endpoint"
  value       = "jdbc:redshift://${aws_redshift_cluster.flights_analyser_cluster.endpoint}/${var.redshift_db_name}"
}

resource "aws_redshift_parameter_group" "flights_analyser_cluster" {
  name   = "flights-analyser-cluster-parameter-group"
  family = "redshift-1.0"

  parameter {
    name  = "enable_user_activity_logging"
    value = "true"
  }
}

resource "aws_redshift_subnet_group" "flights_analyser_cluster" {
  name       = "flights-analyser-cluster-subnet-group"
  subnet_ids = [aws_subnet.sn_public_one.id]
}