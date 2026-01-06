-- ============================================
-- DATABASE : Sakila
-- TOPIC    : Subqueries (Nested Queries)
-- AUTHOR   : Deepak Jangid
-- ============================================

USE sakila;
SHOW TABLES;

-- ============================================
-- What is Subquery?
-- --------------------------------------------
-- A subquery is a query inside another query.
-- It is used to filter data dynamically
-- based on the result of another query.
-- ============================================


-- ============================================
-- QUESTION 1
-- Get all payment details where amount is equal
-- to the amount of payment_id = 4
-- ============================================

SELECT *
FROM payment
WHERE amount = (
    SELECT amount
    FROM payment
    WHERE payment_id = 4
);


-- ============================================
-- QUESTION 2
-- Get payment_id and amount where the amount is
-- NOT equal to the amount of payment_id = 23
-- ============================================

SELECT payment_id, amount
FROM payment
WHERE amount != (
    SELECT amount
    FROM payment
    WHERE payment_id = 23
);


-- ============================================
-- QUESTION 3
-- Get payment_id, customer_id, amount, payment_date
-- where the payment month is same as payment_id = 6
-- ============================================

SELECT payment_id, customer_id, amount, payment_date
FROM payment
WHERE MONTH(payment_date) = (
    SELECT MONTH(payment_date)
    FROM payment
    WHERE payment_id = 6
);


-- ============================================
-- QUESTION 4
-- Get all payment details where staff_id is same
-- as staff who served payment_id = 7
-- ============================================

SELECT *
FROM payment
WHERE staff_id = (
    SELECT staff_id
    FROM payment
    WHERE payment_id = 7
);


-- ============================================
-- QUESTION 5
-- Get all payment details where amount is equal
-- to the highest payment amount
-- ============================================

SELECT *
FROM payment
WHERE amount = (
    SELECT MAX(amount)
    FROM payment
);


-- ============================================
-- QUESTION 6
-- Get amount and total number of payments
-- where amount is less than the amount of
-- rental_id = 1725
-- ============================================

SELECT amount, COUNT(*) AS total_payments
FROM payment
WHERE amount < (
    SELECT amount
    FROM payment
    WHERE rental_id = 1725
)
GROUP BY amount;


-- ============================================
-- QUESTION 7
-- Get month and total amount spent where
-- payment month is greater than the month of
-- customer_id = 1 and payment_id = 3
-- ============================================

SELECT MONTH(payment_date) AS payment_month,
       SUM(amount) AS total_amount
FROM payment
WHERE MONTH(payment_date) > (
    SELECT MONTH(payment_date)
    FROM payment
    WHERE customer_id = 1
      AND payment_id = 3
)
GROUP BY MONTH(payment_date);
