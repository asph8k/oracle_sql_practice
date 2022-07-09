
-- 형 변환함수 TO_CHAR, TO_NUMBER, TO_DATE

-- 날짜를 문자로 TO_CHAR(값, 형식)
SELECT TO_CHAR(sysdate) FROM dual;
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH:MI:SS') FROM dual;
SELECT TO_CHAR(sysdate, 'YY-MM-DD HH24:MI:ss') FROM dual;

-- 사용하고 싶은 문자를 ""로 묶어 전달합니다.
SELECT first_name, TO_CHAR(hire_date, 'YYYY"년" MM"월" DD"일"')
FROM employees;

-- 숫자를 문자로 TO_CHAR(값, 형식)
SELECT TO_CHAR(20000, '99999') FROM dual;
-- 주어진 자릿수에 숫자를 모두 표기할 수 없어서 모두 #으로 표기됩니다.
SELECT TO_CHAR(20000, '9999') FROM dual;
SELECT TO_CHAR(20000.21, '99999.9') FROM dual;
SELECT TO_CHAR(20000, '99,999') FROM dual;

SELECT TO_CHAR(salary, 'L99,999') AS salary
FROM employees;

-- 문자를 숫자로 TO_NUMBER(값, 형식)
SELECT '2000' + 2000 FROM dual; -- 자동 형 변환
SELECT TO_NUMBER('2000') + 2000 FROM dual; -- 명시적 형 변환
SELECT '$3,300' + 2000 FROM dual; -- 에러
SELECT TO_NUMBER('$3,300', '$9,999') + 2000 FROM dual;

-- 문자를 날짜로 변환하는 함수 TO_DATE(값, 형식)
SELECT TO_DATE('2021-11-25') FROM dual; -- 기본 형태
SELECT sysdate - TO_DATE('2021-03-25') FROM dual; -- 날짜로 변환해야 연산이 가능
SELECT TO_DATE('2020/12/25', 'YY-MM-DD') FROM dual;
-- 주어진 문자열을 모두 변환해야 합니다.
SELECT TO_DATE('2021-03-31 12:23:50', 'YYYY-MM-DD HH:MI:SS') FROM dual;

-- xxxx년 xx월 xx일 문자열 형식으로 변환해 보세요.
-- 조회 컬럼명은 dateInfo로 하겠습니다.
SELECT '20050102' FROM dual;
SELECT
    TO_CHAR(
        TO_DATE('20050102', 'YYYY/MM/DD'), 
        'YYYY"년" MM"월" DD"일"'
    ) AS dateinfo
FROM dual;

-- NULL 제거 함수 NVL(컬럼, 변환할 타겟값)
SELECT null FROM dual;
SELECT NVL(null, 0) FROM dual;

SELECT
    first_name,
    NVL(commission_pct, 0) AS comm_pct
FROM employees;

-- NULL 제거함수 NVL2(컬럼, null이 아닐 경우 값, null일 경우 값)
SELECT NVL2(null, '널아님', '널임') FROM dual;

SELECT first_name, NVL2(commission_pct, 'true', 'false')
FROM employees;

SELECT
    first_name,
    commission_pct,
    NVL2(commission_pct, salary + (salary * commission_pct), salary) AS real_salary
FROM employees;

-- DECODE(컬럼 혹은 표현식, 항목1, 결과1, 항목2, 결과2 .......... default)
SELECT
    DECODE('F', 'A', 'A입니다.', 'B', 'B입니다.', 'C', 'C입니다.', '모르겠는데요~')
FROM dual;

SELECT
    job_id,
    salary,
    DECODE(
        job_id, 'IT_PROG', 
        salary*1.1, 'FI_MGR', 
        salary*1.2, 'AD_VP', salary*1.3, 
        salary
        ) AS result
FROM employees;

-- CASE WHEN THEN END
SELECT
    first_name,
    job_id,
    salary,
    (CASE job_id
        WHEN 'IT_PROG' THEN salary*1.1
        WHEN 'FI_MGR' THEN salary*1.2
        WHEN 'FI_ACCOUNT' THEN salary*1.3
        WHEN 'AD_VP' THEN salary*1.4
        ELSE salary
    END) AS result
FROM employees;

-- 연습문제 1
SELECT
    employee_id AS 사원번호,
    CONCAT(first_name, last_name) AS 사원명,
    hire_date AS 입사일자,
    TRUNC((sysdate-hire_date) / 365) AS 근속년수
FROM employees
WHERE (sysdate-hire_date) / 365 >= 15
ORDER BY 근속년수 DESC;

-- 문제 2
SELECT
    first_name,
    manager_id,
    DECODE(
        manager_id, 
        100, '사원', 
        120, '주임', 
        121, '대리', 
        122, '과장', 
            '임원') AS 직급
FROM employees
WHERE department_id = 50;
















