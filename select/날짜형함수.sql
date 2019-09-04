-- indexing 어떤 순서로 실행계획을 짜는게 중요 caching architecture master,slave 샤딩alter
-- 쿼리를 줄이는게 중요한게 아니라 쓸 수 있는 것을 다 쓰도록
-- curdate()함수, current_date상수, curtime()시분초, current_time 시분초까지 나와서 포맷팅해서 사용

-- yyyy,MM,dd
select curdate(), current_date;

-- date는 timestamp로 저장 => hh,mm,ss 
select curtime(), current_time;

-- now(), sysdate(), current_timestamp() => yyyy,MM,dd,hh,mm,ss
select now(),sysdate(),current_timestamp();

-- now(), sysdate() 차이점 2초지연 now는 쿼리가 시작할 때 분석 들어갈때 시간 sysdate는 2초후에 더 느리게 출력 sysdate쓸때 조심 실행중에 구하는 
-- 시간 비교 쿼리 쓸때 now()
-- now() : 쿼리가 실행하기 전에 
-- sysdate() : 쿼리가 실행되면서 
select now(), sleep(2), now(); 
select now(), sleep(2), sysdate();

-- date_format
select date_format(now(),'%Y년 %c월 %d일 %h시 %i분 %s초');
select date_format(sysdate(),'%Y-%m-%d %h:%i:%s');
select date_format(sysdate(),'%y-%c-%e %h:%i:%s%f');


-- period_diff(p1,p2)
-- : YYMM, YYYYMM으로 표기되는 p1과 p2의 차이의 개월을 반환한다.
-- ex) 직원들의 근무 개월 수 구하기
select concat(first_name,' ',last_name) as name,
		period_diff(
        date_format(curdate(),'%Y%m'),
        date_format(hire_date,'%Y%m'))
from employees;

-- date_add = adddate
-- date_sub = subdate
-- (date, INTERVAL expr type)
-- : 날짜 date에 type형식(year, month, day)으로 지정한 expr값을 더하거나 뺀다.
-- ex) 각 직원들의 6개월 후 근무 평가 일
select concat(first_name,' ',last_name) as name,
		hire_date as 입사일,
        date_add(hire_date, INTERVAL 6 month) as '6개월 후 근무 평가일'
from employees;

-- cast date는 날짜 datetime 은 시분초까지 같이 나옴
select now(), cast(now() as date), cast(now() as datetime);

-- unsigned,uint타입 long대신 사용 매우 큰 값 쓸때 사용
select 1-2, cast(1-2 as unsigned);

select cast(cast(1-2 as unsigned) as signed);
