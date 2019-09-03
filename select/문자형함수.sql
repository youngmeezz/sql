-- upper
-- 1.자바 upperCase보다 DB의 upper()가 훨씬 빠르다.
-- 2.웬만한 DB에서 문자열 처리 뿐만아니라 포맷팅 처리 등을 다 해주고 
-- 자바에서는 출력만 한다.
-- 3.자바 코드가 간결해서 좋다.
select upper('SEOUL'), ucase('seoul'); 
select upper(first_name) from employees;

-- db에서 다 해결해서 가져오는게 훨씬 빠르다는데? 


-- lower
select lower('SEoul'), lcase('SEOUL');

-- substring
select substring('Happy Day',3,2);

select first_name as '이름', substring(hire_date,1,4) as '입사년도'
from employees;

-- lpad, rpad (padding 정렬) lpad(3번째칸에는 빈공간에 넣을 값)
select lpad('1234',10,'-');
select rpad('1234',10,'-');

-- ex1) salaries 테이블에서 2001년 급여가 70000불 이하의 직원만 
-- 사번, 급여로 출력하되 급여는 10자리로 부족한 자리수는 *로 표시
-- salary는 Integer형이라서 캐스트해줘서 char로 바꿔줘야 함.
select emp_no, lpad(cast(salary as char),10,'*')
from salaries
where from_date like '2001%'
and salary < 70000;

-- ltrim, rtrim, trim
select ltrim('   hello    ') as 'LTRIM';
select concat('------',ltrim('      hello    '),'---') as 'LTRIM';
select concat('------',rtrim('   hello    '),'------') as 'RTRIM';
select concat('------',trim('    hello    '),'------') as 'TRIM';
--  특정 문자를 없앰 trim(both(leading,trailing) 'x' from 'xxxhelloxxxx')
select concat('------',trim(both 'x' from 'xxxxxhelloxxxxx'),'------') as 'TRIM';

-- 앞쪽 특정 문자만 없앰 leading
select concat('------',trim(leading 'x' from 'xxxxxhelloxxxxx'),'------') as 'TRIM';

-- 뒤쪽 특정 문자만 없앰 trailing
select concat('------',trim(trailing 'x' from 'xxxxxhelloxxxxx'),'------') as 'TRIM';




