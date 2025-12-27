-- Use database
USE regex;

-- ===============================
-- View all students and enrollments
-- ===============================
SELECT * FROM students;
SELECT * FROM enrollments;

-- ==========================================
-- Total credits taken by students per major
-- ==========================================
SELECT 
    s.major,
    SUM(e.credits) AS total_credits
FROM students AS s
JOIN enrollments AS e 
ON s.student_id = e.student_id
GROUP BY s.major;

-- ==========================================
-- Left join to show all students with courses
-- ==========================================
SELECT 
    s.student_id,
    s.student_name,
    e.enrollment_id,
    e.course_name
FROM students AS s
LEFT JOIN enrollments AS e 
ON s.student_id = e.student_id;

-- ==========================================
-- Students who are NOT enrolled in any course
-- ==========================================
SELECT 
    s.student_id,
    s.student_name
FROM students AS s
LEFT JOIN enrollments AS e 
ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- ==========================================
-- Count number of courses per student
-- ==========================================
SELECT 
    s.student_id,
    s.student_name,
    COUNT(e.enrollment_id) AS total_courses
FROM students AS s
JOIN enrollments AS e 
ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name;

-- ==========================================
-- Students having more than 2 courses
-- ==========================================
SELECT 
    s.student_id,
    s.student_name,
    COUNT(e.course_name) AS course_count
FROM students s
JOIN enrollments e 
ON s.student_id = e.student_id
GROUP BY s.student_id, s.student_name
HAVING COUNT(e.course_name) > 2;

-- ==========================================
-- Count students by major
-- ==========================================
SELECT 
    major,
    COUNT(*) AS student_count
FROM students
GROUP BY major;

-- ==========================================
-- Count students by name length
-- ==========================================
SELECT 
    CHAR_LENGTH(student_name) AS name_length,
    COUNT(student_id) AS total_students
FROM students
GROUP BY CHAR_LENGTH(student_name);

-- ==========================================
-- Student with maximum enrollments (by name length group)
-- ==========================================
SELECT 
    COUNT(e.enrollment_id) AS total_enrollments,
    CHAR_LENGTH(s.student_name) AS name_length
FROM students AS s
JOIN enrollments AS e
ON s.student_id = e.student_id
GROUP BY CHAR_LENGTH(s.student_name)
ORDER BY total_enrollments DESC
LIMIT 1;

-- ==========================================
-- WORLD DATABASE QUERIES
-- ==========================================
USE world;

-- Population category using CASE
SELECT 
    COUNT(*) AS total_countries,
    CASE
        WHEN population = 0 THEN 'No Population'
        WHEN population BETWEEN 8000 AND 70000 THEN 'Medium Population'
        ELSE 'High Population'
    END AS population_status
FROM country
GROUP BY population_status;

-- Population status by continent
SELECT 
    continent,
    population,
    CASE 
        WHEN population BETWEEN 8000 AND 70000 THEN 'TRUE'
        ELSE 'FALSE'
    END AS population_range
FROM country;

