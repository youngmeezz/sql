

-- 문제1.현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
SELECT 
    COUNT(a.emp_no) 
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND b.salary > (SELECT 
            AVG(b.salary)
        FROM
            employees a,
            salaries b
        WHERE
            a.emp_no = b.emp_no
                AND b.to_date = '9999-01-01');

-- 현재 평균 연봉 출력
select avg(b.salary)
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01';


-- 문제2. 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서, 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 

-- select a.emp_no as '사번', a.first_name as '이름', b.dept_no as '부서', c.salary as '연봉'
-- from employees a, departments b, salaries c, dept_emp d
-- where a.emp_no = c.emp_no
-- and a.emp_no = d.emp_no
-- and b.dept_no = d.dept_no
-- group by b.dept_no
-- having max(c.salary) = (select a.dept_no, max(b.salary)
-- from departments a, salaries b, dept_emp c, employees d
-- where b.emp_no = d.emp_no
-- and c.emp_no = d.emp_no
-- and a.dept_no = c.dept_no
-- and b.to_date = '9999-01-01'
-- and c.to_date = '9999-01-01'
-- group by a.dept_no)
-- order by c.salary desc
-- limit 0,1;


-- 각 부서 별로 최고 급여 출력하기
select a.dept_no, max(b.salary)
from departments a, salaries b, dept_emp c, employees d
where b.emp_no = d.emp_no
and c.emp_no = d.emp_no
and a.dept_no = c.dept_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
group by a.dept_no;



 select a.emp_no as '사번', a.first_name as '이름', c.dept_no as '부서', b.salary as '연봉' 
    from employees a,
         salaries b,
         dept_emp c,
         (  select c.dept_no, max(b.salary) as max_salary 
	      from employees a, salaries b, dept_emp c
             where a.emp_no = b.emp_no
               and a.emp_no = c.emp_no
               and b.to_date = '9999-01-01'
               and c.to_date = '9999-01-01'
          group by c.dept_no) d
   where a.emp_no = b.emp_no
     and a.emp_no = c.emp_no
     and c.dept_no = d.dept_no
     and b.salary = d.max_salary
     and b.to_date = '9999-01-01'
     and c.to_date = '9999-01-01'
order by b.salary desc;


-- from employees a join salaries b on a.emp_no = b.emp_no,
-- and dept_emp c = departments d

-- 문제3. 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
select a.emp_no as '사번',a.first_name as '이름', b.salary as '연봉'
from employees a, salaries b, dept_emp c, departments d
where a.emp_no = b.emp_no
and a.emp_no =  c.emp_no
and c.dept_no = d.dept_no
and b.to_date ='9999-01-01'
and c.to_date = '9999-01-01'
and b.salary > any(select avg(a.salary) 
                 from salaries a, employees b, dept_emp c
                 where a.emp_no = b.emp_no
                 and a.emp_no = c.emp_no
                 and a.to_date = '9999-01-01'
                 and b.to_date = '9999-01-01'
                 group by c.dept_no
				 );

-- 부서별 평균 급여 출력하기
select c.dept_no,avg(a.salary) as '부서별 평균 급여'
from salaries a, employees b, dept_emp c, departments d
where a.emp_no = b.emp_no
and b.emp_no = c.emp_no
and c.dept_no = d.dept_no
and a.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
group by c.dept_no;



select a.emp_no as '사번', a.first_name as '이름', b.salary as '연봉'
from employees a, salaries b, dept_emp c, departments d, (select c.dept_no, avg(a.salary) as avg_salary
                                                          from salaries a, employees b, dept_emp c
														  where a.emp_no = b.emp_no
														    and b.emp_no = c.emp_no
														    and a.to_date = '9999-01-01'
														    and c.to_date = '9999-01-01'
														  group by c.dept_no) as t
where a.emp_no = b.emp_no
and a.emp_no =  c.emp_no
and c.dept_no = d.dept_no
and b.to_date ='9999-01-01'
and c.to_date = '9999-01-01'
and c.dept_no = t.dept_no 
and b.salary > t.avg_salary;

-- 문제4.현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요. employees 사원들 사번/매니저 이름 2개 걸어야
-- select * 
-- from
-- (
-- (select a.emp_no as '사번', a.first_name as '이름', c.dept_name as '매니저 이름'
-- from employees a, dept_emp b, departments c
-- where a.emp_no = b.emp_no
-- and b.dept_no = c.dept_no
-- and b.to_date = '9999-01-01') as 'manager_table'
-- and 
-- (select a.emp_no as '사번', a.first_name as '이름', c.dept_name as '부서 이름'
-- from employees a, dept_emp b, departments c
-- where a.emp_no = b.emp_no
-- and b.dept_no = c.dept_no
-- and b.to_date = '9999-01-01') as 'employee_table'
-- );
select a.emp_no as '사번', a.first_name as '사원 이름',d.first_name as '매니저 이름', e.dept_name as '부서 이름'
from employees a, dept_emp b, dept_manager c, employees d, departments e
where a.emp_no = b.emp_no
and b.dept_no = c.dept_no
and d.emp_no = c.emp_no
and b.dept_no = e.dept_no
and e.dept_no = c.dept_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
order by a.emp_no;



-- 문제5. 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select a.emp_no as '사번', a.first_name as '이름', c.title as '직책', b.salary as '연봉'
from employees a, salaries b, titles c, departments d, dept_emp e
where a.emp_no = b.emp_no
and a.emp_no = c.emp_no
and a.emp_no = e.emp_no
and d.dept_no = e.dept_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
and e.to_date = '9999-01-01'
and d.dept_no = (select b.dept_no
from salaries a,departments b, dept_emp c
where a.emp_no = c.emp_no
and c.dept_no = b.dept_no
and a.to_date ='9999-01-01'
and c.to_date ='9999-01-01'
group by b.dept_no
order by avg(a.salary) desc
limit 0,1)
order by b.salary desc;

-- 평균 연봉이 가장 높은 부서 출력
select b.dept_no
from salaries a,departments b, dept_emp c
where a.emp_no = c.emp_no
and c.dept_no = b.dept_no
group by b.dept_no
order by avg(a.salary) desc
limit 0,1;

-- 문제6. 평균 연봉이 가장 높은 부서는? 
select b.dept_name as '부서명'
from dept_emp a, departments b, salaries c
where a.emp_no = c.emp_no
and a.dept_no = b.dept_no
group by b.dept_name
order by avg(c.salary) desc
limit 1;


-- 문제7. 평균 연봉이 가장 높은 직책?

select c.title as '직책'
from employees a, salaries b, titles c
where a.emp_no = b.emp_no
and a.emp_no = c.emp_no
group by c.title
order by avg(b.salary) desc
limit 1;

-- 문제8.현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은? 
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.

select e2.dept_name as '부서이름', a2.first_name as '사원이름', d2.first_name as '매니저이름', g2.salary as '매니저 연봉'
from employees a2, dept_emp b2, salaries c2, employees d2, departments e2, dept_manager f2,salaries g2
where a2.emp_no = b2.emp_no
and a2.emp_no = c2.emp_no
and d2.emp_no = f2.emp_no
and e2.dept_no = f2.dept_no
and b2.dept_no = e2.dept_no
and d2.emp_no = g2.emp_no
and b2.to_date = '9999-01-01'
and c2.to_date = '9999-01-01'
and f2.to_date = '9999-01-01'
and g2.to_date = '9999-01-01'
and  c2.salary > g2.salary;




-- 매니저의 연봉, 이름,
