CREATE DATABASE company_db;

USE company_db;

CREATE TABLE employees (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  department VARCHAR(50),
  salary INT,
  manager_id INT
);
INSERT INTO employees VALUES
(1, 'Alice',   'HR',      60000, NULL),
(2, 'Bob',     'HR',      55000, 1),
(3, 'Charlie', 'IT',      70000, NULL),
(4, 'David',   'IT',      65000, 3),
(5, 'Eva',     'IT',      62000, 3),
(6, 'Frank',   'Finance', 72000, NULL),
(7, 'Grace',   'Finance', 68000, 6);

select * from employees;

# 1. List all employees with salaries above average.

WITH a AS (SELECT AVG(salary) avg_sal FROM employees)
SELECT * FROM employees WHERE salary > (SELECT avg_sal FROM a);

# 2. Get employees and their manager's names.

WITH m AS (SELECT id, name FROM employees)
SELECT e.name, m.name FROM employees e JOIN m ON e.manager_id = m.id;

# 3. Top 2 highest paid in each department.

WITH r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) rnk
  FROM employees
)
SELECT * FROM r WHERE rnk <= 2;

# 4. Find departments with total salary > 130000.

WITH d AS (
  SELECT department, SUM(salary) total_sal FROM employees GROUP BY department
)
SELECT * FROM d WHERE total_sal > 130000;

# 5. CTE to find duplicates by department and salary.

WITH dup AS (
  SELECT department, salary, COUNT(*) cnt FROM employees GROUP BY department, salary HAVING cnt > 1
)
SELECT * FROM dup;

# 6. CTE to find highest salary per department.

WITH h AS (
  SELECT department, MAX(salary) AS high FROM employees GROUP BY department
)
SELECT * FROM h;

# 7. Filters out employees who are not listed as managers.

WITH m AS (SELECT DISTINCT manager_id FROM employees)
SELECT * FROM employees WHERE id IN (SELECT manager_id FROM m);

# 8. Calculate average salary per department with count.

WITH s AS (
  SELECT department, AVG(salary) avg_sal, COUNT(*) cnt FROM employees GROUP BY department
)
SELECT * FROM s;

# 9. List employees with manager in same department.

WITH x AS (
  SELECT e.name emp, m.name mgr, e.department ed, m.department md
  FROM employees e JOIN employees m ON e.manager_id = m.id
)
SELECT * FROM x WHERE ed = md;

# 10. Identify salary gaps within departments.

WITH g AS (
  SELECT department, MAX(salary) - MIN(salary) gap FROM employees GROUP BY department
)
SELECT * FROM g;

# 11. Find departments with more than 2 employees.

WITH c AS (
  SELECT department, COUNT(*) cnt FROM employees GROUP BY department
)
SELECT * FROM c WHERE cnt > 2;

# 12. List employees earning more than their manager.

WITH cmp AS (
  SELECT e.name emp, e.salary es, m.salary ms FROM employees e JOIN employees m ON e.manager_id = m.id
)
SELECT * FROM cmp WHERE es > ms;

# 13. CTE with UPDATE to give bonus to top earners.

WITH top AS (SELECT id FROM employees ORDER BY salary DESC LIMIT 3)
UPDATE employees SET salary = salary + 5000 WHERE id IN (SELECT id FROM top);

