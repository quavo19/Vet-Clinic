/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
   id INT,
   name TEXT,
   date_of_birth DATE,
   escape_attempts INT,
   neutered BOOLEAN,
   weight_kg DECIMAL
);

ALTER TABLE animals
ADD species TEXT;

CREATE TABLE owners (
   id INT generated by default as identity,
   full_name TEXT,
   age INT,
   PRIMARY KEY(id)
);

CREATE TABLE species (
   id INT generated by default as identity,
   name TEXT,
   PRIMARY KEY(id)
);

ALTER TABLE animals ADD COLUMN id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);