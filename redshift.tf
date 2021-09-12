resource "aws_redshift_cluster" "flights_analyser_cluster" {
  cluster_identifier  = var.redshift_cluster_name
  database_name       = var.redshift_db_name
  master_username     = var.redshift_username
  master_password     = var.redshift_password
  node_type           = var.redshift_ec2_type
  cluster_type        = "single-node"
  skip_final_snapshot = true
}

output "redshift_cluster_endpoint" {
  description = "Redshift cluster endpoint"
  value       = aws_redshift_cluster.flights_analyser_cluster.endpoint
}
