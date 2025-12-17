-- =========================================
-- SQL NUMERIC & DATE FUNCTIONS
-- Database : world
-- Author   : Deepak Jangid
-- Purpose  : Practice numeric and date functions
-- day : 2
-- =========================================

USE world;

-- -----------------------------------------
-- NUMERIC FUNCTIONS
-- -----------------------------------------

-- Round life expectancy
SELECT lifeexpectancy,
       ROUND(lifeexpectancy) AS rounded_value
FROM country;

-- Round with decimal places
SELECT 30.68 AS original_value,
       ROUND(30.62, 1) AS rounded_value;

-- Rounding to nearest 100 (negative precision)
SELECT 27.0012 AS original_value,
       ROUND(27.0012, -2) AS rounded_to_100;

-- Rounding to nearest 10
SELECT 457.68 AS original_value,
       ROUND(457.68, -1) AS rounded_to_10;

-- ROUND vs TRUNCATE
SELECT 3653.68 AS original_value,
       ROUND(3653.68, 1) AS rounded_value,
       TRUNCATE(3653.68, 1) AS truncated_value;

-- Other numeric functions
SELECT MOD(10, 3)   AS modulus_result,
       CEIL(4.0001) AS ceil_result,
       FLOOR(4.999) AS floor_result,
       POW(2, 4)    AS power_result;

-- -----------------------------------------
-- DATE & TIME FUNCTIONS
-- -----------------------------------------

-- Current date and time
SELECT NOW()               AS current_datetime,
       CURRENT_DATE()      AS current_date,
       CURRENT_TIME()      AS current_time,
       CURRENT_TIMESTAMP() AS current_timestamp;

-- Date arithmetic
SELECT NOW() AS today,
       ADDDATE(NOW(), 2) AS add_2_days,
       SUBDATE(NOW(), 2) AS subtract_2_days;

-- Add months and years
SELECT ADDDATE(NOW(), INTERVAL 2 MONTH) AS add_2_months,
       ADDDATE(NOW(), INTERVAL 2 YEAR)  AS add_2_years;

-- Extract parts from date
SELECT YEAR(NOW()) AS current_year;

SELECT NOW() AS current_time,
       EXTRACT(WEEK FROM NOW()) AS current_week;

-- Date formatting
SELECT NOW() AS current_time,
       EXTRACT(YEAR FROM NOW()) AS year_value,
       DATE_FORMAT(NOW(), 'Year is %Y') AS formatted_year;

-- -----------------------------------------
-- PRACTICAL QUERIES
-- -----------------------------------------

-- Countries from Europe
SELECT *
FROM country
WHERE continent = 'Europe';

-- Aggregate functions with GROUP BY
SELECT indepyear,
       COUNT(name)       AS total_countries,
       SUM(population)  AS total_population
FROM country
WHERE indepyear IS NOT NULL
GROUP BY indepyear
ORDER BY indepyear;

-- =========================================
-- END OF FILE
-- =========================================
