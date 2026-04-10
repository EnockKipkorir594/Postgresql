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


