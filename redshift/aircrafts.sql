CREATE TABLE aircrafts(
    aircraft_id INTEGER NOT NULL,
    icao24 VARCHAR(30),
    callsign VARCHAR(10),
    owner VARCHAR(30),
    operator VARCHAR(30),
    age INTEGER,
    model VARCHAR(30),
    manufacturer VARCHAR(30),
    origin_country VARCHAR(30),
    PRIMARY KEY(aircraft_id)
);