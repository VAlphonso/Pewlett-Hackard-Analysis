-- Retrieve info from Employees Table
SELECT e.emp_no, e.first_name, e.last_name
FROM employees as e

-- Retrieve info from Titles Table
SELECT t.title, t.from_date, t.to_date
FROM titles as t 

--Creating Retirement Titles by joining employees and titles
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Retrieve info from Retirement Titles
SELECT rt.emp_no, rt.first_name, rt.last_name, rt.title
FROM retirement_titles as rt

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Retrieve number of title from Unique Titles table.
SELECT COUNT (rt.emp_no), ut.title
-- INTO retiring_titles
FROM retirement_titles as rt
LEFT JOIN unique_titles as ut
ON rt.emp_no = ut.emp_no
GROUP BY ut.title 
ORDER BY ut.title DESC;

--------------------------------
--Mentorship Eligibility Table
--------------------------------

-- Retrieve info from Employees Table
SELECT e.emp_no, e.first_name, e.last_name, e.birth_date
FROM employees AS e

-- Retrieve Department Employee table
SELECT de.from_date, de.to_date
FROM dept_emp AS de

--Retrieve Titles table
SELECT t.title
FROM titles as t

-- Use Distinct On
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
--INTO mentorship_eligibility as me
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (de.emp_no = t.emp_no)
WHERE de.to_date = ('9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
GROUP BY de.from_date
ORDER BY e.emp_no



