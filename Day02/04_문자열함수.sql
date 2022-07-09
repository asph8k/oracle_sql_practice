
-- lower(소문자), initcap(앞글자만 대문자), upper(대문자)

SELECT * FROM dual;

/*
dual이라는 테이블은 sys가 소유하는 오라클의 표준 테이블로서,
 오직 한 행에 한 컬럼만 담고 있는 dummy 테이블이다.
 일시적인 산술 연산이나 날짜 연산 등을 주로 사용한다.
 모든 사용자가 접근할 수 있다.
*/
SELECT 'abcDEF', lower('abcDEF'), upper('abcDEF')
FROM dual;

SELECT last_name, lower(last_name), INITCAP(last_name), upper(last_name)
FROM employees;

SELECT last_name FROM employees
WHERE lower(last_name) = 'austin';

-- length(길이), instr(문자 찾기. 없으면 0값 나옴, 인덱스값.
SELECT 'abcdef' AS ex, LENGTH('abcdef'), INSTR('abcdef', 'a')
FROM dual;

SELECT first_name, LENGTH(first_name), INSTR(first_name, 'a')
FROM employees;

-- substr(문자열 자르기), concat(문자 연결) 1부터 시작
SELECT 'abcdef' AS ex,
SUBSTR('abcdef', 1, 4), CONCAT('abc', 'def')
FROM dual;

SELECT first_name, SUBSTR(first_name, 1, 3),
CONCAT(first_name, last_name)
FROM employees;

-- LPAD, RPAD (좌, 우측 지정문자열로 채우기)
SELECT LPAD('abc', 10, '*') FROM dual;
SELECT RPAD('abc', 10, '*') FROM dual;

-- LTRIM(), RTRIM(), TRIM() 공백 제거
SELECT LTRIM('javascript_java', 'java') FROM dual;
SELECT RTRIM('javascript_java', 'java') FROM dual;
SELECT TRIM('     JAVA    ') FROM dual;

-- REPLACE()
SELECT REPLACE('My dream is a president', 'president', 'doctor')
FROM dual;

SELECT REPLACE('My dream is a president', ' ', '')
FROM dual;

SELECT REPLACE(REPLACE('My dream is a president', 'president', 'doctor'), ' ', '')
FROM dual;

SELECT REPLACE(CONCAT('hello ', 'world!'), '!', '?')
FROM dual;

-- 연습문제 1번
SELECT
    RPAD(SUBSTR(first_name, 1, 3), LENGTH(first_name), '*') AS name,
    LPAD(salary, 10, '#') AS salary
FROM employees
WHERE LOWER(job_id) = 'it_prog';

-- 문제 1
SELECT CONCAT(first_name, last_name) AS 이름,
REPLACE(hire_date, '/', '') AS 입사일자
FROM employees
ORDER BY 이름 ASC;

-- 문제 2
SELECT 
CONCAT('(02)', SUBSTR(phone_number, 4, LENGTH(phone_number))) AS phone_number
FROM employees;



















