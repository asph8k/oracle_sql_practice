/*
# 서브쿼리
- 서브쿼리의 사용방법은 ()안에 명시함.
  서브쿼리절의 리턴행이 1줄 이하여야 한다.
- 서브쿼리 절에는 비교할 대상이 하나 반드시 들어가야 한다.
- 해석할 때는 서브쿼리절부터 먼저 해석하면 된다.
*/

-- 'Nancy'의 급여보다 급여가 많은 사람을 검색하는 문장
SELECT salary FROM employees WHERE first_name = 'Nancy';

-- 서브쿼리 
SELECT * FROM employees 
WHERE salary > (SELECT salary 
                FROM employees 
                WHERE first_name = 'Nancy');
                
-- employee_id가 103번인 사람과 job_id가 동일한 사람을 검색하는 문장
SELECT * FROM employees
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 103);

-- 다음 문장은 서브쿼리의 리턴 행이 여러개라서 단일행 연산자를 사용 할 수 없다.
-- 이런 경우에는 다중행 연산자를 사용해야 한다.
SELECT * FROM employees               
WHERE job_id = (SELECT job_id 
                FROM employees 
                WHERE job_id = 'IT_PROG'); -- 에러
                
-- 다중행 연산자 
-- IN : 목록의 어떤 값과 같은지 확인한다.
SELECT * FROM employees               
WHERE job_id IN (SELECT job_id 
                FROM employees 
                WHERE job_id = 'IT_PROG');
                
-- first_name이 David인 사람 중 가장 작은 값보다 급여가 큰 사람을 조회.
SELECT salary FROM employees WHERE first_name = 'David';

-- ANY : 값을 서브쿼리에 의해 리턴된 각각의 값과 비교한다.
-- 하나라도 만족하면 된다.
SELECT * 
FROM employees 
WHERE salary > ANY(SELECT salary 
                   FROM employees 
                   WHERE first_name = 'David');
                   
-- ALL : 값을 서브쿼리에 의해 리턴된 값과 모두 비교하여 모두 만족해야 한다.
SELECT * 
FROM employees 
WHERE salary > ALL(SELECT salary
                   FROM employees 
                   WHERE first_name = 'David');
                   
-- 스칼라 서브쿼리
-- SELECT 구문에 서브쿼리가 오는 것. LEFT OUTER JOIN과 유사한 결과.
SELECT 
    e.first_name, d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.first_name ASC;

SELECT
    e.first_name,
    (
       SELECT department_name
       FROM departments d
       WHERE d.department_id = e.department_id
    ) AS department_name
FROM employees e
ORDER BY first_name ASC;

/*
- 스칼라 서브쿼리가 조인보다 좋은 경우
: 함수처럼 한 레코드당 정확히 하나의 값만을 리턴할 때

- 조인이 스칼라 서브쿼리보다 좋은 경우
: 조회할 데이터가 대용량인 경우, 해당 데이터가
수정, 삭제 등이 번번한 경우
*/

-- 각 부서의 매니저의 이름
-- LEFT OUTER JOIN
SELECT 
    d.*, e.first_name
FROM departments d LEFT OUTER JOIN employees e
ON d.manager_id = e.employee_id
ORDER BY d.manager_id ASC;

-- 스칼라 서브쿼리
SELECT 
    d.*,
    (
        SELECT first_name
        FROM employees e
        WHERE e.employee_id = d.manager_id 
    ) AS manager_name
FROM departments d
ORDER BY d.manager_id ASC;

-- 각 부서별 사원수 뽑기 (departments의 모든 컬럼, 사원 수를 별칭을 지어서 출력)
SELECT
    d.*,
    (
        SELECT COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
        GROUP BY department_id
    ) AS 사원수
FROM departments d;

-- 인라인 뷰 (from 구문에 서브쿼리가 오는 것)
-- 순번을 정해놓은 조회 자료를 범위를 지정해서 가지고 오는 경우.
-- salary로 정렬을 진행하면서 ROWNUM을 붙이면 ROWNUM이 정렬이 되지 않는 사태가 발생
-- 이유: ROWNUM이 먼저 붙고 정렬이 진행되기 때문. ORDER BY는 항상 마지막에 진행.
-- 해결: 정렬이 미리 진행된 자료에 ROWNUM을 붙여서 다시 조회하는 것이 좋을 것 같다.
SELECT ROWNUM AS rn, employee_id, first_name, salary
FROM employees
ORDER BY salary DESC;

-- ROWNUM을 붙이고 나서 범위를 지정해서 조회하려고 하는데, 
-- 범위 지정도 불가능하고, 지목할 수 없는 문제가 발생하더라
-- 이유 : WHERE절부터 먼저 실행하고 나서 ROWNUM이 SELECT 되기 때문에
-- 해결 : ROWNUM까지 붙여 놓고 다시 한번 자료를 SELECT 해서 범위를 지정해야 됨.

-- 가장 안쪽 SELECT 절에서 필요한 테이블 형식 (인라인 뷰)을 생성.
-- 바깥쪽 SELECT 절에서 ROWNUM을 붙여서 다시 조회를 진행
-- 가장 바깥쪽 SELECT 절에서는 이미 붙어있는 ROWNUM의 범위를 지정해서 조회.
-- SQL의 실행 순서를 숙지.
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
SELECT * FROM
   (
      SELECT ROWNUM AS rn, tbl.* FROM
          (
              SELECT employee_id, first_name, salary
              FROM employees
              ORDER BY salary DESC
          ) tbl
   )
WHERE rn <= 20 AND rn > 10;

SELECT * FROM
(    
SELECT TO_CHAR(TO_DATE(test,'YY/MM/DD'), 'MMDD') AS mm, name FROM
        (
        SELECT '홍길동' AS name, '20211126' AS test FROM dual UNION ALL
        SELECT '김철수', '20210301' FROM dual UNION ALL
        SELECT '박영희', '20210401' FROM dual UNION ALL
        SELECT '김뽀삐', '20210501' FROM dual UNION ALL
        SELECT '박뚜띠', '20210601' FROM dual UNION ALL
        SELECT '김테스트', '20210701' FROM dual
        )
)
WHERE mm = '1126';








































































