-- 단일행 연산

SELECT 
    b.emp_no, a.dept_no
FROM
    dept_emp a,
    employees b
WHERE
    a.emp_no = b.emp_no
        AND to_date = '9999-01-01'
        AND CONCAT(b.first_name, ' ', b.last_name) = 'Fai Bale';

-- sol 1-2)
SELECT 
    b.emp_no AS '사번',
    CONCAT(b.first_name, ' ', b.last_name) AS '이름'
FROM
    dept_emp a,
    employees b
WHERE
    a.emp_no = b.emp_no
        AND to_date = '9999-01-01'
        AND a.dept_no = 'd004';

-- sol subquery를 사용)
SELECT 
    b.emp_no AS '사번',
    CONCAT(b.first_name, ' ', b.last_name) AS '이름'
FROM
    dept_emp a,
    employees b
WHERE
    a.emp_no = b.emp_no
        AND to_date = '9999-01-01'
        AND a.dept_no = (SELECT 
            a.dept_no
        FROM
            dept_emp a,
            employees b
        WHERE
            a.emp_no = b.emp_no
                AND to_date = '9999-01-01'
                AND CONCAT(b.first_name, ' ', b.last_name) = 'Fai Bale');

-- 서브쿼리는 괄호로 묶여야 함
-- 서브쿼리 내에서는 order by 금지
-- group by 절 외에 거의 모든 절에서 사용 가능
-- 특히 from절과 where절에서 많이 사용함
-- where 절인 경우 , 
-- 1) 단일행 연산자 : = , > , < , >=, <=, <>


SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS 이름,
    b.salary AS 급여
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
GROUP BY b.salary
HAVING AVG(b.salary) > b.salary;


-- 서브쿼리 만들어주기 평균이 작아야 하니 where절에 salary < (평균연봉뽑는 쿼리뽑기)
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS 이름,
    b.salary AS 급여
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND salary < (SELECT 
            AVG(salary)
        FROM
            salaries
        WHERE
            to_date = '9999-01-01');
            
-- 실습문제 2:   현재 가장 적은 평균 급여를 받고 있는 직책에해서  평균 급여를 구하세요 
-- 직책별로 평균 급여 구하고 min을 가진 직책  

SELECT 
    AVG(a.salary)
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
ORDER BY AVG(salary) ASC
LIMIT 0 , 1;

-- 57317.5736 round 반올림
SELECT 
    AVG(a.salary)
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
HAVING ROUND(AVG(a.salary)) = ROUND(57317.5736);


-- 방법 1 : TOP-k를 사용하는 방법 
-- mssql은 top
-- mysql limit
-- oracle rownum
SELECT 
    AVG(a.salary)
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
HAVING round(AVG(a.salary)) = (select round(
    AVG(a.salary))
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
ORDER BY AVG(salary) ASC
limit 0,1);



-- 방법 2 : from절 서브쿼리 및 집계함수 min 을 사용
-- 테이블을 서브쿼리에 넣을 경우에는 alias 필수 as a

SELECT 
    AVG(a.salary)
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
HAVING ROUND(AVG(a.salary)) = (SELECT 
        MIN(a.avg_salary)
    FROM
        (SELECT 
            ROUND(AVG(a.salary)) AS avg_salary
        FROM
            salaries a, titles b
        WHERE
            a.emp_no = b.emp_no
                AND a.to_date = '9999-01-01'
                AND b.to_date = '9999-01-01'
        GROUP BY b.title) AS a);
        
        
-- 방법 3 : join으로 만 풀기(굳이 서브쿼리 쓸 필요가 없다)

SELECT 
    b.title, ROUND(AVG(a.salary))
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
ORDER BY AVG(salary) ASC
LIMIT 0 , 1;

-- where절인 경우
-- 2) 다중(복수행)행 연산자 : in, not in, any, all
-- 2-1) any 사용법
-- 		1. =any : in와 완전동일
-- 		2. >any , >=any : 최소값 찾기
-- 		3. <any , <=any : 최대값 찾기
-- 		4. <>any, !=any : !=all 와 동일
-- 2-2) all 사용법
-- 		1. =all 
-- 		2. >all , >=all : 최대값 찾기
-- 		3. <all , <=all : 최소값 찾기
-- 		4. <>all, !=all : !=all 와 동일

-- 1) 현재 급여가 50000 이상인 직원 이름 출력

-- 방법 1 : join으로 해결하기
select b.first_name
	from salaries a , employees b
where a.emp_no = b.emp_no
and a.salary >= 50000
and a.to_date = '9999-01-01';


-- 방법2 : IN으로 subquery로 푸는 방법 
SELECT 
    a.first_name
FROM
    employees a
WHERE
    a.emp_no IN (SELECT 
            emp_no
        FROM
            salaries
        WHERE
            to_date = '9999-01-01'
                AND salary > 50000);



SELECT 
    a.first_name
FROM
    employees a
WHERE
    a.emp_no = any (SELECT 
            emp_no
        FROM
            salaries
        WHERE
            to_date = '9999-01-01'
                AND salary > 50000);

-- 2) 각 부서별로 최고월급을 받는 직원의 이름과 월급출력
-- dept_no first_name, max_salary  /// where절 서브쿼리 사용 / 조인 사용 서브쿼리랑 조인 호환해서 사용하기
-- 직원 이름과 월급 출력
select a.first_name,b.salary
from employees a, salaries b, departments c, dept_emp d
where a.emp_no = b.emp_no
and a.emp_no = d.emp_no
and c.dept_no = d.dept_no
and b.emp_no IN (select max(e.salary)
from salaries e)
group by c.dept_no;

-- 각 부서별 월급 출력
select min(k.salary)
from(
select 
c.dept_name as '부서이름', a.salary as '월급'
from salaries a, dept_emp b, departments c
where a.emp_no = b.emp_no
and b.dept_no = c.dept_no
group by b.dept_no
order by a.salary desc) as k;

-- 조인 걸때
-- DEPT_EMP SALES랑 DIRECT로 걸지 말고 한 부서 안에 오래있는데 급여는 계속 바뀔 경우 조인이 성립하지 않음
-- EMPLOYEE랑 DEPT_EMP랑 조인하고 EMPLOYEE랑 SALARIES랑 조인

-- 각 부서별 최고 월급
-- 그룹 바이를 DEPT_NO로 하기 PK랑 FK랑 걸기 
SELECT 
    b.dept_no as '부서', max(c.salary) as max_salary
FROM
    employees a,
    dept_emp b,
    salaries c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
GROUP BY b.dept_no;


-- 방법 1 : where절에 subquery사용


SELECT 
    a.first_name as '이름', b.dept_no as '부서', c.salary as '월급'
FROM
    employees a,
    dept_emp b,
    salaries c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
		AND (b.dept_no, c.salary) = any (SELECT 
    b.dept_no as '부서', max(c.salary) as max_salary
FROM
    employees a,
    dept_emp b,
    salaries c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
GROUP BY b.dept_no);



-- 방법 2 : from절에 subquery사용


SELECT 
    a.first_name as '이름', b.dept_no as '부서', c.salary as '월급'
FROM
    employees a,
    dept_emp b,
    salaries c,
   ( SELECT 
    b.dept_no as '부서', max(c.salary) as max_salary
FROM
    employees a,
    dept_emp b,
    salaries c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
GROUP BY b.dept_no) d
WHERE
    a.emp_no = b.emp_no
AND a.emp_no = c.emp_no
AND c.salary = d.max_salary
AND b.to_date = '9999-01-01'
AND c.to_date = '9999-01-01';

-- 강사님 풀이

select *, (select now()) from employees;

-- insert,update,delete -> transaction이 중요 하나씩 실행되어야 함 business task 를 만드는것
-- business = task(일,업무)
-- 이체업무(task,tx)
-- update account
-- set values valance + 금액
-- where no = 받는사람 계좌번호

-- update account
-- set valance = valance - 금액
-- where no = 보내는사람 계좌번호

-- transaction관리 db에 transaction 매니저가있는데 디비에 바로 진짜 DB에 반영 못하게
-- ok되면 commit해서 실제 디비에 반영
-- rollback시켜서 디비 반영안하게 하기



