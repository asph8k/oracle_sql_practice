-- <- 오라클의 주석표시.
/* 여러 줄 주석 표시. */

-- select 컬럼명(여러개 가능) from 테이블 이름
SELECT * FROM employees;

SELECT employee_id, first_name, last_name FROM employees;

SELECT email, phone_number, hire_date
FROM employees;

-- 컬럼을 조회하는 위치에서 * / + - 연산이 가능하다.
SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    salary + salary*0.1
FROM
    employees;

-- null 값의 확인 (숫자 0이나 공백이랑은 다른 존재이다.)
SELECT department_id, commission_pct
FROM employees;

-- as를 이용하여 컬럼명을 변경(별칭을 붙인다)
-- alias (컬럼명, 테이블명의 이름을 변경해서 조회한다.)
SELECT first_name as 이름, last_name as 성, 
salary as 급여
FROM employees;

-- || = 문자열 연결 기호
-- 오라클은 홑따옴표''로 문자를 표현하고, 문자열 안에 홑따옴표를 
-- 표현하고 싶다면 ''를 두번 연속으로 쓰면 된다.
-- || -> 연결자
SELECT 
first_name || ' ' || last_name || '''s salary is $' || salary as 급여내역
FROM employees;

-- DISTINCT -> 중복값 제거
-- DISTINCT (중복 행의 제거 가능)
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees;

-- ROWNUM, ROWID
-- (**ROWNUM : 쿼리에 의해 반환되는 행 번호를 출력)
-- (ROWID : 데이터베이스에서 행의 주소값을 반환)
SELECT ROWNUM, ROWID, employee_id
FROM employees;


































