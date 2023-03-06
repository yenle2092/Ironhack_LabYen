## 1. Upload the sql script to create the employees database

USE employees_mod;

## 2. Create a procedure that will provide the average salary of all employees
DELIMITER $$
CREATE PROCEDURE get_avg_sal()
BEGIN
	SELECT avg(salary) FROM t_salaries;
END
$$ DELIMITER ;

CALL get_avg_sal();
##avg_salary : 63151.7301

## 4. Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual,
 ## and returns their employee number.
DELIMITER $$
CREATE PROCEDURE emp_info(first VARCHAR(50), last VARCHAR(50))
BEGIN
	SELECT emp_no FROM t_employees
    WHERE first_name = first AND last_name = last;
END
$$ DELIMITER ;

CALL emp_info('Mayuko','Warwick');
## employee number : 10020

## 5. Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, 
# and returns the salary from the newest contract of that employee. 
# Hint: In the BEGIN-END block of this program, you need to declare and use two variables – v_max_from_date 
#that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.

DELIMITER $$
CREATE FUNCTION emp_info(first VARCHAR(50), last VARCHAR(50))
RETURNS DECIMAL(10,2)
BEGIN
	DECLARE v_max_from_date DATE;
	DECLARE v_salary DECIMAL(10,2);
	SELECT max(from_date) into v_max_from_date FROM t_employees e
	JOIN t_salaries s
    ON s.emp_no=e.emp_no
	WHERE e.first_name=first_name AND e.last_name=last_name;
    
	SELECT s.salary InTO v_salary FROM t_employees e
	JOIN t_salaries s
    ON s.emp_no=e.emp_no
	WHERE e.first_name=first_name AND e.last_name=last_name AND s.from_date = v_max_from_date;
RETURN v_salary;
END
$$ DELIMITER ;

SELECT EMP_INFO('Saniya', 'Kalloufi');
##94556

## 6. Create a trigger that checks if the hire date of an employee is higher than the current date.
# If true, set this date to be the current date. Format the output appropriately (YY-MM-DD)
DELIMITER $$
CREATE TRIGGER check_hire_date
BEFORE INSERT ON t_employees
FOR EACH ROW
BEGIN
	IF NEW.hire_date < DATE_FORMAT(SYSDATE(), '%Y-%M-%D') THEN 
		SET NEW.hire_date = DATE_FORMAT(SYSDATE(), '%Y-%M-%D'); 
	END IF;
END;
$$ DELIMITER ;

## 7. Create ‘i_hire_date’ and Drop the ‘i_hire_date’ index.
CREATE INDEX i_hire_date ON t_employees (hire_date);

DROP INDEX i_hire_date ON t_employees;

## 8. Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum. 
#Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.

SELECT * FROM t_salaries
WHERE salary > 89000;
CREATE INDEX idx_salary ON t_salaries (salary);

## 9. Use Case statement and obtain a result set containing the employee number, first name, and last name of all employees 
#with a number higher than 109990. Create a fourth column in the query, indicating whether this employee is also a manager, 
#according to the data provided in the dept_manager table, or a regular employee

Select *, 
CASE 
	WHEN  emp_no IS NOT NULL THEN "Regular Employee"
END AS position
FROM t_dept_emp
WHERE emp_no > 109990
UNION 
SELECT *,
CASE 
	WHEN  emp_no IS NOT NULL THEN "Manager"
END AS position
FROM t_dept_manager
WHERE emp_no > 109990;

## 10. Extract a dataset containing the following information about the managers: employee number, first name, and last name.
# Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, 
# and another one saying whether this salary raise was higher than $30,000 or NOT

SELECT *,
CASE 
	WHEN salary_raise > 30000 THEN "Higher than 30000"
	ELSE "Less than 30000"
END AS "Higher or Less than 30000"
FROM
	(SELECT 
			A.emp_no, 
            A.first_name, 
            A.last_name, 
            (MAX(salary) - MIN(salary)) as salary_raise
	FROM 
		(SELECT 
				t_dept_manager.emp_no, 
                first_name, 
                last_name
		FROM t_dept_manager
		LEFT JOIN t_employees
		ON t_dept_manager.emp_no = t_employees.emp_no) AS A
	LEFT JOIN t_salaries
	ON A.emp_no = t_salaries.emp_no
	GROUP BY  emp_no) as B;
    
## 11. Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column,
# called “current_employee” saying “Is still employed” if the employee is still working in the company,
# or “Not an employee anymore” if they aren’t. Hint: You’ll need to use data from both the ‘employees’ and 
# the ‘dept_emp’ table to solve this exercise.

SELECT 
		B.emp_no, 
        B.first_name, 
        B.last_name,
CASE 
	WHEN to_date < DATE_FORMAT(SYSDATE(), '%Y-%M-%D') THEN "No"
	ELSE "Yes"
END AS "Is still employed?" 
FROM
	(SELECT 
			t_employees.emp_no,
            t_employees.first_name,
            last_name,
            to_date
	FROM t_employees
	LEFT JOIN t_dept_emp
	ON t_dept_emp.emp_no = t_employees.emp_no
	ORDER BY emp_no asc
	LIMIT 100) as B;


 
 
