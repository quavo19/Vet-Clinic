/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals
WHERE name LIKE '%mon';

SELECT name FROM animals
WHERE date_of_birth between '2016-01-01' and '2019-12-31';

SELECT name FROM animals
WHERE neutered = TRUE and escape_attempts < 3;

SELECT date_of_birth FROM animals
WHERE name = 'Agumon' or name = 'Pikachu';

SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.5;

SELECT * FROM animals
WHERE neutered = TRUE;

SELECT * FROM animals
WHERE name != 'Gabumon';

SELECT * FROM animals
WHERE weight_kg >= 10.4 and weight_kg <= 17.3;


BEGIN;
    UPDATE animals SET species = 'unspecified';
    SELECT * FROM animals;
ROLLBACK;

BEGIN;
    UPDATE animals 
    SET species = 'digimon' WHERE name LIKE '%mon';
    UPDATE animals 
    SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

-- set weight to negatives for given ids, as said by the reviewer
BEGIN;
    UPDATE animals
    set weight_kg = weight_kg * (-1)
    WHERE id = 5 or id = 6 or id = 7 or id = 8;
COMMIT;

BEGIN;
    DELETE FROM animals;
    SELECT * FROM animals;
    ROLLBACK;
COMMIT;
SELECT * FROM animals;

BEGIN;
    DELETE FROM animals
    WHERE date_of_birth > '2022-01-01';
    SAVEPOINT FIRSTPOINT;

    UPDATE animals 
    SET weight_kg = weight_kg * (-1);
    ROLLBACK TO FIRSTPOINT;
    UPDATE animals 
    SET weight_kg = weight_kg * (-1)
    WHERE weight_kg < 0;
COMMIT;

-- number of animals
SELECT COUNT(*) FROM animals;

-- animals that have never tried to escape
SELECT COUNT(*) FROM animals
    WHERE escape_attempts = 0;

-- average weight of animals
SELECT AVG(weight_kg) FROM animals;

-- animals Who escapes the most, neutered or not neutered animals?
SELECT neutered, AVG(escape_attempts) FROM animals
    GROUP BY neutered;

-- the minimum and maximum weight of each type of animal
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
    GROUP BY species;

-- the average number of escape attempts per animal type of those born between 1990 and 2000

SELECT species, AVG(escape_attempts) FROM animals
    WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
    GROUP BY species;