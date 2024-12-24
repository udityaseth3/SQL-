create database x;
use x;
create table employees(
emp_id int,
name varchar(50),
department varchar(50),
salary int);
insert into  employees(emp_id,name,department,salary)values
(1,'john','hr',5000),
(2,'alice','it',7000),
(3,'bob','finance',6000),
(4,'eve','it',8000),
(5,'charlie','finanace',7500);

create table department(
dep_id int,
dept_name varchar(60));
insert into department(dep_id,dept_name)values
(1,'hr'),
(2,'it'),
(3,'finance');

#1  Find employees with salaries greater than the average salary of all employees. gf
select name from employees where salary > (select avg(salary) from employees);

#2 Find employees whose salary is higher than the salary of 'Alice'. 
select salary from employees where salary > (select salary from employees where name = "alice");

#3 List employees who belong to a department that has the name 'IT'. 
select  name from employees where  department = "it";

#4 Get the names of employees who earn the highest salary in their department.
select name  from employees where department = (select department from employees group by department having salary= max(salary));

#5 Retrieve the departments where at least one employee earns more than 7000.
select department from employees where 	emp_id in (select emp_id from employee group by emp_id having salary > 7000);

#6 List employees who do not belong to any department in the departments table. 
select name from employees where department not in ( select dept_name from department);

#7 Find the second-highest salary among employees
select max(salary) from employees where salary < (select max(salary) from employees );

#8 Retrieve the names of employees who work in the department with the highest number of employees. 

#9 Find employees who earn more than the average salary in their department. 
select  name, Department, Salary from employees  join (select department, avg(Salary) as AvgSalary from employees group by department) department on employees.Department = department.Department where employees.Salary > department.AvgSalary;

#10 Retrieve employees whose salary is above 7000 and belong to departments in the departments table. 
select  name, department from employees  where emp_id in (select emp_id from department d group by  d.dep_id having salary>7000 );

#11 List all departments that have no employees. 
select name, department from employees where department  in (select  department from employee where emp_id is  null);

#12 Find employees who have the same salary as another employee in a different department.
select name from employees e where salary  in (select salary from employees e where e.emp_id<>e.department);

#13 Get the total salary of the department with the maximum total salary. 
select sum(salary) from employees where department = (select department from employees group by department  order by sum(salary) desc limit 1);

 #14. Retrieve employees whose department has more than two employees.
select name from employees where department = (select department from employees group by department having count(emp_id)>1);

#15  Find employees whose salary is higher than the average salary of employees in the IT department. 
select name from employees where salary > (select avg(salary) from employees where department = "it");
















