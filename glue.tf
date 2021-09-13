resource "aws_glue_connection" "msk_connection" {
  name            = "msk_connection"
  description     = "Connection to MSK cluster"
  connection_type = "KAFKA"

  connection_properties = {
    KAFKA_BOOTSTRAP_SERVERS = join(", ", data.aws_msk_cluster.msk_cluster.bootstrap_brokers)
  }

  physical_connection_requirements {
    availability_zone      = aws_subnet.sn_private_one.availability_zone
    subnet_id              = aws_subnet.sn_private_one.id
    security_group_id_list = [aws_security_group.sg_msk.id]
  }
}

resource "aws_glue_connection" "redshift_connection" {
  name            = "redshift_connection"
  description     = "Connection to Redshift cluster"
  connection_type = "JDBC"

  connection_properties = {
    JDBC_CONNECTION_URL = join(", ", data.aws_redshift_cluster.redshift_cluster.endpoint)
    PASSWORD            = var.redshift_password
    USERNAME            = var.redshift_username
  }

  physical_connection_requirements {
    availability_zone      = aws_subnet.sn_private_one.availability_zone
    subnet_id              = aws_subnet.sn_private_one.id
    security_group_id_list = [aws_security_group.sg_msk.id]
  }
}

resource "aws_glue_catalog_database" "glue_flights_analyser_database" {
  name = "flights_analyser"
}

resource "aws_glue_catalog_table" "glue_aircrafts_table" {
  name          = "aircrafts"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
}

resource "aws_glue_catalog_table" "glue_arrivals_table" {
  name          = "arrivals"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
}

resource "aws_glue_catalog_table" "glue_departures_table" {
  name          = "departures"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
}

resource "aws_glue_catalog_table" "glue_flights_table" {
  name          = "flights"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
}

resource "aws_glue_catalog_table" "glue_tracks_table" {
  name          = "tracks"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
}

resource "aws_glue_catalog_table" "glue_departures_table" {
  name          = "departures"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
}

resource "aws_glue_crawler" "redshift_crawler" {
  name          = "redshift_crawler"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
  role          = aws_iam_role.role_glue.arn

  jdbc_target {
    connection_name = aws_glue_connection.redshift_connection.name
    path            = join("", [aws_glue_catalog_database.glue_flights_analyser_database.name, "/%"])
  }
}
