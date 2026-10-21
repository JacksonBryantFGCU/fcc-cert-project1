-- Celestial Bodies Database | freeCodeCamp Relational Database Certification
-- Run against the default postgres database:
--   psql --username=freecodecamp --dbname=postgres -f universe.sql
-- This script creates a fresh universe database and populates it.
-- If a database named universe already exists, use pg_dump to export it instead.

CREATE DATABASE universe;
\connect universe

CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT,
    age_in_millions_of_years INT,
    diameter_light_years INT,
    is_spherical BOOLEAN NOT NULL
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
    description TEXT,
    age_in_millions_of_years INT,
    mass_solar NUMERIC(12, 3),
    is_main_sequence BOOLEAN NOT NULL
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    star_id INT NOT NULL REFERENCES star(star_id),
    description TEXT,
    distance_from_star_au NUMERIC(12, 3),
    has_life BOOLEAN NOT NULL,
    is_spherical BOOLEAN NOT NULL
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    planet_id INT NOT NULL REFERENCES planet(planet_id),
    description TEXT,
    diameter_km INT,
    is_spherical BOOLEAN NOT NULL,
    has_atmosphere BOOLEAN NOT NULL
);

CREATE TABLE galaxy_type (
    galaxy_type_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT NOT NULL,
    is_common BOOLEAN NOT NULL
);

INSERT INTO galaxy
(name, description, age_in_millions_of_years, diameter_light_years, is_spherical)
VALUES
('Milky Way', 'Our home galaxy', 13600, 100000, FALSE),
('Andromeda', 'Nearest major spiral galaxy', 10000, 220000, FALSE),
('Triangulum', 'Spiral galaxy in the Local Group', 12000, 60000, FALSE),
('Large Magellanic Cloud', 'Satellite galaxy of the Milky Way', 13000, 14000, FALSE),
('Small Magellanic Cloud', 'Dwarf irregular galaxy', 12000, 7000, FALSE),
('Messier 87', 'Giant elliptical galaxy', 13000, 120000, TRUE);

INSERT INTO star
(name, galaxy_id, description, age_in_millions_of_years, mass_solar, is_main_sequence)
VALUES
('Sun', 1, 'Star at the center of our Solar System', 4600, 1.000, TRUE),
('Proxima Centauri', 1, 'Closest known star to the Sun', 4850, 0.122, TRUE),
('Sirius', 1, 'Brightest star in the night sky', 242, 2.063, TRUE),
('Betelgeuse', 1, 'Red supergiant star', 8, 16.500, FALSE),
('Rigel', 1, 'Blue supergiant star', 8, 21.000, FALSE),
('Vega', 1, 'Bright star in the constellation Lyra', 455, 2.135, TRUE);

INSERT INTO planet
(name, star_id, description, distance_from_star_au, has_life, is_spherical)
VALUES
('Mercury', 1, 'Closest planet to the Sun', 0.387, FALSE, TRUE),
('Venus', 1, 'Second planet from the Sun', 0.723, FALSE, TRUE),
('Earth', 1, 'Our home planet', 1.000, TRUE, TRUE),
('Mars', 1, 'The red planet', 1.524, FALSE, TRUE),
('Jupiter', 1, 'Largest planet in the Solar System', 5.203, FALSE, TRUE),
('Saturn', 1, 'Gas giant with prominent rings', 9.537, FALSE, TRUE),
('Uranus', 1, 'Ice giant with a tilted axis', 19.191, FALSE, TRUE),
('Neptune', 1, 'Farthest planet from the Sun', 30.070, FALSE, TRUE),
('Proxima Centauri b', 2, 'Exoplanet orbiting Proxima Centauri', 0.049, FALSE, TRUE),
('Proxima Centauri d', 2, 'Small exoplanet', 0.029, FALSE, TRUE),
('Sirius Planet A', 3, 'Hypothetical planet for database practice', 1.500, FALSE, TRUE),
('Vega Planet A', 6, 'Hypothetical planet for database practice', 2.000, FALSE, TRUE);

INSERT INTO moon
(name, planet_id, description, diameter_km, is_spherical, has_atmosphere)
VALUES
('Moon', 3, 'Earth natural satellite', 3475, TRUE, FALSE),
('Phobos', 4, 'Largest moon of Mars', 22, FALSE, FALSE),
('Deimos', 4, 'Smaller moon of Mars', 12, FALSE, FALSE),
('Io', 5, 'Volcanically active moon', 3643, TRUE, TRUE),
('Europa', 5, 'Icy moon of Jupiter', 3122, TRUE, TRUE),
('Ganymede', 5, 'Largest moon in the Solar System', 5268, TRUE, TRUE),
('Callisto', 5, 'Heavily cratered moon', 4821, TRUE, TRUE),
('Amalthea', 5, 'Small inner moon of Jupiter', 167, FALSE, FALSE),
('Himalia', 5, 'Irregular moon of Jupiter', 140, FALSE, FALSE),
('Titan', 6, 'Largest moon of Saturn', 5150, TRUE, TRUE),
('Enceladus', 6, 'Icy moon with water plumes', 504, TRUE, TRUE),
('Mimas', 6, 'Moon with a large impact crater', 396, TRUE, FALSE),
('Rhea', 6, 'Second largest moon of Saturn', 1528, TRUE, TRUE),
('Dione', 6, 'Icy moon of Saturn', 1123, TRUE, TRUE),
('Tethys', 6, 'Medium sized moon of Saturn', 1062, TRUE, FALSE),
('Iapetus', 6, 'Moon with two-tone coloring', 1469, TRUE, FALSE),
('Titania', 7, 'Largest moon of Uranus', 1578, TRUE, FALSE),
('Oberon', 7, 'Outer major moon of Uranus', 1523, TRUE, FALSE),
('Miranda', 7, 'Moon with unusual surface features', 472, TRUE, FALSE),
('Triton', 8, 'Largest moon of Neptune', 2707, TRUE, TRUE);

INSERT INTO galaxy_type
(name, description, is_common)
VALUES
('Spiral', 'Galaxy with spiral arms surrounding a central bulge', TRUE),
('Elliptical', 'Galaxy with an elliptical shape', TRUE),
('Irregular', 'Galaxy without a clearly defined regular shape', FALSE);
