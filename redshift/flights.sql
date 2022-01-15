CREATE TABLE flights(
    icao24 VARCHAR(30),
    firstSeen INTEGER,
    estDepartureAirport VARCHAR(30),
    lastSeen INTEGER,
    estArrivalAirport VARCHAR(30),
    callsign VARCHAR(30),
    estDepartureAirportHorizDistance INTEGER,
    estDepartureAirportVertDistance INTEGER,
    estArrivalAirportHorizDistance INTEGER,
    estArrivalAirportVertDistance INTEGER,
    departureAirportCandidatesCount INTEGER,
    arrivalAirportCandidatesCount INTEGER,
    estDepartureAirportDistance FLOAT4,
    estArrivalAirportDistance FLOAT4
);

