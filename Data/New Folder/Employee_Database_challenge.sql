--Deliverable 1: The Number of Retiring Employees by Title

Select es.emp_no, es.first_name, es.last_name, ti.title, ti.from_date, ti.to_date
Into retirement_titles
from public."Employees" as es 
INNER JOIN public."Titles" as ti
ON (es.emp_no = ti.emp_no)
Where birth_date Between '1952-01-01'and '1955-12-31'
Order by es.emp_no;

SELECT DISTINCT ON (es.emp_no) es.emp_no, es.first_name, es.last_name, ti.title
INTO unique_titles
from "Employees" as es
inner join "Titles" as ti
ON es.emp_no = ti.emp_no
where (es.birth_date between '1952-01-01' AND '1955-12-31')
ORDER BY es.emp_no, ti.to_date DESC;

select count(emp_no) as "count", title
into retiring_titles
from unique_titles
group by title
order by "count" desc;

Deliverable 2: The Employees Eligible for the Mentorship Program

SELECT DISTINCT ON (es.emp_no) es.emp_no,
                    es.first_name,
                    es.last_name,
                    es.birth_date,
                    de.from_date,
                    de.to_date,
                    ti.title
INTO mentorship_eligibility
FROM "Employees" AS es
INNER JOIN "Dept_emp" AS de
ON es.emp_no::varchar = de.emp_no
INNER JOIN "Titles" AS ti
ON (es.emp_no::varchar= de.emp_no)
WHERE (es.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND ti.to_date='9999-01-01'
ORDER BY es.emp_no;

select * from mentorship_eligibility