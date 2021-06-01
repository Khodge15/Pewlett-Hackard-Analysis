--CHALLENGE QUIRIES
--1. Deliverable 1: The Number of Retiring Employees by Title

SELECT e.emp_no,
    e.first_name,
e.last_name,
ti.title,
    ti.from_date,
    ti.to_date
INTO reti_title
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no ASC;
-- check table
SELECT * FROM reti_title
-- http://www.postgresqltutorial.com/postgresql-inner-join/

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

INTO nameyourtable
FROM _______
ORDER BY _____, _____ DESC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) to_date,  
emp_no,
first_name,
last_name,
title
INTO reti_title_clean
FROM reti_title
ORDER BY emp_no, to_date DESC;
--https://www.geekytidbits.com/postgres-distinct-on/
SELECT * FROM reti_title_clean



SELECT emp_no, 
first_name,
last_name,
title
INTO unique_title
FROM reti_title_clean
ORDER BY emp_no ASC;

-- Count of titles who are retiring
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_title 
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

-- Deliverable 2: The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON (e.emp_no)   
e.emp_no,
    e.first_name,
e.last_name,
e.birth_date,
ti.title,
    de.from_date,
    de.to_date
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, de.to_date DESC;

-- Summary
-- additional table 1 number of employees in the mentorship program
SELECT COUNT(emp_no), title
INTO mentorship_titles
FROM mentorship_eligibilty 
GROUP BY title
ORDER BY COUNT(emp_no) DESC;

-- compare count of retiring titles and count of mentorship titles
-- add syntax for changing column name in table
SELECT * FROM retiring_titles;
ALTER TABLE retiring_titles RENAME COLUMN count TO retire_count;
SELECT * FROM retiring_titles;

SELECT * FROM mentorship_titles;
ALTER TABLE mentorship_titles RENAME COLUMN count TO mentor_count;
SELECT * FROM mentorship_titles;

--https://stackoverflow.com/questions/174582/how-do-i-rename-a-column-in-a-database-table-using-sql

SELECT rt.title,
rt.retire_count,
mt.mentor_count
INTO title_comparison
FROM retiring_titles as rt
LEFT JOIN mentorship_titles as mt
ON (rt.title = mt.title)
