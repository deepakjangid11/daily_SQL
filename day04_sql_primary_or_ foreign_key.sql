# 🌍 World Database SQL Practice

-- This repository contains my SQL practice work using the **World database**.  
-- The focus of this project is to understand **database structure, keys, joins, and data analysis** using real-world country and city data.

---

## 🗄️ Database Used
-- **World Database**

-- Tables used:
--  `city`
-- `country`
-- `countrylanguage`

---

## 🔑 Database Concepts Covered

### ✅ Primary Key
- A column that contains **unique and NOT NULL** values.
- Example:
  - `city.id`
  - `country.code`

### ✅ Foreign Key
- A column that refers to the **primary key of another table**.
- It can contain **duplicate values**.
- Example:
  - `city.countrycode` → `country.code`
  - `countrylanguage.countrycode` → `country.code`

---

## 📊 Queries Performed

### 🔹 1. View and describe tables
- Retrieved complete data from `city` and `country`
- Used `DESCRIBE` to understand table structure

### 🔹 2. Count total and distinct country codes
- Compared total country codes vs unique country codes

### 🔹 3. Join City and Country tables
- Displayed city ID, city name, and country code
- Verified relationships using INNER JOIN

### 🔹 4. City-wise country information
**Fetched:**
- City name  
- City population  
- Country name  
- Country population  

### 🔹 5. Country language analysis
- Retrieved country name and population
- Listed languages spoken in each country
- Included percentage of each language

---

## 🧠 Skills Practiced
- SQL JOINs (INNER JOIN)
- Primary Key & Foreign Key relationships
- Aggregation and filtering
- Real-world database analysis

---

## 🚀 Author
**Deepak Jangid**  
Learning SQL & Data Analysis  
