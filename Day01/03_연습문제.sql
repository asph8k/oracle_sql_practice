select * from employees;

-- 문제 1번
SELECT employee_id, first_name, hire_date, salary
FROM employees;

-- 문제 2번
SELECT first_name || ' ' || last_name AS name
FROM employees;

-- 문제 3번
SELECT * FROM employees
WHERE department_id = 50;

-- 문제 4번
SELECT first_name, department_id, job_id
FROM employees
WHERE department_id = 50;

-- 문제 5번
SELECT first_name, salary, salary + 300
FROM employees;

-- 문제 6번
SELECT first_name, salary
FROM employees
WHERE salary > 10000;

-- 문제 7번
SELECT first_name, job_id, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

-- 문제 8번
SELECT first_name, hire_date, salary
FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/01';

-- 문제 9번
SELECT first_name, hire_date, salary
FROM employees
WHERE hire_date LIKE '03%';

-- 문제 10번
SELECT first_name, salary
FROM employees
ORDER BY salary DESC;

-- 문제 11번
SELECT first_name, salary
FROM employees
WHERE department_id = 60
ORDER BY salary DESC;

-- 문제 12번
SELECT first_name, job_id
FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'SA_MAN';

SELECT first_name, job_id
FROM employees
WHERE job_id IN ('IT_PROG','SA_MAN');

-- 문제 13번
SELECT 
first_name || ' ' || last_name || '사원의 급여는' ||
salary || '달러 입니다.'
FROM employees;

-- 문제 14번
SELECT first_name, job_id
FROM employees
WHERE job_id LIKE '%MAN';

-- 문제 15번
SELECT first_name, job_id
FROM employees
WHERE job_id LIKE '%MAN'
ORDER BY job_id ASC;














































