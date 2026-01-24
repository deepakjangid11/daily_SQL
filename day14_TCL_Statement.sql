-- =========================================
-- TCL (Transaction Control Language)
-- =========================================
-- Transaction = group of logical DML statements
-- Transaction permanent tab hoti hai jab COMMIT karein
-- TCL commands: COMMIT, ROLLBACK, SAVEPOINT, SET AUTOCOMMIT

-- =========================================
-- Database selection
-- =========================================
USE regex1;

-- =========================================
-- Table creation (DDL)
-- DDL causes implicit commit
-- =========================================
DROP TABLE IF EXISTS actor_cp2;

CREATE TABLE actor_cp2 AS
SELECT actor_id, first_name
FROM sakila.actor
WHERE actor_id BETWEEN 1 AND 5;

SELECT * FROM actor_cp2;

-- =========================================
-- Check autocommit status
-- =========================================
SELECT @@autocommit;

-- =========================================
-- Disable autocommit (manual transaction control)
-- =========================================
SET autocommit = 0;

-- =========================================
-- DML operation (not permanent until COMMIT)
-- =========================================
INSERT INTO actor_cp2 VALUES (7,'deepak');

SELECT * FROM actor_cp2;

-- =========================================
-- Start transaction
-- =========================================
START TRANSACTION;

INSERT INTO actor_cp2 VALUES (11,'amazon');

SELECT * FROM actor_cp2;

-- =========================================
-- SAVEPOINT (partial rollback)
-- =========================================
SAVEPOINT sp1;

INSERT INTO actor_cp2 VALUES (12,'google');

SELECT * FROM actor_cp2;

-- Rollback to savepoint
ROLLBACK TO sp1;

SELECT * FROM actor_cp2;

-- =========================================
-- Final decision
-- =========================================
-- COMMIT;   -- make changes permanent
-- ROLLBACK; -- undo all changes

-- =========================================
-- Enable autocommit again (optional)
-- =========================================
SET autocommit = 1;
