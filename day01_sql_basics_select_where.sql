-- =========================================
-- SQL PRACTICE NOTES : WORLD DATABASE
-- Author : Deepak Jangid
-- Description :
-- This file contains basic SQL queries
-- covering SELECT, WHERE, LIKE, string
-- functions, numeric functions and filtering
-- =========================================

-- Use database
USE world;

-- Show all tables
SHOW TABLES;

-- Describe structure of country table
DESCRIBE country;

-- -----------------------------------------
-- BASIC SELECT QUERIES
-- -----------------------------------------

-- Select specific columns
SELECT name, population, region
FROM country;

-- Mathematical operation on column
SELECT name,
       population,
       region,
       population - 500 AS adjusted_population
FROM country;

-- -----------------------------------------
-- WHERE CLAUSE (FILTERING DATA)
-- -----------------------------------------

-- Filter by continent
SELECT *
FROM country
WHERE continent = 'Asia';

-- Filter by independence year
SELECT *
FROM country
WHERE indepyear = 1947;

-- Multiple values using IN
SELECT *
FROM country
WHERE continent IN ('North America', 'South America');

-- NOT BETWEEN operator
SELECT *
FROM country
WHERE indepyear NOT BETWEEN 1960 AND 1991;

-- NOT IN operator
SELECT name
FROM country
WHERE region NOT IN ('South Europe');

-- -----------------------------------------
-- LIKE OPERATOR (PATTERN MATCHING)
-- -----------------------------------------

-- Names starting with A
SELECT *
FROM country
WHERE name LIKE 'A%';

-- Names starting with B
SELECT *
FROM country
WHERE name LIKE 'B%';

-- Names not starting with P
SELECT *
FROM country
WHERE name NOT LIKE 'P%';

-- Names ending with 'p' and two characters after
SELECT *
FROM country
WHERE name LIKE '%p__';

-- -----------------------------------------
-- STRING FUNCTIONS
-- -----------------------------------------

-- Upper and Lower case
SELECT name,
       UPPER(name) AS upper_name,
       LOWER(name) AS lower_name
FROM country;

-- CONCAT function
SELECT name,
       code,
       CONCAT(name, '$', code, 'deepak') AS combined_string
FROM country;

-- CONCAT_WS function
SELECT name,
       code,
       CONCAT_WS('$', name, code, 'deepak') AS combined_ws
FROM country;

-- Matching concatenated string
SELECT name, code
FROM country
WHERE CONCAT(name, ' ', code) = 'Afghanistan AFG';

-- -----------------------------------------
-- LEFT & SUBSTRING FUNCTIONS
-- -----------------------------------------

-- First character comparison
SELECT name,
       LEFT(name, 1) AS first_char
FROM country
WHERE LEFT(continent, 1) = LEFT(name, 1);

-- Using SUBSTR
SELECT name,
       continent,
       SUBSTR(name, 1, 1) AS name_first,
       SUBSTR(continent, 1, 1) AS continent_first
FROM country
WHERE SUBSTR(name, 1, 1) = SUBSTR(continent, 1, 1);

-- Country starting with 'Alg'
SELECT name, population
FROM country
WHERE SUBSTR(name, 1, 3) = 'Alg';

-- INSTR function
SELECT name,
       INSTR(name, 'z') AS position_of_z
FROM country;

-- CHAR_LENGTH function
SELECT name,
       CHAR_LENGTH(name) AS name_length
FROM country;

-- -----------------------------------------
-- TRIM FUNCTIONS
-- -----------------------------------------

-- Trim spaces
SELECT CHAR_LENGTH(TRIM('        deepak        ')) AS trimmed_length;

-- Right trim
SELECT CHAR_LENGTH(RTRIM('       deepak        ')) AS right_trim;

-- Trim specific character
SELECT TRIM(BOTH 'k' FROM 'kdeepak') AS trimmed_word;

-- Nested trim
SELECT name,
       TRIM(BOTH 'a' FROM TRIM(BOTH 'A' FROM name)) AS cleaned_name
FROM country;

-- Leading and trailing trim
SELECT name,
       TRIM(LEADING 'A' FROM name) AS leading_removed,
       TRIM(TRAILING 'a' FROM name) AS trailing_removed
FROM country;

-- -----------------------------------------
-- LPAD & RPAD FUNCTIONS
-- -----------------------------------------

-- LPAD
SELECT name,
       population,
       LPAD(population, 9, '0') AS padded_population
FROM country;

-- RPAD
SELECT name,
       population,
       RPAD(population, 9, '0') AS padded_population
FROM country;

-- -----------------------------------------
-- NUMERIC FUNCTIONS
-- -----------------------------------------

-- ROUND function
SELECT name,
       lifeexpectancy,
       ROUND(lifeexpectancy) AS rounded_life
FROM country;

-- -----------------------------------------
-- DATE / YEAR FILTER
-- -----------------------------------------

SELECT *
FROM country
WHERE indepyear BETWEEN 1900 AND 2000;

SELECT *
FROM country
WHERE indepyear NOT BETWEEN 1900 AND 2000;

-- =========================================
-- END OF FILE
-- =========================================
