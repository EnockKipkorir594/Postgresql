--creates student table with name,age,grade as the column
--id is set to pimary ke 
CREATE TABLE Students(
	id	SERIAL PRIMARY KEY,
	name	VARCHAR(100) NOT NULL,
	age		INTEGER,
	grade	DECIMAL(4,2)
);

-- inserting values to the Students table 
INSERT INTO Students(name, age, grade)
VALUES 
('Alex Rider', 17, 90.5),
('Arvid Lindblad', 18, 89.7),
('Percy Mercel', 23, 77.8),
('Gerrad Martin', 21, 96.9),
('Sofia Steffan', 19, 88.9)

--Created a table called staff with name, salary, department,status, hire_year,bonus as columns
CREATE TABLE staff (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100),
	salary NUMERIC(10,2),
	department VARCHAR(20),
	status VARCHAR(20),
	hire_year INTEGER,
	bonus NUMERIC(10,2)
);


--Inserted the followig values into the staff table
INSERT INTO staff(name, department, status, salary, bonus, hire_year)
VALUES
('Alice Webb',   'Engineering',  85000,  'active',   2020, 5000),
('Brian Griffin',    'HR',           52000,  'active',   2021, 3000),
('Carol Johnson',   'Engineering',  91000,  'active',   2019, 7000),
('David Cooper',     'Finance',      67000,  'inactive', 2018, NULL),
('Eve Smith',      'HR',           55000,  'active',   2022, 3000),
('Frank Himenez',  'Engineering',  78000,  'active',   2021, 5000),
('Grace Paulson',    'Finance',      72000,  'active',   2020, 4000),
('Henry Ford',    'HR',           49000,  'inactive', 2017, NULL),
('Irene Simpson',    'Engineering',  95000,  'active',   2023, 8000),
('James Richards',    'Finance',      63000,  'active',   2022, 4000);


--LAG AND LEAD
--LAG and LEAD allow access to previous and following rows within the partition
SELECT 
	full_name,
	month,
	net_pay,
	LAG(net_pay) OVER(
		PARTITION BY employee_id
		ORDER BY month
	)AS previous_month_pay,
	net_pay - LAG(net_pay) OVER(
		PARTITION BY employee_id
		ORDER BY month
	)AS month_to_month_pay

FROM payroll
JOIN employees ON payroll.employee_id = employees.id
ORDER BY full_name, month;

--LEAD
SELECT 
	full_name,
	month,
	net_pay,
	LEAD(net_pay) OVER(
		PARTITION BY employee_id
		ORDER BY month
	)AS next_month_pay
FROM payroll
JOIN employees ON payroll.employee_id = employees.id
ORDER BY full_name, month;

--FIRST_VALUE , LAST_VALUE 
SELECT 
	full_name,
	deparment,
	basic_salary,
	FIRST_VALUE(basic_salary) OVER (
		PARTITION BY department
		ORDER BY basic_salary DESC
	)AS top_highest_earner,
	FIRST_VALUE(full_name) OVER(
		PARTITION BY department
		ORDER BY basic_salary DESC
	)AS name_of_top_earner

FROM employees
ORDER BY department, basic_salary DESC;

--NTILE - Dividing Into Buckets
--NTILE divided rows within a partition into a specified number of roughly equal groups
--and assigns a group to each row

