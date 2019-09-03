-- practice01

SELECT 
    CONCAT(first_name, ' ', last_name) AS '전체 이름'
FROM
    employees
WHERE
    emp_no = '10944';

-- 02) 전체직원의 다음 정보를 조회하세요. 가장 선임부터 출력이 되도록 하세요. 출력은 이름, 성별,  입사일 순서이고 “이름”, “성별”, “입사일로 컬럼 이름을 대체해 보세요.
SELECT 
    CONCAT(first_name, ' ', last_name) AS '이름',
    gender AS '성별',
    hire_date AS '입사일'
FROM
    employees
ORDER BY hire_date ASC;

-- 03) 여직원과 남직원은 각 각 몇 명이나 있나요?
SELECT 
    COUNT(*) AS 여직원
FROM
    employees
WHERE
    gender = 'F';

SELECT 
    COUNT(*) AS 남직원
FROM
    employees
WHERE
    gender = 'M';

SELECT 
    (SELECT 
            COUNT(gender)
        FROM
            employees
        GROUP BY gender
        HAVING gender = 'M') AS '남직원',
    (SELECT 
            COUNT(gender)
        FROM
            employees
        GROUP BY gender
        HAVING gender = 'F') AS '여직원';


-- 04) 현재 근무하고 있는 직원 수는 몇 명입니까? (salaries 테이블을 사용합니다.) 
SELECT 
    COUNT(*) AS 직원수
FROM
    salaries
WHERE
    to_date >= '2019-09-03';

-- 05) 부서는 총 몇 개가 있나요?
SELECT 
    COUNT(*) AS 부서수
FROM
    departments;

-- 06) 현재 부서 매니저는 몇 명이나 있나요?(역임 매너저는 제외)
SELECT 
    COUNT(emp_no) AS '부서 매니저수'
FROM
    dept_manager
WHERE
    to_date LIKE '9999%';


-- 07) 전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세요.
SELECT 
    dept_name
FROM
    departments
ORDER BY LENGTH(dept_name) DESC;

-- 08) 현재 급여가 120,000이상 받는 사원은 몇 명이나 있습니까?
SELECT 
    COUNT(DISTINCT (emp_no)) AS 사원
FROM
    salaries
WHERE
    salary >= 120000
        AND to_date LIKE '9999%';

-- select * from salaries;

SELECT DISTINCT
    title
FROM
    titles
ORDER BY LENGTH(title) DESC;

-- 10) 현재 Enginner 직책의 사원은 총 몇 명입니까?
SELECT 
    COUNT(*) AS '직책의 사원수'
FROM
    titles
WHERE
    title LIKE 'Engineer'
        AND to_date LIKE '9999%';

-- 11) 사번이 13250(Zeydy)인 지원이 직책 변경 상황을 시간순으로 출력해보세요.
SELECT 
    title AS 직책, to_date AS '변경일'
FROM
    titles
WHERE
    emp_no = '13250'
ORDER BY to_date ASC;





