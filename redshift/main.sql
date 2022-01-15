CREATE TABLE flights(
    flight_id INTEGER IDENTITY(0,1),
    aircraft_id INTEGER NOT NULL,
    departure_id INTEGER NOT NULL,
    arrival_id INTEGER NOT NULL,
    track_id INTEGER NOT NULL,
    FOREIGN KEY(aircraft_id) REFERENCES aircrafts(aircraft_id),
    FOREIGN KEY(departure_id) REFERENCES departures(departure_id),
    FOREIGN KEY(arrival_id) REFERENCES arrivals(arrival_id),
    FOREIGN KEY(track_id) REFERENCES tracks(track_id)
);