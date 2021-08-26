-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE airlines
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE countries
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE cities
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  countryid INT REFERENCES countries
);

CREATE TABLE flights
(
  id SERIAL PRIMARY KEY,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airlineid INT REFERENCES airlines,
  from_cityid INT REFERENCES cities,
  from_countryid INT REFERENCES countries,
  to_cityid INT REFERENCES cities,
  to_countryid INT REFERENCES countries
);

CREATE TABLE customers
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL
);

CREATE TABLE tickets
(
  id SERIAL PRIMARY KEY,
  customerid INT REFERENCES customers,
  seat TEXT NOT NULL,
  flightid INT REFERENCES flights
);

INSERT INTO airlines
  (name)
VALUES
  ('United'),
  ('British Airways'),
  ('Delta'),
  ('TUI Fly Belgium'),
  ('Air China'),
  ('American Airlines'),
  ('Avianca Brasil');

INSERT INTO countries
  (name)
VALUES
  ('United States'),
  ('Japan'),
  ('France'),
  ('UAE'),
  ('Brazil'),
  ('United Kingdom'),
  ('Mexico'),
  ('Morocco'),
  ('China'),
  ('Chile');

INSERT INTO cities
  (name, countryid)
VALUES
  ('Washington DC', 1),
  ('Los Angeles', 1),
  ('Seattle', 1),
  ('New York', 1),
  ('Cedar Rapids', 1),
  ('Charlotte', 1),
  ('Las Vegas', 1),
  ('Chicago', 1),
  ('New Orleans', 1),
  ('Tokyo', 2),
  ('Paris', 3),
  ('Dubai', 4),
  ('Sao Paolo', 5),
  ('London', 6),
  ('Mexico City', 7),
  ('Casablanca', 8),
  ('Beijing', 9),
  ('Santiago', 10);

INSERT INTO flights
  (departure, arrival, airlineid, from_cityid, from_countryid, to_cityid, to_countryid)
VALUES
  ('2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 1, 1, 3, 1),
  ('2018-12-19 12:45:00', '2018-12-19 16:15:00', 2, 10, 2, 14, 6),
  ('2018-01-02 07:00:00', '2018-01-02 08:03:00', 3, 2, 1, 7, 1),
  ('2018-04-15 16:50:00', '2018-04-15 21:00:00', 3, 3, 1, 15, 7),
  ('2018-08-01 18:30:00', '2018-08-01 21:50:00', 4, 11, 3, 16, 8),
  ('2018-10-31 01:15:00', '2018-10-31 12:55:00', 5, 12, 4, 17, 9),
  ('2019-02-06 06:00:00', '2019-02-06 07:47:00', 1, 4, 1, 6, 1),
  ('2018-12-22 14:42:00', '2018-12-22 15:56:00', 6, 5, 1, 8, 1),
  ('2019-02-06 16:28:00', '2019-02-06 19:18:00', 6, 6, 1, 9, 1),
  ('2019-01-20 19:30:00', '2019-01-20 22:45:00', 7, 13, 5, 18, 10);

INSERT INTO customers
  (first_name, last_name)
VALUES
  ('Jennifer', 'Finch'),
  ('Thadeus', 'Gathercoal'),
  ('Sonja', 'Pauley'),
  ('Waneta', 'Skeleton'),
  ('Berkie', 'Wycliff'),
  ('Alvin', 'Leathes'),
  ('Cory', 'Squibbles');

INSERT INTO tickets
  (customerid, seat, flightid)
VALUES
  (1, '33B', 1),
  (2, '8A', 2),
  (3, '12F', 3),
  (1, '33B', 4),
  (4, '23D', 5),
  (2, '18C', 6),
  (5, '9E', 7),
  (6, '1A', 8),
  (5, '32B', 9),
  (7, '10D', 10);

-- INSERT INTO tickets
--   (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
-- VALUES
--   ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 'United', 'Washington DC', 'United States', 'Seattle', 'United States'),
--   ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 'British Airways', 'Tokyo', 'Japan', 'London', 'United Kingdom'),
--   ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 'Delta', 'Los Angeles', 'United States', 'Las Vegas', 'United States'),
--   ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 'Delta', 'Seattle', 'United States', 'Mexico City', 'Mexico'),
--   ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 'TUI Fly Belgium', 'Paris', 'France', 'Casablanca', 'Morocco'),
--   ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 'Air China', 'Dubai', 'UAE', 'Beijing', 'China'),
--   ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 'United', 'New York', 'United States', 'Charlotte', 'United States'),
--   ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 'American Airlines', 'Cedar Rapids', 'United States', 'Chicago', 'United States'),
--   ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 'American Airlines', 'Charlotte', 'United States', 'New Orleans', 'United States'),
--   ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 'Avianca Brasil', 'Sao Paolo', 'Brazil', 'Santiago', 'Chile');