CREATE DATABASE company;
use company;

CREATE TABLE employees (
	emp_id int, 
    name varchar(255),
    surname varchar(255),
    departement varchar(255),
    salary float
);

select distinct departement from employees;
select concat(name,'surname') as "Full Name", (salary*0.2) as "Taxes" from employees;
select min(salary), max(salary) from employees;
select departement, avg(salary) from employees
	group by departement;




    
    
