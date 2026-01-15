-- =====================================================
-- SQL SUBQUERY MASTER FILE (20 PRACTICE QUESTIONS)
-- Author: Deepak Jangid
-- Topic: SINGLE ROW, MULTI ROW, CORRELATED, EXISTS, IN, ANY, ALL
-- =====================================================

CREATE DATABASE subquery_practice;
USE subquery_practice;

-- EMPLOYEE TABLE
CREATE TABLE employees (
    eid INT PRIMARY KEY,
    ename VARCHAR(30),
    salary INT,
    dept VARCHAR(30),
    age INT
);

-- DEPARTMENT TABLE
CREATE TABLE departments (
    dept VARCHAR(30) PRIMARY KEY,
    location VARCHAR(30),
    budget INT
);

-- INSERT DATA
INSERT INTO employees VALUES
(1, 'Aman', 30000, 'HR', 24),
(2, 'Ravi', 45000, 'IT', 30),
(3, 'Pooja', 42000, 'IT', 28),
(4, 'Sana', 32000, 'HR', 26),
(5, 'Vikas', 50000, 'Finance', 35),
(6, 'Kajal', 29000, 'Finance', 23),
(7, 'Nikhil', 41000, 'IT', 27),
(8, 'Rohit', 47000, 'Marketing', 32),
(9, 'Simran', 38000, 'Marketing', 29),
(10, 'Deep', 52000, 'IT', 31);

INSERT INTO departments VALUES
('HR', 'Jaipur', 400000),
('IT', 'Delhi', 900000),
('Finance', 'Mumbai', 700000),
('Marketing', 'Pune', 600000);

-- =====================================================
-- Q1: Employees whose salary is above average salary
-- SINGLE ROW SUBQUERY
-- =====================================================
SELECT ename, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- =====================================================
-- Q2: Employees working in cities Delhi or Mumbai
-- MULTI-ROW SUBQUERY
-- =====================================================
SELECT ename, dept
FROM employees
WHERE dept IN (SELECT dept FROM departments WHERE location IN ('Delhi','Mumbai'));

-- =====================================================
-- Q3: Highest salary employee in each department
-- CORRELATED SUBQUERY
-- =====================================================
SELECT e1.ename, e1.dept, e1.salary
FROM employees e1
WHERE salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.dept = e1.dept
);

-- =====================================================
-- Q4: Departments that have at least 1 employee
-- EXISTS SUBQUERY
-- =====================================================
SELECT *
FROM departments d
WHERE EXISTS (
    SELECT 1 
    FROM employees e
    WHERE e.dept = d.dept
);

-- =====================================================
-- Q5: Employees earning more than IT department average
-- SINGLE ROW SUBQUERY
-- =====================================================
SELECT ename, salary, dept
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE dept='IT');

-- =====================================================
-- Q6: Employees whose salary matches ANY salary in HR
-- ANY SUBQUERY
-- =====================================================
SELECT ename, salary
FROM employees
WHERE salary > ANY (SELECT salary FROM employees WHERE dept='HR');

-- =====================================================
-- Q7: Employees whose salary is higher than ALL HR salaries
-- ALL SUBQUERY
-- =====================================================
SELECT ename, salary
FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE dept='HR');

-- =====================================================
-- Q8: Find employees in departments with budget > 5 lakhs
-- MULTI-ROW SUBQUERY
-- =====================================================
SELECT ename, dept
FROM employees
WHERE dept IN (SELECT dept FROM departments WHERE budget > 500000);

-- =====================================================
-- Q9: Youngest employee in each department
-- CORRELATED SUBQUERY
-- =====================================================
SELECT e1.ename, e1.dept, e1.age
FROM employees e1
WHERE age = (
    SELECT MIN(e2.age) 
    FROM employees e2
    WHERE e2.dept = e1.dept
);

-- =====================================================
-- Q10: Employees earning more than department average
-- CORRELATED SUBQUERY
-- =====================================================
SELECT e1.ename, e1.salary, e1.dept
FROM employees e1
WHERE salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.dept = e1.dept
);

-- =====================================================
-- Q11: Departments with no employees
-- NOT EXISTS
-- =====================================================
SELECT *
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e WHERE e.dept = d.dept
);

-- =====================================================
-- Q12: Employees whose salary equals IT department’s minimum salary
-- SINGLE ROW SUBQUERY
-- =====================================================
SELECT ename, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees WHERE dept='IT');

-- =====================================================
-- Q13: Employees older than average age
-- SINGLE ROW
-- =====================================================
SELECT ename, age
FROM employees
WHERE age > (SELECT AVG(age) FROM employees);

-- =====================================================
-- Q14: Departments where budget is greater than all salaries
-- ALL SUBQUERY
-- =====================================================
SELECT dept, budget
FROM departments
WHERE budget > ALL (SELECT salary FROM employees);

-- =====================================================
-- Q15: Employees who work in Jaipur or Pune
-- MULTI-ROW SUBQUERY
-- =====================================================
SELECT ename, dept
FROM employees
WHERE dept IN (
    SELECT dept FROM departments WHERE location IN ('Jaipur','Pune')
);

-- =====================================================
-- Q16: Find employees who earn the 2nd highest salary in IT
-- SUBQUERY WITH ORDER LIMIT
-- =====================================================
SELECT ename, salary
FROM employees
WHERE salary = (
    SELECT salary FROM employees WHERE dept='IT'
    ORDER BY salary DESC LIMIT 1 OFFSET 1
);

-- =====================================================
-- Q17: Count employees in departments with budget > 6 lakhs
-- SUBQUERY IN WHERE
-- =====================================================
SELECT COUNT(*)
FROM employees
WHERE dept IN (SELECT dept FROM departments WHERE budget > 600000);

-- =====================================================
-- Q18: Employees not in the Finance department
-- SUBQUERY WITH NOT IN
-- =====================================================
SELECT ename, dept
FROM employees
WHERE dept NOT IN (SELECT dept FROM departments WHERE dept='Finance');

-- =====================================================
-- Q19: Employees whose salary is greater than Marketing's max salary
-- SINGLE ROW
-- =====================================================
SELECT ename, salary
FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees WHERE dept='Marketing');

-- =====================================================
-- Q20: Departments where the average employee salary is > 40k
-- CORRELATED SUBQUERY (HAVING)
-- =====================================================
SELECT dept
FROM employees
GROUP BY dept
HAVING AVG(salary) > 40000;
