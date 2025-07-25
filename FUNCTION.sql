/*Function Question */
create database t;

use t;
/* Function to calculate annual salary */
-- Create table
CREATE TABLE employees12 (
  emp_id INT PRIMARY KEY,
  name VARCHAR(50),
  monthly_salary DECIMAL(10,2),
  birth_date DATE,
  age INT
);

-- Insert data
INSERT INTO employees12 (emp_id, name, monthly_salary, birth_date, age)
VALUES
  (1, 'A', 25000.00, '2005-01-25', 35),
  (2, 'B', 2700.00, '2006-02-23', 34),
  (3, 'C', 2300.00, '2004-02-23', 45);



-- Define function correctly


DELIMITER //

CREATE FUNCTION get_annual_salary(monthly DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  RETURN monthly * 12;
END //

DELIMITER ;

-- Use the function
SELECT name, get_annual_salary(monthly_salary) AS annual_salary
FROM employees;


/* Function to check if number is even */

delimiter //
create function is_even(n int)
returns varchar(10)
deterministic
begin
	return if(n%2=0, "Even", "Odd");
End //

delimiter ;

select emp_id, name, is_even(emp_id) as emp_id_type
from employees

/* Function to calculate tax */
delimiter //
create function cal_tax(salary decimal(10,2))
returns decimal(10,2)
deterministic
begin 
	return salary*0.1;
End //

delimiter ;
select name, monthly_salary, cal_tax(monthly_salary) as tax 
from employees;

SHOW FUNCTION STATUS WHERE name = 'cal_tax';