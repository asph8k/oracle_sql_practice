-- 오라클에서 제공하는 dual 더미테이블(아무런 데이터가 없음 오로지 결과값 확인 해주는 용도)
-- lower(소문자), initcap(앞글자만 대문자), upper(대문자)

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

-- length(길이), instr(문자 찾기. 없으면 0 나옴, 인덱스값으로 처리)
SELECT 'abcdef' AS ex, LENGTH('abcdef'), INSTR('abcdef','a')
FROM dual;

SELECT first_name, LENGTH(first_name), INSTR(first_name,'a')
FROM employees;

-- substr(문자열 자르기), concat(문자 연결) 1부터 시작
SELECT 'abcdef' AS ex,
SUBSTR('abcdef', 1, 4), CONCAT('abc','def')
FROM dual;

SELECT first_name, SUBSTR(first_name, 1, 3),
CONCAT (first_name, last_name)
FROM employees;

-- LPAD, RPAD (좌, 우측 지정문자열로 채우기)
SELECT LPAD('abc', 10, '*') FROM dual;
SELECT RPAD('abc', 10, '*') FROM dual;





























