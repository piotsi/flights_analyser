resource "aws_glue_catalog_database" "glue_flights_analyser_database" {
  name = "flights_analyser"
}

resource "aws_glue_catalog_table" "glue_aircrafts_table" {
  name          = "aircrafts"
  database_name = aws_glue_catalog_database.glue_flights_analyser_database.name

  storage_descriptor {
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

  storage_descriptor {
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

  storage_descriptor {
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

  storage_descriptor {
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

  storage_descriptor {
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
