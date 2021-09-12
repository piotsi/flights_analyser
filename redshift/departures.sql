CREATE TABLE departures(
    departure_id INTEGER IDENTITY(0,1),
    airport_id VARCHAR(30),
    last_seen TIMESTAMP,
    est_departure TIMESTAMP,
    dep_ap_cand_cnt INTEGER,
    PRIMARY KEY(departure_id)
);