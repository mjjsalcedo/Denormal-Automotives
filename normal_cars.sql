\c postgres

DROP DATABASE IF EXISTS normal_cars;
DROP USER IF EXISTS normal_user;

CREATE USER normal_user;
CREATE DATABASE normal_cars WITH OWNER normal_user;

\c normal_cars
\i scripts/denormal_data.sql

CREATE TABLE car_make (
  id SERIAL PRIMARY KEY,
  make_code VARCHAR(125) NOT NULL,
  make_title VARCHAR(125) NOT NULL
);

CREATE TABLE car_model (
  id SERIAL PRIMARY KEY,
  model_code VARCHAR(125) NOT NULL,
  model_title VARCHAR(125) NOT NULL,
  car_make_id INT REFERENCES car_make(id) NOT NULL
);

CREATE TABLE car_year (
  id SERIAL PRIMARY KEY,
  year INT NOT NULL
)

INSERT INTO car_make(make_code, make_title)
SELECT DISTINCT make_code, make_title
FROM car_models;


INSERT INTO car_model(model_code, model_title)
SELECT DISTINCT model_code, model_title
FROM car_models;


INSERT INTO car_year(year)
SELECT DISTINCT year
FROM car_models;

