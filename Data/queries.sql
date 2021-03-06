

SELECT * FROM departments;

SELECT * FROM public."Employees";

SELECT first_name, last_name
FROM public."Employees"
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM public."Employees"
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM public."Employees"
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM public."Employees"
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM public."Employees"
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM public."Employees"
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM public."Employees"
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM public."Employees"
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and managers tables
SELECT departments.dept_name,
     "Managers".emp_no,
     "Managers".from_date,
     "Managers".to_date
FROM departments
INNER JOIN "Managers"
ON departments.dept_no = "Managers".dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    "Dept_emp".to_date
	FROM retirement_info
	LEFT JOIN "Dept_emp"
	ON retirement_info.emp_no::varchar = "Dept_emp".emp_no;

SELECT * FROM public."Managers";

SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN "Dept_emp" as de
ON ri.emp_no::varchar = de.emp_no;

--Join retirement_info and dept_emp tables in a new table called current_emp
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN "Dept_emp" as de
ON ri.emp_no::varchar = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN "Dept_emp" as de
ON ce.emp_no::varchar = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN "Dept_emp" as de
ON ce.emp_no::varchar = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM "Salaries";
ORDER BY date(to_date) DESC;

SELECT emp_no,
    first_name,
last_name,
    gender
INTO emp_info
 FROM public."Employees"
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT e.emp_no,
    e.first_name,
e.last_name,
    e.gender,
    s.salary,
    de.to_date
	--INTO emp_info
FROM public."Employees" as e
INNER JOIN "Salaries" as s
ON (e.emp_no = s.emp_no)
INNER JOIN "Dept_emp" as de
ON (e.emp_no::varchar = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	  AND (de.to_date = '9999-01-01');
	  
	-- List of managers per department
SELECT  dm.dept_no,
        de.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM "Managers" AS dm
    INNER JOIN Departments AS de
        ON (dm.dept_no = dm.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);  








