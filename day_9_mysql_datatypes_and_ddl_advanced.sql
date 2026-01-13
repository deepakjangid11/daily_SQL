-- ============================================================
--              MySQL Datatype Demonstration Script
--                    Developed by: Deepak
-- ============================================================

-- Create and use database
CREATE DATABASE IF NOT EXISTS regex1;
USE regex1;

-- ============================================================
--                 NUMERIC DATATYPES (INT FAMILY)
-- ============================================================

-- TINYINT (-128 to 127)
CREATE TABLE yash1 (
    salary TINYINT
);

INSERT INTO yash1 VALUES (127);
-- This will throw OUT OF RANGE error because 128 is not allowed
-- INSERT INTO yash1 VALUES (128);

-- ============================================================
--                 FLOAT & DOUBLE PRECISION
-- ============================================================

CREATE TABLE yash2 (
    salary FLOAT(10,6),
    price DOUBLE(12,8)
);

INSERT INTO yash2 VALUES (100.678124, 100.67812412);
SELECT * FROM yash2;

-- ============================================================
--                 STRING DATATYPES (CHAR vs VARCHAR)
-- ============================================================

CREATE TABLE yash3 (
    name VARCHAR(20),
    gender CHAR(10)
);

INSERT INTO yash3 VALUES 
('tushar', 'male'),
('aman', 'male'),
('chusta', 'female'),
('raj        ', 'male      ');

SELECT *, LENGTH(name), LENGTH(gender) FROM yash3;

-- ============================================================
--                 DDL STATEMENTS (CREATE, DROP, ALTER)
-- ============================================================

-- Simple table
CREATE TABLE raj123 (
    col INT
);

-- CREATE TABLE USING SELECT (CTAS)
CREATE TABLE actor_cp AS
SELECT actor_id, first_name, last_name 
FROM sakila.actor;

SELECT * FROM actor_cp;

-- DROP TABLE (Deletes structure + data)
DROP TABLE IF EXISTS actor_ap;

-- ============================================================
--           CREATE TABLE WITH FILTERED SELECT STATEMENT
-- ============================================================

DROP TABLE IF EXISTS actor_cp;

CREATE TABLE actor_cp AS
SELECT actor_id AS id,
       first_name AS fname,
       last_name AS lname
FROM sakila.actor
WHERE actor_id BETWEEN 10 AND 14;

SELECT * FROM actor_cp;

-- ============================================================
--               ADDING & DROPPING COLUMNS (ALTER)
-- ============================================================

ALTER TABLE actor_cp ADD COLUMN salary INT DEFAULT 500;

-- Add a PRIMARY KEY
ALTER TABLE actor_cp 
ADD CONSTRAINT pk_actor PRIMARY KEY (id);

-- Drop a column
ALTER TABLE actor_cp DROP COLUMN lname;

-- Rename Column
ALTER TABLE actor_cp RENAME COLUMN salary TO new_salary;

DESCRIBE actor_cp;

-- ============================================================
--                      DML OPERATIONS
-- ============================================================

SET SQL_SAFE_UPDATES = 0;

-- Update all rows
UPDATE actor_cp SET new_salary = 900;

-- Conditional update
UPDATE actor_cp SET new_salary = 888 WHERE fname = 'UMA';

SELECT * FROM actor_cp;

-- ============================================================
--                 ADVANCED CONSTRAINT EXAMPLES
-- ============================================================

-- Table with CHECK, UNIQUE, NOT NULL
CREATE TABLE employee_advanced (
    id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(30) NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(50) UNIQUE,
    salary DECIMAL(10,2) DEFAULT 15000
);

INSERT INTO employee_advanced (emp_name, age, email)
VALUES ('Deepak', 22, 'deepak@example.com');

SELECT * FROM employee_advanced;

-- ============================================================
--                    FOREIGN KEY EXAMPLE
-- ============================================================

CREATE TABLE department (
    dep_id INT PRIMARY KEY,
    dep_name VARCHAR(40)
);

CREATE TABLE employee_fk (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(40),
    dep_id INT,
    FOREIGN KEY (dep_id) REFERENCES department(dep_id)
);

INSERT INTO department VALUES (1, 'IT'), (2, 'HR');

INSERT INTO employee_fk VALUES (101, 'Tushar', 1);

SELECT * FROM employee_fk;

-- ============================================================
--                   END OF SCRIPT
-- ============================================================
