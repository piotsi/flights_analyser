resource "aws_glue_connection" "msk_connection" {
  name            = "msk_connection"
  description     = "Connection to MSK cluster"
  connection_type = "KAFKA"
  match_criteria  = []

  connection_properties = {
    KAFKA_BOOTSTRAP_SERVERS = data.aws_msk_cluster.msk_cluster.bootstrap_brokers
    KAFKA_CLIENT_KEYSTORE = ""
    KAFKA_CLIENT_KEYSTORE_PASSWORD = ""
    KAFKA_CLIENT_KEY_PASSWORD = ""
    KAFKA_SSL_ENABLED = "false"
  }

  physical_connection_requirements {
    availability_zone      = aws_subnet.sn_private_one.availability_zone
    subnet_id              = aws_subnet.sn_private_one.id
    security_group_id_list = [aws_security_group.sg_msk.id]
  }

  depends_on = [
    data.aws_msk_cluster.msk_cluster
  ]
}

resource "aws_glue_connection" "redshift_connection" {
  name            = "redshift_connection"
  description     = "Connection to Redshift cluster"
  connection_type = "JDBC"

  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:redshift://${aws_redshift_cluster.flights_analyser_cluster.endpoint}/${var.redshift_db_name}"
    PASSWORD            = var.redshift_password
    USERNAME            = var.redshift_username
  }

  physical_connection_requirements {
    availability_zone      = aws_subnet.sn_public_one.availability_zone
    subnet_id              = aws_subnet.sn_public_one.id
    security_group_id_list = [aws_security_group.sg_msk.id]
  }

  depends_on = [
    data.aws_redshift_cluster.flights_analyser_cluster
  ]
}

resource "aws_glue_crawler" "redshift_crawler" {
  name          = "redshift_crawler"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
  role          = aws_iam_role.role_glue.arn

  jdbc_target {
    connection_name = aws_glue_connection.redshift_connection.name
    path            = aws_glue_catalog_database.glue_flights_analyser_database.name
  }
}

resource "aws_glue_job" "glue_job_msk_redshift" {
  name     = "glue_job_msk_redshift"
  role_arn = aws_iam_role.role_glue.arn

  glue_version      = "2.0"
  number_of_workers = 2
  worker_type       = "G.1X"
  max_retries       = 0

  default_arguments = {
    "--job-bookmark-option" : "job-bookmark-disable",
    "--job-language" : "python",
    "--TempDir" = "${var.s3_temp}"
  }

  connections = [aws_glue_connection.msk_connection.name, aws_glue_connection.redshift_connection.name]

  command {
    name            = "gluestreaming"
    script_location = var.s3_glue_script
  }
}

output "s3_glue_script" {
  value = var.s3_glue_script
}
