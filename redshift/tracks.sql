CREATE TABLE tracks(
    track_id INTEGER NOT NULL IDENTITY(0,1),
    time TIMESTAMP,
    latitude FLOAT,
    longtitude FLOAT,
    altitude FLOAT,
    true_track FLOAT,
    on_ground BOOLEAN,
    PRIMARY KEY(track_id)
);