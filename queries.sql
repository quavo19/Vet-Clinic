/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM vet_clinic
WHERE name LIKE '%mon';

SELECT name FROM vet_clinic
WHERE date_of_birth between '2016-01-01' and '2019-01-01';

SELECT name FROM vet_clinic
WHERE neutered = TRUE and escape_attempts < 3;

SELECT date_of_birth FROM vet_clinic
WHERE name = 'Agumon' or name = 'Pikachu';

SELECT name, escape_attempts FROM vet_clinic
WHERE weight_kg > 10.5;

SELECT * FROM vet_clinic
WHERE neutered = TRUE;

SELECT * FROM vet_clinic
WHERE name != 'Gabumon';

SELECT * FROM vet_clinic
WHERE weight_kg >= 10.4 and weight_kg <= 17.3;
