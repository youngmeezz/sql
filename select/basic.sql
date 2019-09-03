-- select 기본
-- employees 테이블에서 직원의 이름,  성별, 입사일을 출력
SELECT 
    first_name, last_name, gender, hire_date
FROM
    employees;


-- concat(두개를 합함)
-- employees 테이블에서 직원의 전체이름,  성별, 입사일을 출력
SELECT 
    CONCAT(first_name, ' ', last_name), gender, hire_date
FROM
    employees;

-- alias -> as이고 생략도 가능하다
SELECT 
    CONCAT(first_name, ' ', last_name) AS '긴 이름',
    employees.gender AS '성 별',
    employees.hire_date AS '입사 날짜'
FROM
    employees;

-- 중복 제거 distinct()
-- titles 테이블에서 직급은 어떤 것들이 있는지 직급이름을 한 번씩만 출력
SELECT DISTINCT
    title
FROM
    titles;

-- order by 
-- employees 테이블에서 직원의 전체이름,  성별, 입사일을  입사일 순으로 출력
SELECT 
    CONCAT(first_name, ' ', last_name) AS 전체이름,
    employees.gender AS 성별,
    employees.hire_date AS '입사 날짜'
FROM
    employees
ORDER BY hire_date DESC;

-- salaries 테이블에서 2001년 월급을 가장 높은순으로 사번,월급순으로 출력
SELECT 
    *
FROM
    salaries
WHERE
    from_date LIKE '2001-%'
ORDER BY salary DESC;

-- where (조건절)
-- employees 테이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일을 출력
select concat(first_name,' ',last_name) as '이름',
	gender as '성별',
	hire_date as'입사일'
from employees
where hire_date < '1991-01-01'
order by hire_date desc;

-- where(조건절2)
-- employees 테이블에서 1989년 이전에 입사한 여직원의 이름, 입사일을 출력
select concat(first_name,' ',last_name) as '이름',
	gender as '성별',
	hire_date as'입사일'
from employees
where hire_date < '1989-01-01'
and gender ='f'
order by hire_date desc;

-- IN 사용법 (or 대신에 사용가능 IN ('a','b')a도 되고 b도 됨.
-- dept_emp 테이블에서 부서 번호가 d005나 d009에 속한 사원의 사번, 부서번호 출력
select emp_no,dept_no
from dept_emp
where dept_no = 'd005' or dept_no = 'd009'
;

select emp_no,dept_no
from dept_emp
where dept_no IN('d005','d009')
;

-- Like 검색
-- ex4) employees 테이블에서 1989년에 입사한 직원의 이름,입사일을 출력

select concat(first_name,' ',last_name) as '이름',
	hire_date as'입사일'
from employees
where hire_date <= '1989-12-31' 
and  hire_date >= '1989-01-01'
order by hire_date desc;



