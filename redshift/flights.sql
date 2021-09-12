CREATE TABLE flights(
    flight_id INTEGER IDENTITY(0,1),
    departure_id INTEGER NOT NULL,
    FOREIGN KEY(departure_id) REFERENCES departures(departure_id)
);