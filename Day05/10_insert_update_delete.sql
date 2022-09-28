-- insert
-- 테이블 구조 확인 
-- DESCRIBE
DESC departments;

-- insert의 첫번째 방법(모든 컬럼 데이터를 한번에 지정. NULL이라도 컬럼을 지정안하면 안들어간다.)
INSERT INTO departments 
VALUES (280, '개발자', NULL, 1700);

SELECT * FROM departments;
ROLLBACK; -- 실행 시점을 다시 뒤로 되돌리는 키워드( 방금 집어 넣었던 INSERT를 취소 )

-- INSERT의 두번째 방법 (직접 컬럼을 지정하고 저장하는 방식)
INSERT INTO departments
(department_id, department_name, location_id)
VALUES (280, '개발자', 1700);

-- INSERT 연습
INSERT INTO departments
VALUES (290, '디자이너', NULL, 1700);
INSERT INTO departments
VALUES (300, 'DB관리자', NULL, 1800);
INSERT INTO departments
VALUES (310, '데이터분석가', NULL, 1800);
INSERT INTO departments
VALUES (320, '퍼블리셔', 200, 1800);
INSERT INTO departments
VALUES (330, '서버관리자', 200, 1800);

SELECT * FROM employees;

-- 사본 테이블 생성 CTAS : CREATE TABLE AS
CREATE TABLE managers AS 
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2); -- WHERE절에 false로 주면 테이블 구조만 복사
                             -- true로 주면 그 안에 있던 데이터까지 복사
DROP TABLE managers; -- 테이블 삭제
                          
SELECT * FROM managers;

-- INSERT (서브쿼리문)
INSERT INTO managers 
(SELECT employee_id, first_name, job_id, hire_date
FROM employees);

-- UPDATE 
CREATE TABLE emps AS (SELECT * FROM employees); --WHERE을 안써도 ture값이 자동들어감
SELECT * FROM emps;

-- CTAS를 사용하면 제약 조건은 NOT NULL 말고는 복사되지 않는다.
-- 제약조건은 업무규칙을 지키는 데이터만 저장하고, 그렇지 않은 것들이
-- DB에 저장되는 것을 방지하는 목적으로 사용한다.

-- UPDATE를 진행할 때는 누구를 수정할 지 잘 지목해야 한다.
-- 그렇지 않으면 수정 대상이 테이블 전체로 지목된다.
UPDATE emps SET salary = 30000;
ROLLBACK;

UPDATE emps SET salary = 30000
WHERE employee_id = 100;

UPDATE emps SET salary = salary + salary * 0.1
WHERE employee_id = 100;

UPDATE emps SET 
phone_number = '515.123.4566', manager_id = 102
WHERE employee_id = 100;

-- UPDATE (서브쿼리)
UPDATE emps
    SET (job_id, salary, manager_id) = 
    (SELECT job_id, salary, manager_id
    FROM emps
    WHERE employee_id = 100)
WHERE employee_id = 101;

-- DELETE
DELETE FROM emps
WHERE employee_id = 103;

SELECT * FROM emps
WHERE employee_id = 103;

-- 사본 테이블 생성
CREATE TABLE depts AS (SELECT * FROM departments);

SELECT * FROM emps;
-- DELETE (서브쿼리)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM depts
                       WHERE department_id = 100);
                       
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM depts
                       WHERE department_name = 'IT');












































































