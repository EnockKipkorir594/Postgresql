--Users Table 
CREATE TABLE users (
    id         SERIAL PRIMARY KEY,
    username   VARCHAR(80) UNIQUE NOT NULL,
    email      VARCHAR(120) UNIQUE NOT NULL,
    role       VARCHAR(20) NOT NULL DEFAULT 'employee',
    is_active  BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);


--employees table 
CREATE TABLE employees (
    id           SERIAL PRIMARY KEY,
    user_id      INTEGER REFERENCES users(id),
    full_name    VARCHAR(100) NOT NULL,
    department   VARCHAR(50) NOT NULL,
    job_title    VARCHAR(100) NOT NULL,
    basic_salary NUMERIC(10,2) NOT NULL,
    date_hired   DATE NOT NULL,
    status       VARCHAR(20) NOT NULL DEFAULT 'active'
);

--attendance table
CREATE TABLE attendance (
    id          SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(id),
    date        DATE NOT NULL,
    status      VARCHAR(20) NOT NULL,
    UNIQUE(employee_id, date)
);

--payroll tale
CREATE TABLE payroll (
    id          SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(id),
    month       VARCHAR(20) NOT NULL,
    basic_salary NUMERIC(10,2) NOT NULL,
    allowances  NUMERIC(10,2) DEFAULT 0,
    gross_pay   NUMERIC(10,2) NOT NULL,
    paye        NUMERIC(10,2) NOT NULL,
    nhif        NUMERIC(10,2) NOT NULL,
    nssf        NUMERIC(10,2) NOT NULL,
    net_pay     NUMERIC(10,2) NOT NULL,
    processed_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(employee_id, month)
);

--Understanding the JOINS query
--JOIN combines two tables based on a related column between them
--Most common relationship is a foreign key 

--employees.user_id links to users.id 
--attendance.employee_id links to employees.id 
--payroll.employee_id links to employees.id

--Using aliases and INNER JOIN 
SELECT 
    e.full_name
    e.department
    u.username
    u.role
FROM employees e 
INNER JOIN users u ON e.user_id = u.id 

--LEFT JOIN what it does
--returns all rows from the left table regardless of whether a match 
--exists on the right table. 

--RIGHT JOIN 
--The mirror image of LEFT JOIN
--Returns all rows from the right table regardless of wether a match
--exists on the left table

--JOINING more than two tables
SELECT 
	u.username,
	e.full_name,
	e.department,
	p.month,
	p.net_pay
FROM users u 
INNER JOIN employees e ON u.id = e.user_id
INNER JOIN payroll p ON e.id = p.employee_id
ORDER BY p.net_pay DESC;


--JOINING more than two tables
SELECT 
	u.username,
	e.full_name,
	e.department,
	a.date,
	a.status
FROM users u 
INNER JOIN employees e ON u.id = e.user_id
INNER JOIN attendance a ON e.id = a.employee_id
WHERE a.date BETWEEN '2020-01-01' AND '2025-07-01'
ORDER BY e.full_name, a.date;

--Department payroll summary
SELECT 
	e.department,
	COUNT(e.id) AS employee_count,
	SUM(p.gross_pay) AS total_gross,
	SUM(p.net_pay) AS total_net,
	ROUND(AVG(p.net_pay), 2) AS avarage_net
FROM employees e
INNER JOIN payroll p ON e.id = p.employee_id
WHERE p.month = 'April-2025' 
GROUP BY  e.department
ORDER BY total_net DESC;

--correlated subqueries 
--A correlated subquery references a column from the outer query
SELECT 
    e1.full_name,
    e1.department,
    e1.basic_salary
FROM employees e1 
WHERE e1.basic_salary > (
    SELECT AVG(e2.basic_salary)
    FROM employees e2 
    WHERE e2.department = e1.department
);

--EXISTS AND NOT EXISTS
--EXISTS checks whether a subquery returns any rows at all 

--Find all employees who have at least one attendance record
SELECT full_name, department
FROM employees e 
WHERE EXISTS(
    SELECT 1 
    FROM attendance a 
    WHERE a.employee_id = e.id
);

--Find employees with no attendance record
SELECT full_name, department
FROM employees e 
WHERE NOT EXISTS(
    SELECT 1 
    FROM attendance a 
    WHERE a.employee_id = e.id
);

--CTEs(Common Table Expressions)
--What are CTEs?
--A CTE is a named temporary result set that you define at the
-- beginning of a query and reference by name within that query. 
WITH department_avarages AS(
    SELECT 
        department,
        ROUND(AVG(basic_salary), 2) AS avg_salary
    FROM employees
    GROUP BY department
),
company_avarage AS (
    SELECT ROUND(AVG(basic_salary)) AS avg 
    FROM employees
)
SELECT 
    da.avg_salary,
    da.department
FROM department_avarages da, company_avarage ca 
WHERE da.avg_salary > ca.avg
ORDER BY da.avg_salary DESC;



