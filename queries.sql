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


-- What animals belong to Melody Pond?
SELECT * FROM animals JOIN owners ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM species 
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT * FROM owners 
JOIN animals ON owners.id = animals.owner_id
JOIN species ON species.id = animals.species_id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM owners 
JOIN animals ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester'
AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(*) FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name;

SELECT visits.date_of_visit, animals.name, vets.name FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit;

-- How many different animals did Stephanie Mendez see? answer:
SELECT animals.id, vets.name, animals.name FROM visits
JOIN animals ON visits.animal_id = animals.id
LEFT JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties
SELECT vets.name AS vet_name, species.name AS specializatiON FROM specializatiONs
JOIN species ON specializatiONs.species_id = species.id
RIGHT JOIN vets ON specializatiONs.vet_id = vets.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020 
SELECT animals.id, vets.name, animals.name, date_of_visit FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez' 
AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal hAS the most visits to vets? answers: BoadmON with 4 visits
SELECT animal_id, animals.name, COUNT(animal_id) FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animal_id, animals.name
order by COUNT(animal_id);

-- Who wAS Maisy Smith's first visit? answers: boarmON in 2019-01-24
SELECT animal_id, animals.name, vets.name AS vet_name, date_of_visit FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
order by date_of_visit;

-- Details for most recent visit: animal informatiON, vet informatiON, and date of visit. 
SELECT date_of_visit, animals.*, vets.* AS max_visit FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
order by date_of_visit desc;


-- How many visits were with a vet that did not specialize in that animal's species? answers: 12
SELECT vets.id AS vet_id, specializatiONs.species_id AS specializatiON_id,
species.name AS species_name, species.id AS animal_species_id FROM visits
LEFT JOIN vets ON visits.vet_id = vets.id
LEFT JOIN animals ON visits.animal_id = animals.id
LEFT JOIN species ON animals.species_id = species.id
LEFT JOIN specializatiONs ON vets.id = specializatiONs.vet_id
WHERE vets.id != 3 
AND specializatiONs.species_id != species.id 
OR specializatiONs.species_id IS NULL
order by vets.id;

SELECT vets.name, species.id AS animal_species_id, species.name AS animal_species_name, count(species.id) FROM visits
LEFT JOIN vets ON visits.vet_id = vets.id 
LEFT JOIN animals ON visits.animal_id = animals.id
LEFT JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name, species.id;