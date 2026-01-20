/* =========================================================
   DATABASE & TABLE STRUCTURE
   ========================================================= */

CREATE DATABASE IF NOT EXISTS window_fn_practice;
USE window_fn_practice;

-- Employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    department VARCHAR(50),
    city VARCHAR(50),
    salary INT,
    hire_date DATE
);

-- Sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);


/* =========================================================
   BASIC WINDOW FUNCTIONS
   ========================================================= */

-- 1. Row number by salary (highest first)
SELECT *,
ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num
FROM employees;

-- 2. Rank employees by salary (ties share rank)
SELECT *,
RANK() OVER(ORDER BY salary DESC) AS salary_rank
FROM employees;

-- 3. Dense rank (no gaps)
SELECT *,
DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_rank
FROM employees;


/* =========================================================
   PARTITION BY (DEPARTMENT WISE)
   ========================================================= */

-- 4. Row number within each department
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY department
    ORDER BY salary DESC
) AS dept_row_num
FROM employees;

-- 5. Rank within each department
SELECT *,
RANK() OVER(
    PARTITION BY department
    ORDER BY salary DESC
) AS dept_rank
FROM employees;


/* =========================================================
   LAG & LEAD FUNCTIONS
   ========================================================= */

-- 6. Previous and next salary
SELECT *,
LAG(salary) OVER(ORDER BY salary DESC) AS prev_salary,
LEAD(salary) OVER(ORDER BY salary DESC) AS next_salary
FROM employees;


/* =========================================================
   AGGREGATE WINDOW FUNCTIONS
   ========================================================= */

-- 7. Average salary per department
SELECT *,
AVG(salary) OVER(PARTITION BY department) AS avg_dept_salary
FROM employees;

-- 8. Salary difference from department average
SELECT *,
salary - AVG(salary) OVER(PARTITION BY department) AS salary_diff
FROM employees;


/* =========================================================
   ADVANCED WINDOW FUNCTIONS
   ========================================================= */

-- 9. Salary distribution into 4 buckets
SELECT *,
NTILE(4) OVER(ORDER BY salary) AS salary_bucket
FROM employees;

-- 10. Percent rank of employees by salary
SELECT *,
PERCENT_RANK() OVER(ORDER BY salary) AS percent_rank_salary
FROM employees;


/* =========================================================
   SALES ANALYSIS USING WINDOW FUNCTIONS
   ========================================================= */

-- 11. Running total of sales (overall)
SELECT *,
SUM(amount) OVER(ORDER BY sale_date) AS running_total
FROM sales;

-- 12. Running total of sales per employee
SELECT *,
SUM(amount) OVER(
    PARTITION BY emp_id
    ORDER BY sale_date
) AS emp_running_total
FROM sales;

-- 13. Total sales repeated on each row
SELECT *,
SUM(amount) OVER() AS total_sales
FROM sales;

-- 14. First and last sale date per employee
SELECT *,
MIN(sale_date) OVER(PARTITION BY emp_id) AS first_sale_date,
MAX(sale_date) OVER(PARTITION BY emp_id) AS last_sale_date
FROM sales;

-- 15. Moving 3-row average of sales
SELECT sale_id, sale_date, amount,
AVG(amount) OVER(
    ORDER BY sale_date
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS moving_avg_3
FROM sales;


/* =========================================================
   INTERMEDIATE LEVEL (TOP-N USING SUBQUERY)
   ========================================================= */

-- 16. Top 2 salaries in each department
SELECT *
FROM (
    SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY department
        ORDER BY salary DESC
    ) AS row_value
    FROM employees
) tempdata
WHERE row_value <= 2;
