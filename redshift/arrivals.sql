CREATE TABLE arrivals(
    arrival_id INTEGER IDENTITY(0,1),
    airport VARCHAR(30),
    last_seen TIMESTAMP,
    est_arrival TIMESTAMP,
    arr_ap_cand_cnt INTEGER,
    PRIMARY KEY(arrival_id)
);