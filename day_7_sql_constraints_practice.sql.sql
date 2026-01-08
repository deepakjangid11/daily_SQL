-- =====================================================
-- TABLES & CONSTRAINTS
-- =====================================================
-- DDL  → Data Definition Language
-- Used to define structure of database objects
-- Commands: CREATE, ALTER, DROP, TRUNCATE
-- =====================================================


-- ===============================
-- DATABASE CREATION
-- ===============================

CREATE DATABASE regex1;
USE regex1;


-- ===============================
-- BASIC TABLE (DDL)
-- ===============================

-- Create a simple table
CREATE TABLE test1 (
    Sno INT
);

-- View table structure
DESCRIBE test1;


-- ===============================
-- DML (DATA MANIPULATION LANGUAGE)
-- ===============================
-- Commands: INSERT, UPDATE, DELETE


-- Insert a single value
INSERT INTO test1 VALUES (10);

-- View table data
SELECT * FROM test1;


-- Insert using column name
INSERT INTO test1 (Sno) VALUES (11);

SELECT * FROM test1;


-- Insert multiple rows including NULL
INSERT INTO test1 (Sno) VALUES (11), (NULL), (30);

SELECT * FROM test1;


-- COUNT FUNCTION
-- COUNT(column) → ignores NULL
-- COUNT(*)      → counts all rows
SELECT COUNT(Sno) AS count_sno,
       COUNT(*)  AS count_rows
FROM test1;


-- =====================================================
-- NOT NULL CONSTRAINT
-- =====================================================

CREATE TABLE test2 (
    Sno INT NOT NULL,
    salary INT
);

-- Valid inserts
INSERT INTO test2 (Sno, salary) VALUES (20, 1000);
INSERT INTO test2 (Sno, salary) VALUES (80, NULL);

-- ERROR: Sno cannot be NULL
-- INSERT INTO test2 (Sno, salary) VALUES (NULL, 1000);

-- Valid: Sno provided, salary missing
INSERT INTO test2 (Sno) VALUES (1000);

-- ERROR: Sno is NOT NULL and has no default
-- INSERT INTO test2 (salary) VALUES (700000);

SELECT * FROM test2;


-- =====================================================
-- DEFAULT CONSTRAINT
-- =====================================================

CREATE TABLE test3 (
    Sno INT NOT NULL DEFAULT 80,
    salary INT
);

-- Insert explicit Sno value
INSERT INTO test3 (Sno) VALUES (1000);

-- Default value (80) used for Sno
INSERT INTO test3 (salary) VALUES (2000);

SELECT * FROM test3;


-- =====================================================
-- UNIQUE CONSTRAINT
-- =====================================================

CREATE TABLE test4 (
    Sno INT NOT NULL,
    salary INT UNIQUE DEFAULT 100
);

-- Valid insert
INSERT INTO test4 (Sno, salary) VALUES (1000, 200000);

-- ERROR: duplicate salary value
-- INSERT INTO test4 (Sno, salary) VALUES (1001, 200000);

-- Default salary = 100
INSERT INTO test4 (Sno) VALUES (600);

-- ERROR: 100 already exists
-- INSERT INTO test4 (Sno) VALUES (700);

-- UNIQUE allows multiple NULL values
INSERT INTO test4 (Sno, salary) VALUES (1002, NULL);
INSERT INTO test4 (Sno, salary) VALUES (1003, NULL);

SELECT * FROM test4;


-- =====================================================
-- CHECK CONSTRAINT (WITHOUT NAME)
-- =====================================================

CREATE TABLE test5 (
    Sno INT,
    salary INT,
    CHECK (Sno BETWEEN 1 AND 100),
    CHECK (salary IN (1000, 2000))
);

-- Valid insert
INSERT INTO test5 (Sno, salary) VALUES (4, 1000);

-- ERROR: Sno out of range
-- INSERT INTO test5 (Sno, salary) VALUES (150, 1000);

-- ERROR: salary not allowed
-- INSERT INTO test5 (Sno, salary) VALUES (90, 1500);

SELECT * FROM test5;


-- Drop table
DROP TABLE test5;


-- =====================================================
-- CHECK CONSTRAINT (WITH NAME)
-- =====================================================

CREATE TABLE test5 (
    Sno INT,
    salary INT,
    CONSTRAINT regex_test5_sno_check
        CHECK (Sno BETWEEN 1 AND 100),
    CONSTRAINT regex_test5_salary_check
        CHECK (salary IN (1000, 2000))
);

INSERT INTO test5 (Sno, salary) VALUES (4, 1000);

-- Errors due to constraint violation
-- INSERT INTO test5 (Sno, salary) VALUES (150, 1000);
-- INSERT INTO test5 (Sno, salary) VALUES (90, 1500);


-- =====================================================
-- MULTIPLE CONSTRAINTS TABLE
-- =====================================================

CREATE TABLE employees (
    Eid INT PRIMARY KEY,                -- Unique & NOT NULL
    Ename VARCHAR(20),
    Email VARCHAR(50) UNIQUE,            -- No duplicate emails
    College VARCHAR(50) DEFAULT 'Regex-Software',
    Age INT CHECK (Age > 18),             -- Age restriction
    Guardian VARCHAR(30)
        CHECK (Guardian = REVERSE(Guardian))  -- Palindrome check
);

-- View structure
DESCRIBE employees;
