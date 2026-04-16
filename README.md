# Learning Postgresql
Today is day 8 of learning postgresql these are some of the commands I learned today:

- **INNER JOIN** : returns only rows where a match exists in both tables
- **LEFT JOIN** : returns all rows from the left table
- **RIGHT JOIN**: returns all rows from the right table

## Postgresql queries 
### INNER JOIN
```sql
SELECT
  e.full_name,
  e.department,
  u.username,
  u.role
FROM employees e
INNER JOIN users u ON u.id = e.user_id;

```
Combines the employees table with the users table by implementing aliases **e** and **u**. 
### LEFT JOIN 
The LEFT JOIN returns all rows from the left table regardless whether a match exists on the 
right table 

```sql
SELECT
  e.full_name,
  e.department,
  p.month,
  p.net_pay
FROM employees e
LEFT JOIN payroll p ON e.id = p.employee_id
ORDER BY e.full_name;
```

### RIGHT JOIN 
Returns all rows from the right table regardless of wether a match exists on the right table

```sql
SELECT
  e.full_name,
  p.net_pay
FROM employees e
RIGHT JOIN payroll p ON e.id = p.employee_id;
```

### Joining more than two tables
```sql
SELECT
  u.username,
  e.full_nane,
  e.department,
  p.date,
  p.status
FROM users u
INNER JOIN employees e ON u.id = e.user_id
INNER JOIN payroll p ON e.id = p.employee_id
WHERE a.date BETWEEN 2019-01-01 AND 2025-12-31
ORDER BY e.full_name, a.date;
```
### Practice Exercises

* Show all employees with their username and emailfrom the users table. Use INNER JOIN.

* Show all employees and their net pay for April 2025.Include employees who have not been paid yet
   showing NULL for their payroll columns. Use LEFT JOIN.

* Show the full name, department, date, and attendancestatus for all attendance records in April 2025.
   Order by full name then date.

* Find all employees who have NO attendance recordsat all. Hint: LEFT JOIN then IS NULL.

* Show username, full name, department, and net payfor all employees who were paid in April 2025.
   This requires joining three tables.

* Show each department's total net pay for April 2025,number of employees paid, and average net pay.
   Order by total net pay descending.

* Show all active employees with a count of how manytimes they were present, absent, and on leave
   in April 2025. Include employees with zero attendance records showing 0 for all counts.













