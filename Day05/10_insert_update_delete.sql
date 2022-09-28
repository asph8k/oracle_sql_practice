-- insert
-- ���̺� ���� Ȯ�� 
-- DESCRIBE
DESC departments;

-- insert�� ù��° ���(��� �÷� �����͸� �ѹ��� ����. NULL�̶� �÷��� �������ϸ� �ȵ���.)
INSERT INTO departments 
VALUES (280, '������', NULL, 1700);

SELECT * FROM departments;
ROLLBACK; -- ���� ������ �ٽ� �ڷ� �ǵ����� Ű����( ��� ���� �־��� INSERT�� ��� )

-- INSERT�� �ι�° ��� (���� �÷��� �����ϰ� �����ϴ� ���)
INSERT INTO departments
(department_id, department_name, location_id)
VALUES (280, '������', 1700);

-- INSERT ����
INSERT INTO departments
VALUES (290, '�����̳�', NULL, 1700);
INSERT INTO departments
VALUES (300, 'DB������', NULL, 1800);
INSERT INTO departments
VALUES (310, '�����ͺм���', NULL, 1800);
INSERT INTO departments
VALUES (320, '�ۺ���', 200, 1800);
INSERT INTO departments
VALUES (330, '����������', 200, 1800);

SELECT * FROM employees;

-- �纻 ���̺� ���� CTAS : CREATE TABLE AS
CREATE TABLE managers AS 
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2); -- WHERE���� false�� �ָ� ���̺� ������ ����
                             -- true�� �ָ� �� �ȿ� �ִ� �����ͱ��� ����
DROP TABLE managers; -- ���̺� ����
                          
SELECT * FROM managers;

-- INSERT (����������)
INSERT INTO managers 
(SELECT employee_id, first_name, job_id, hire_date
FROM employees);

-- UPDATE 
CREATE TABLE emps AS (SELECT * FROM employees); --WHERE�� �Ƚᵵ ture���� �ڵ���
SELECT * FROM emps;

-- CTAS�� ����ϸ� ���� ������ NOT NULL ����� ������� �ʴ´�.
-- ���������� ������Ģ�� ��Ű�� �����͸� �����ϰ�, �׷��� ���� �͵���
-- DB�� ����Ǵ� ���� �����ϴ� �������� ����Ѵ�.

-- UPDATE�� ������ ���� ������ ������ �� �� �����ؾ� �Ѵ�.
-- �׷��� ������ ���� ����� ���̺� ��ü�� ����ȴ�.
UPDATE emps SET salary = 30000;
ROLLBACK;

UPDATE emps SET salary = 30000
WHERE employee_id = 100;

UPDATE emps SET salary = salary + salary * 0.1
WHERE employee_id = 100;

UPDATE emps SET 
phone_number = '515.123.4566', manager_id = 102
WHERE employee_id = 100;

-- UPDATE (��������)
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

-- �纻 ���̺� ����
CREATE TABLE depts AS (SELECT * FROM departments);

SELECT * FROM emps;
-- DELETE (��������)
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM depts
                       WHERE department_id = 100);
                       
DELETE FROM emps
WHERE department_id = (SELECT department_id FROM depts
                       WHERE department_name = 'IT');












































































