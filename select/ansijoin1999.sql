-- ANSI JOIN 1999

-- 1. join ~on (ANSI JOIN)
SELECT 
    a.first_name, b.title
FROM
    employees a
        JOIN
    titles b ON a.emp_no = b.emp_no;


-- 2. natural join
SELECT 
    a.first_name, b.title
FROM
    employees a
        NATURAL JOIN
    titles b;

-- 2-1.natural join의 문제점 
select count(*)
	from salaries a 
natural join titles b;

-- 2-2. join ~using => natural join의 문제점 -> join ~using
select count(*)
	from salaries a 
    join titles b using(emp_no);