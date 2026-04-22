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

--Understanding Wildcards % and _ 
--% returns one or more characters ahead or behind a certain character
--_ returns only a single character behind or ahead or a certain character


--WINDOW FUNCTIONS
SELECT 
    full_name,
    deparment,
    basic_salary,
    ROW_RANK OVER(
        PARTITION BY department
        ORDER BY basic_salary DESC
    ) AS rank_num

FROM employees
ORDER BY department, basic_salary DESC;

--RANK --> Rank With Gaps On Ties 
SELECT 
    full_name,
    department,
    basic_salary,
    RANK() OVER(
        PARTITION BY department
        ORDER BY basic_salary DESC
    )AS salary_rank
FROM employees
ORDER BY department, salary_rank;

--RANK --> Without Gaps On Ties
SELECT 
    full_name,
    department,
    basic_salary,
    RANK() OVER(ORDER BY basic_salary DESC) AS rank_with_gaps,
    DENSE_RANK() OVER(ORDER BY basic_salary DESC) AS rank_no_gaps
FROM employees
ORDER BY basic_salary DESC;

--Finding the top earner for the department 
WITH ranked_employees AS(
    SELECT 
        full_name,
        department,
        basic_salary,
        RANK() OVER(
            PARTITION BY department
            ORDER BY basic_salary DESC
        )AS salary_rank
    FROM employees
    WHERE status = 'active'
)
SELECT full_name, department, basic_salary
FROM ranked_employees
WHERE salary_rank = 1 
ORDER BY department;

--AGGREGATE WINDOW FUNCTIONS
--SUM AS a window function - Running Total
SELECT 
    full_name,
    month,
    net_pay,
    SUM(net_pay) OVER (
        PARTITION BY employee_id 
        ORDER BY month
    )AS running_total 
FROM payroll
JOIN employees ON payroll.employee_id = employees.id
ORDER BY full_name, month;

--AVARAGE AS a window function
SELECT
    full_name,
    department,
    basic_salary,
    ROUND(AVG(basic_salary) OVER(
        PARTITION BY department
    ),2) AS avg_basic_salary,
    basic_salary - ROUND(AVG(basic_salary) OVER(
        PARTITION BY department
    ),2) AS diff_avg_salary
FROM employees
ORDER BY full_name, basic_salary DESC;

--COUNT AS window function 
SELECT 
    full_name,
    deparment,
    COUNT(*) OVER (
        PARTITION BY deparment
    )AS team_size
FROM employees
ORDER BY deparment;