-- Add UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Set timezone
SET TIMEZONE="Europe/Amsterdam";

-- Create products table
CREATE TABLE IF NOT EXISTS places_list (
    uuid UUID DEFAULT uuid_generate_v4 () PRIMARY KEY,
    place VARCHAR (255) NOT NULL,
    longitude NUMERIC(9,6) NOT NULL,
    latitude NUMERIC(9,6) NOT NULL,
    photo VARCHAR (255) NULL,
    visited BOOLEAN NOT NULL
);