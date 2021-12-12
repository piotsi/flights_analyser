resource "aws_glue_catalog_table" "flights_analyser_states" {
  name          = "states"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
  parameters = {
    "classification" = "json"
    "connectionName" = aws_glue_connection.msk_connection.name
  }
  table_type = "EXTERNAL_TABLE"

  storage_descriptor {
    location      = var.kafka_topic_name
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    parameters = {
      "connectionName" = aws_glue_connection.msk_connection.name
      "topicName"      = var.kafka_topic_name
      "typeOfData"     = "kafka"
    }

    ser_de_info {
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }

    columns {
      name = "icao24"
      type = "string"
    }
    columns {
      name = "firstSeen"
      type = "int"
    }
    columns {
      name = "estDepartureAirport"
      type = "string"
    }
    columns {
      name = "lastSeen"
      type = "int"
    }
    columns {
      name = "estArrivalAirport"
      type = "string"
    }
    columns {
      name = "callsign"
      type = "string"
    }
    columns {
      name = "estDepartureAirportHorizDistance"
      type = "int"
    }
    columns {
      name = "estDepartureAirportVertDistance"
      type = "int"
    }
    columns {
      name = "estArrivalAirportHorizDistance"
      type = "int"
    }
    columns {
      name = "estArrivalAirportVertDistance"
      type = "int"
    }
    columns {
      name = "departureAirportCandidatesCount"
      type = "int"
    }
    columns {
      name = "arrivalAirportCandidatesCount"
      type = "int"
    }
  }
}

resource "aws_glue_catalog_table" "flights_analyser_public_states" {
  database_name = "flights_analyser"
  name          = "flights_analyser_public_states"
  parameters = {
    "CrawlerSchemaDeserializerVersion" = "1.0"
    "CrawlerSchemaSerializerVersion"   = "1.0"
    "UPDATED_BY_CRAWLER"               = "redshift_crawler"
    "classification"                   = "redshift"
    "compressionType"                  = "none"
    "connectionName"                   = aws_glue_connection.redshift_connection.name
    "typeOfData"                       = "table"
  }
  retention  = 0
  table_type = "EXTERNAL_TABLE"

  storage_descriptor {
    location          = "flights_analyser.public.states"
    number_of_buckets = -1
    parameters = {
      "CrawlerSchemaDeserializerVersion" = "1.0"
      "CrawlerSchemaSerializerVersion"   = "1.0"
      "UPDATED_BY_CRAWLER"               = "redshift_crawler"
      "classification"                   = "redshift"
      "compressionType"                  = "none"
      "connectionName"                   = aws_glue_connection.redshift_connection.name
      "typeOfData"                       = "table"
    }

    columns {
      name = "icao24"
      type = "string"
    }
    columns {
      name = "firstSeen"
      type = "int"
    }
    columns {
      name = "estDepartureAirport"
      type = "string"
    }
    columns {
      name = "lastSeen"
      type = "int"
    }
    columns {
      name = "estArrivalAirport"
      type = "string"
    }
    columns {
      name = "callsign"
      type = "string"
    }
    columns {
      name = "estDepartureAirportHorizDistance"
      type = "int"
    }
    columns {
      name = "estDepartureAirportVertDistance"
      type = "int"
    }
    columns {
      name = "estArrivalAirportHorizDistance"
      type = "int"
    }
    columns {
      name = "estArrivalAirportVertDistance"
      type = "int"
    }
    columns {
      name = "departureAirportCandidatesCount"
      type = "int"
    }
    columns {
      name = "arrivalAirportCandidatesCount"
      type = "int"
    }
  }
}