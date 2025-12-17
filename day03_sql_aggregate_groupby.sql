-- =========================================
-- SQL AGGREGATE FUNCTIONS & GROUP BY
-- Database : world
-- Author   : Deepak Jangid
-- Purpose  : Practice aggregate functions,
--            GROUP BY and HAVING clause
-- day : 3
-- =========================================

USE world;

-- -----------------------------------------
-- DISTINCT KEYWORD
-- -----------------------------------------

-- Get unique continents
SELECT DISTINCT continent
FROM country;

-- Get unique continent–region pairs
SELECT DISTINCT continent, region
FROM country;

-- -----------------------------------------
-- AGGREGATE FUNCTIONS
-- -----------------------------------------

-- COUNT examples
SELECT COUNT(indepyear) AS indepyear_count
FROM country;

SELECT COUNT(*) AS total_rows
FROM country;

-- Multiple aggregate functions together
SELECT COUNT(population) AS population_count,
       SUM(population)   AS total_population,
       AVG(population)   AS average_population,
       MIN(population)   AS min_population,
       MAX(population)   AS max_population
FROM country;

-- COUNT vs COUNT DISTINCT
SELECT COUNT(continent) AS continent_count,
       COUNT(DISTINCT continent) AS unique_continents
FROM country;

-- Conditional COUNT
SELECT COUNT(indepyear) AS indepyear_count,
       COUNT(*) AS total_countries
FROM country
WHERE continent = 'Asia';

-- -----------------------------------------
-- PRACTICE QUESTIONS (AGGREGATES)
-- -----------------------------------------

-- Countries independent after 1947 and before 1998
SELECT COUNT(name)          AS total_countries,
       COUNT(region)        AS total_regions,
       AVG(lifeexpectancy)  AS avg_life_expectancy,
       SUM(population)      AS total_population
FROM country
WHERE indepyear > 1947
  AND indepyear < 1998;

-- Countries starting with A or D
SELECT COUNT(name)                AS total_countries,
       COUNT(DISTINCT region)     AS unique_regions,
       SUM(population)            AS total_population,
       MAX(lifeexpectancy)        AS highest_life_expectancy,
       COUNT(capital)             AS total_capitals
FROM country
WHERE name LIKE 'A%'
   OR name LIKE 'D%';

-- -----------------------------------------
-- GROUP BY CLAUSE
-- -----------------------------------------

-- Total countries per continent
SELECT continent,
       COUNT(name) AS total_countries
FROM country
GROUP BY continent;

-- Total countries per independence year
SELECT indepyear,
       COUNT(name) AS total_countries
FROM country
GROUP BY indepyear;

-- -----------------------------------------
-- HAVING CLAUSE
-- -----------------------------------------

-- Continents with population greater than 30 million
SELECT continent,
       SUM(population) AS total_population
FROM country
GROUP BY continent
HAVING SUM(population) > 30000000;

-- Independence years having more than 2 countries after 1930
SELECT indepyear,
       COUNT(name) AS total_countries
FROM country
WHERE indepyear > 1930
GROUP BY indepyear
HAVING COUNT(name) > 2;

-- -----------------------------------------
-- GOVERNMENT FORM QUESTIONS
-- -----------------------------------------

-- Government forms having more than 20 countries
SELECT governmentform,
       COUNT(name) AS total_countries
FROM country
GROUP BY governmentform
HAVING COUNT(name) > 20;

-- Government form where capital value is greater than 30
SELECT governmentform,
       COUNT(name) AS total_countries
FROM country
WHERE capital > 30
GROUP BY governmentform;

-- -----------------------------------------
-- FINAL PRACTICE QUERY
-- -----------------------------------------

-- Continents where:
-- life expectancy > 38
-- total population > 300000
SELECT continent,
       COUNT(name)    AS total_countries,
       COUNT(region)  AS total_regions,
       SUM(population) AS total_population
FROM country
WHERE lifeexpectancy > 38
GROUP BY continent
HAVING SUM(population) > 300000;

-- =========================================
-- END OF FILE
-- =========================================
