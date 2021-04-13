--Deliverable 1: The Number of Retiring Employees by Title

SELECT es.emp_no, es.first_name, es.last_name, ti.title, ti.from_date,ti.to_date
INTO retirement_titles
FROM Employees as es
INNER JOIN titles as ti
ON (es.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no 

SELECT * FROM Employees