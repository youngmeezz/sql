SELECT 
    AVG(salary), SUM(salary)
FROM
    salaries
WHERE
    emp_no = '10060';
-- 10060까지 가서 그 위에 까지 출력


SELECT 
    emp_no, AVG(salary) AS avg_salary, SUM(salary)
FROM
    salaries
WHERE
    to_date = '9999-01-01'
GROUP BY emp_no
HAVING avg_salary > 40000
ORDER BY avg_salary ASC;


-- 예제1 : 각 사원별로 평균연봉 출력 (~별 group by 사용하기)
-- select avg(salary)
-- from employees
-- group by avg(salary)
-- having salary

SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
ORDER BY AVG(salary) DESC;
 
 -- [과제]예제 2 : 각 현재 Manager 직책 사원에 대한 평균 연봉은?(join 이용해서 풀기)
 
SELECT 
    emp_no, COUNT(*)
FROM
    titles
GROUP BY emp_no;
 
 -- 예제3 : 사원별 몇 번의 직책 변경이 있었는지 조회
SELECT 
    emp_no, COUNT(*)
FROM
    titles
GROUP BY emp_no
ORDER BY COUNT(*) DESC;
 
 -- 204120이 어떻게 승진했는지 과정 확인
SELECT 
    *
FROM
    titles
WHERE
    emp_no = '204120';
 
 -- 오류나는 이유 emp_no가 group by 되지 않아서 오류난다. 그림을 그리면 편하다
SELECT 
    emp_no, COUNT(title)
FROM
    titles;
 
 -- 예제4 : 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 50000 
ORDER BY AVG(salary) DESC;

-- group by 는 ~별 넣어주고 having은 group된것의 조건 넣어주기



-- [과제] 예제 5: 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이 100명 이상인 직책만 출력하세요.

-- [과제] 예제 6:현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.

-- [과제] 예제 7: 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요
       --  단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에
       --  대해서 내림차순(DESC)로 정렬하세요. 


