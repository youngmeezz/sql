-- 문제 1. 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요. 두 임금의 차이는 얼마인가요? 함께 “최고임금 – 최저임금”이란 타이틀로 출력해 보세요.
select MAX(a.salary) as '최고임금', MIN(a.salary) as '최저임금', MAX(a.salary)-MIN(a.salary) as '최고임금-최저임금'
from salaries a;


-- 문제2.
-- 마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
-- 예) 2014년 07월 10일
select MAX(date_format(a.hire_date,'%Y년 %m월 %d일')) as '입사일'
from employees a
order by a.hire_date desc;


-- 문제3.
-- 가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
-- 예) 2014년 07월 10일

select min(date_format(a.hire_date,'%Y년 %m월 %d일')) as '입사일'
from employees a, titles b
where a.emp_no = b.emp_no
AND b.to_date = '9999-01-01';


select concat(first_name,' ',last_name) as name,
		max(period_diff(
        date_format(b.to_date,'%Y%m'),
        date_format(a.hire_date,'%Y%m')))
from employees a, salaries b;

-- where b.to_date-b.from_date
-- rder by a.hire_date desc;


-- 문제4. 현재 이 회사의 평균 연봉은 얼마입니까?

select avg(distinct(a.salary)) as '평균 연봉'
from salaries a
where
	a.to_date = '9999-01-01';
    

select *
from salaries
where to_date ='9999-01-01';

 
-- 문제5. 현재 이 회사의 최고/최저 연봉은 얼마입니까?

select max(a.salary) as '최고 연봉',min(a.salary) as '최저 연봉'
from salaries a
where
	a.to_date = '9999-01-01';
    
-- 문제6. 최고 어린 사원의 나이와 최 연장자의 나이는?
select max(FLOOR( (CAST(REPLACE(CURRENT_DATE,'-','') AS UNSIGNED) - 
       CAST(REPLACE(a.birth_date,'-','') AS UNSIGNED)) / 10000 )) as '최 연장자',
       min(FLOOR( (CAST(REPLACE(CURRENT_DATE,'-','') AS UNSIGNED) - 
       CAST(REPLACE(a.birth_date,'-','') AS UNSIGNED)) / 10000 )) as '최고 어린 사원'
from employees a, salaries b
where
	a.emp_no = b.emp_no
    and
	b.to_date = '9999-01-01';

