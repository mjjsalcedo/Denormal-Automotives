\c postgres

DROP DATABASE IF EXISTS denormal_cars;
DROP USER IF EXISTS denormal_user;

CREATE USER denormal_user;
CREATE DATABASE denormal_cars WITH OWNER denormal_user;

\c denormal_user
\i scripts/denormal_data.sql