\c postgres

DROP DATABASE IF EXISTS normal_cars;
DROP USER IF EXISTS normal_user;

CREATE USER normal_user;
CREATE DATABASE normal_cars
WITH OWNER normal_user;

\c normal_cars
\i scripts/denormal_data.sql

DROP TABLE IF EXISTS car_make;
DROP TABLE IF EXISTS car_model;
DROP TABLE IF EXISTS car_year;

CREATE TABLE car_make (
  id SERIAL PRIMARY KEY,
  make_code VARCHAR(125) NOT NULL,
  make_title VARCHAR(125) NOT NULL
);

CREATE TABLE car_year (
  id SERIAL PRIMARY KEY,
  year INT NOT NULL
);

CREATE TABLE car_model (
  id SERIAL PRIMARY KEY,
  model_code VARCHAR(125) NOT NULL,
  model_title VARCHAR(125) NOT NULL,
  car_make_id INT REFERENCES car_make(id) NOT NULL,
  car_make_year INT REFERENCES car_year(id) NOT NULL
);


INSERT INTO car_make(make_code, make_title)(
  SELECT DISTINCT make_code, make_title
  FROM car_models);


INSERT INTO car_year(year)(
  SELECT DISTINCT year
  FROM car_models
  ORDER BY year ASC);


INSERT INTO car_model(model_code, model_title, car_make_id, car_make_year)(
  SELECT DISTINCT c.model_code, c.model_title, m.id, y.id
  FROM car_models c
  INNER JOIN car_make m
  ON m.make_title = c.make_title
  INNER JOIN car_year y
  ON y.year = c.year);


SELECT DISTINCT make_title
FROM car_make
ORDER BY make_title ASC;


SELECT DISTINCT c.model_title
FROM car_model c
INNER JOIN car_make m ON m.id = c.car_make_id
WHERE m.make_code = 'VOLKS'
ORDER BY c.model_title ASC;


SELECT DISTINCT m.make_code, c.model_code, c.model_title, y.year
FROM car_model c
INNER JOIN car_make m
ON m.id = c.car_make_id
INNER JOIN car_year y
ON y.id = c.car_make_year
WHERE m.make_code = 'LAM'
ORDER BY c.model_title ASC;


SELECT DISTINCT m.*
FROM car_model m
LEFT JOIN car_year y
ON y.id = m.car_make_year
WHERE y.year <= 2015 AND y.year >= 2010
ORDER BY m.id ASC;