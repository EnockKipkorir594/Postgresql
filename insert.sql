--sets bonus to 0 of the employees who's bonus is NULL
SELECT name, COALESCE(bonus, 0) AS bonus 
FROM staff
ORDER BY name ASC;
--Using labels in Postgres
SELECT COUNT(*) AS total_staff FROM staff
-- sets the number of staff to total_staff

SELECT SUM(salary) AS total_salary FROM staff
--sets the sum of all staff to total_salary 

SELECT COUNT(*) AS active_staff FROM staff WHERE status = 'active';
--count number of active staff and set it to active staff

SELECT 
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary,
    ROUND(AVG(salary), 2) AS avarage_salary

FROM staff;
--sets highest_salary, lowest_salary and avarage_salary rounded off to 2 

--divides staff into groups by departments
SELECT department, COUNT(*) 
FROM staff 
GROUP BY department

--divides staff into groups based on different departments
--Each department has  total_staff,active_staff, total_salary,avarage_salary,lowest_salary and highest_salary
SELECT 
    department,
    COUNT (*) AS total_staff,
    COUNT(*) FILTER(WHERE status = 'active') AS acive_staff,
    SUM(salary) AS total_salary,
    ROUND(AVG(salary), 2) AS avarage_salary,
    MIN(salary) AS lowest_salary,
    MAX(salary) AS highest_salary

FROM staff
GROUP BY department,
ORDER BY total_salary DESC;

--THE GROUP BY GOLDEN RULE EVERY COLUMN IN YOUR SELECT THAT IS NOT INSIDE
--AN AGGREGATE FUNCTION MUST APPEAR IN THE GROUP BY CLAUSE.
SELECT department, name, COUNT(*)
FROM staff 
GROUP BY department, name

--GROUP BY WITH WHERE clause 
SELECT 
    department,
    COUNT(*) AS active_staff,
    SUM(salary) AS active_payroll

FROM staff
WHERE status = 'active'
GROUP BY department 
ORDER BY active_payroll DESC;

--HAVING clause 
SELECT departmen, ROUND(AVG(salary)) AS avarage_salary
FROM staff 
GROUP BY department 
HAVING AVG(salary) > 130000;
--Having filters GROUP BY  data compared to where which fileters column data

--groups departments and filters them with deprtments that have staff_count > 2 
SELECT DEPARTMENT, COUNT(*) AS staff_count 
FROM staff 
GROUP BY department 
HAVING COUNT(*) > 2

--Multiple commands with HAVING 
SELECT department, SUM(salary) AS total_salary
FROM staff 
WHERE status = 'active'
GROUP BY department 
ORDER BY total_salary  > 130000;


--filters department with total_salary greater than 130000
--1. FROM      → which table to read from
--2. WHERE     → filter individual rows
--3. GROUP BY  → divide remaining rows into groups
--4. HAVING    → filter groups
--5. SELECT    → choose which columns and aggregates to show
--6. ORDER BY  → sort the final result
--7. LIMIT     → cap how many rows to return
