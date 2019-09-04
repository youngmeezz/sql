select * from employees limit 20,10;
-- 정렬된 후에 하는게 좋음
-- 게시판 페이지 정렬
SELECT 
    a.title, SUM(b.salary)
FROM
    titles a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
        AND a.title != 'Engineer'
GROUP BY a.title
HAVING SUM(b.salary) > 2000000000
ORDER BY SUM(b.salary) DESC;
