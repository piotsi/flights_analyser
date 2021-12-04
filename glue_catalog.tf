resource "aws_glue_catalog_database" "glue_flights_analyser_database" {
  name = var.redshift_db_name
}

resource "aws_glue_catalog_table" "glue_aircrafts_table" {
  name          = "aircrafts"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
  parameters    = {
      "classification" = "json"
      "connectionName" = aws_glue_connection.msk_connection.name
  }
  table_type    = "EXTERNAL_TABLE"

  storage_descriptor {
    location      = var.kafka_topic_name
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    parameters                = {
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
      name = "callsign"
      type = "string"
    }

    columns {
      name = "owner"
      type = "string"
    }

    columns {
      name = "operator"
      type = "string"
    }

    columns {
      name = "age"
      type = "int"
    }

    columns {
      name = "model"
      type = "string"
    }

    columns {
      name = "manufacturer"
      type = "string"
    }

    columns {
      name = "origin_country"
      type = "string"
    }
  }
}

resource "aws_glue_catalog_table" "glue_arrivals_table" {
  name          = "arrivals"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
  parameters    = {
      "classification" = "json"
      "connectionName" = aws_glue_connection.msk_connection.name
  }
  table_type    = "EXTERNAL_TABLE"

  storage_descriptor {
    location      = var.kafka_topic_name
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    parameters                = {
        "connectionName" = aws_glue_connection.msk_connection.name
        "topicName"      = var.kafka_topic_name
        "typeOfData"     = "kafka"
    }

    ser_de_info {
        serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }

    columns {
      name = "airport_id"
      type = "string"
    }

    columns {
      name = "last_seen"
      type = "timestamp"
    }

    columns {
      name = "est_arrival"
      type = "timestamp"
    }

    columns {
      name = "arr_ap_cand_cnt"
      type = "int"
    }
  }
}

resource "aws_glue_catalog_table" "glue_departures_table" {
  name          = "departures"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
  parameters    = {
      "classification" = "json"
      "connectionName" = aws_glue_connection.msk_connection.name
  }
  table_type    = "EXTERNAL_TABLE"

  storage_descriptor {
    location      = var.kafka_topic_name
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    parameters                = {
        "connectionName" = aws_glue_connection.msk_connection.name
        "topicName"      = var.kafka_topic_name
        "typeOfData"     = "kafka"
    }

    ser_de_info {
        serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }

    columns {
      name = "airport_id"
      type = "string"
    }

    columns {
      name = "last_seen"
      type = "timestamp"
    }

    columns {
      name = "est_departure"
      type = "timestamp"
    }

    columns {
      name = "dep_ap_cand_cnt"
      type = "int"
    }
  }
}

resource "aws_glue_catalog_table" "glue_flights_table" {
  name          = "flights"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
  parameters    = {
      "classification" = "json"
      "connectionName" = aws_glue_connection.msk_connection.name
  }
  table_type    = "EXTERNAL_TABLE"

  storage_descriptor {
    location      = var.kafka_topic_name
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    parameters                = {
        "connectionName" = aws_glue_connection.msk_connection.name
        "topicName"      = var.kafka_topic_name
        "typeOfData"     = "kafka"
    }

    ser_de_info {
        serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }

    columns {
      name = "aircraft_id"
      type = "int"
    }

    columns {
      name = " departure_id"
      type = "int"
    }

    columns {
      name = "arrival_id"
      type = "int"
    }

    columns {
      name = "track_id"
      type = "int"
    }
  }
}

resource "aws_glue_catalog_table" "glue_tracks_table" {
  name          = "tracks"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name
  parameters    = {
      "classification" = "json"
      "connectionName" = aws_glue_connection.msk_connection.name
  }
  table_type    = "EXTERNAL_TABLE"

  storage_descriptor {
    location      = var.kafka_topic_name
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    parameters                = {
        "connectionName" = aws_glue_connection.msk_connection.name
        "topicName"      = var.kafka_topic_name
        "typeOfData"     = "kafka"
    }

    ser_de_info {
        serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }

    columns {
      name = "time"
      type = "timestamp"
    }

    columns {
      name = "latitude"
      type = "float"
    }

    columns {
      name = "longtitude"
      type = "float"
    }

    columns {
      name = "altitude"
      type = "float"
    }

    columns {
      name = "true_track"
      type = "float"
    }

    columns {
      name = "on_ground"
      type = "boolean"
    }
  }
}
