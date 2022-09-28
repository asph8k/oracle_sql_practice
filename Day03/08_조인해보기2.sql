-- INNER 조인 (내부 조인)
SELECT * FROM info i INNER JOIN auth a
ON i.auth_id = a.auth_id;

-- 오라클 문법 (잘 사용 안함)
SELECT * FROM info i, auth a
WHERE i.auth_id = a.auth_id;

-- auth_id 컬럼을 그냥 쓰면 모호하다 라고 뜸
-- 그 이유는 양쪽 테이블에 모두 존재하기 때문이다.
-- 이럴때 컬럼에 테이블 이름을 붙이던지, 별칭을 써서 지목을 확실하게 해줘야한다.
SELECT info.auth_id, title, content, name
FROM info INNER JOIN auth
ON info.auth_id = auth.auth_id;

-- 필요한 데이터만 조회하겠다! 라고 한다면
-- WHERE 구문을 통해 일반 조건을 걸어주면 된다.
SELECT
    i.auth_id, i.title, i.content,
    a.name
FROM info i INNER JOIN auth a
ON i.auth_id = a.auth_id
WHERE a.name = '홍길자';

-- OUTER JOIN (외부 조인)
SELECT * 
FROM info i LEFT OUTER JOIN auth a
ON i.auth_id = a.auth_id;

SELECT * 
FROM info i RIGHT OUTER JOIN auth a
ON i.auth_id = a.auth_id;

-- 오라클 문번
SELECT *
FROM info i, auth a
WHERE i.auth_id = a.auth_id(+);

-- 좌측 테이블과 우측 테이블 데이터를 모두 읽어서 중복된 데이터는 삭제되는 외부 조인.
SELECT * 
FROM info i FULL OUTER JOIN auth a
ON i.auth_id = a.auth_id;

-- CROSS JOIN은 JOIN조건을 설정하지 않기 때문에 모든 컬럼에 대해 JOIN을 진행
-- 실제로는 거의 사용하지 않는다.
SELECT *
FROM info CROSS JOIN auth
ORDER BY id ASC;

-- 여러 개 테이블 조인 -> 키 값만 찾아서 구문을 연결해서 쓰면 된다.
SELECT *
FROM employees e
LEFT OUTER JOIN departments d ON e.department_id = d.department_id
LEFT OUTER JOIN locations loc ON d.department_id = loc.location_id;

/*
- 테이블 별칭 a, i를 이용하여 LEFT OUTER JOIN 사용.
- info, auth 테이블 사용.
- job 컬럼이 scientist인 사람의 id, title, content, job을 출력.
*/
SELECT
    i.id, i.title, i.content, a.job
FROM auth a LEFT OUTER JOIN info i
ON i.auth_id = a.auth_id
WHERE a.job = 'scientist';

SELECT 
    e1.employee_id, e1.first_name, e1.manager_id,
    e2.first_name, e2.employee_id
FROM employees e1 JOIN employees e2
ON e1.manager_id = e2.employee_id;


-- 문제1
SELECT *
FROM employees emp INNER JOIN departments dep -- 106개
ON emp.department_id = dep.department_id;

SELECT *
FROM employees emp LEFT OUTER JOIN departments dep -- 107개
ON emp.department_id = dep.department_id;

SELECT *
FROM employees emp RIGHT OUTER JOIN departments dep -- 122개
ON emp.department_id = dep.department_id;

SELECT *
FROM employees emp FULL OUTER JOIN departments dep -- 123개
ON emp.department_id = dep.department_id;

-- 문제2
SELECT
    emp.first_name || ' ' || emp.last_name AS 이름,
    emp.department_id
FROM employees emp INNER JOIN departments dep
ON emp.department_id = dep.department_id
WHERE emp.employee_id = 200;

-- 문제3
SELECT
    emp.first_name AS 사원이름, emp.job_id AS 직무아이디, jo.job_title AS 직무타이틀
FROM employees emp INNER JOIN jobs jo
ON emp.job_id = jo.job_id
ORDER BY emp.first_name ASC;
    
-- 문제4
SELECT *
FROM jobs jo LEFT OUTER JOIN job_history joh
ON jo.job_id = joh.job_id;

-- 문제5
SELECT
    e.first_name || ' ' || e.last_name,
    d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE e.first_name = 'Steven'
AND e.last_name = 'King';

-- 문제6
SELECT * 
FROM employees e CROSS JOIN departments d;

-- 문제7
SELECT
    emp.employee_id AS 사원번호, emp.first_name AS 이름, emp.salary AS 급여, 
    dep.department_name AS 부서명, loc.city AS 근무지
FROM employees emp INNER JOIN departments dep
ON emp.department_id = dep.department_id
INNER JOIN locations loc ON dep.location_id = loc.location_id
WHERE emp.job_id = 'SA_MAN';

-- 문제7 강사님 방식
SELECT
    e.employee_id, e.first_name, e.salary,
    d.department_name, loc.city
FROM employees e JOIN departments d
ON e.department_id = d.department_id
INNER JOIN locations loc ON d.location_id = loc.location_id
WHERE e.job_id = 'SA_MAN';

-- 문제8
SELECT
    emp.employee_id,emp.first_name,
    jo.job_title
FROM employees emp INNER JOIN jobs jo
ON emp.job_id = jo.job_id
WHERE job_title IN('Stock Manager', 'Stock Clerk');

-- 문제8 강사님 방식
SELECT
    e.employee_id, e.first_name,
    j.job_title
FROM employees e
JOIN jobs j
ON e.job_id = j.job_id
WHERE job_title IN('Stock Manager', 'Stock Clerk'); -- IN : or함수

-- 문제9
SELECT
    dep.department_name
FROM departments dep LEFT OUTER JOIN employees emp
ON dep.department_id = emp.department_id
WHERE emp.employee_id IS NULL;

-- 문제9 강사님 방식
SELECT
    d.department_name
FROM departments d LEFT OUTER JOIN employees e
ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- 문제10
SELECT
    emp1.first_name,
    emp2.first_name AS manager_name
FROM employees emp1 JOIN employees emp2
ON emp1.manager_id = emp2.employee_id;

-- 문제10 강사님 방식
SELECT
    e1.first_name, e2.first_name AS manager_name
FROM employees e1 JOIN employees e2
ON e1.manager_id = e2.employee_id;

-- 문제11
SELECT
    e1.employee_id, e1.first_name, e1.manager_id,
    e2.first_name, e2.job_id, e2.salary
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL
ORDER BY e1.salary DESC;

-- 문제11 강사님 방식
SELECT
    e1.employee_id, e1.first_name, e1.manager_id,
    e2.first_name, e2.job_id, e2.salary
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL
ORDER BY e1.salary DESC;



























