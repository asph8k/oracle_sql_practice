SELECT * FROM employees;

-- WHERE�� �� (������ ���� ��/�ҹ��ڸ� �����Ѵ�.)
SELECT first_name, last_name, job_id 
FROM employees
WHERE job_id = 'IT_PROG';

SELECT * FROM employees
WHERE last_name = 'King';

SELECT * FROM employees
WHERE department_id = 90;

SELECT * FROM employees
WHERE salary >= 15000;

SELECT * FROM employees
WHERE hire_date = '04/01/30';


-- ������ �� ���� (BETWEEN, IN, LIKE)
SELECT * FROM employees
WHERE salary BETWEEN 15000 AND 20000;

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

-- IN �������� ��� (Ư�� ����� ���� �� ���)
SELECT * FROM employees
WHERE manager_id IN (100,101,102);

SELECT * FROM employees
WHERE job_id IN ('IT_PROG', 'AD_VP');

-- LIKE ������
-- %�� ����, _(�����)�� �������� ��ġ
SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '03%'; --�տ� 03�̰� �ڿ� ������

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%15'; --���� ������ �ڿ� 15�� ������

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%'; --��,�� ������ ������� 05�� ����

SELECT first_name, hire_date
FROM employees
WHERE hire_date LIKE '___05%'; --�� ��ȸ.

-- IS NULL (null���� ã��)
SELECT * FROM employees
WHERE manager_id IS NULL;

SELECT * FROM employees
WHERE commission_pct IS NULL; -- NULL�̶��

SELECT * FROM employees
WHERE commission_pct IS NOT NULL; -- NULL�� �ƴ϶��

-- AND, OR 
-- AND�� OR���� ��������� ����. OR�� ( )�� �����ָ� �켱������ �ȴ�.
SELECT * FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'FI_MGR'
AND salary >= 6000;

SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR')
AND salary >= 6000;

-- �������� ���� (SELECT ������ ���� �������� ��ġ�ȴ�.)
-- ASC : ascending ��������
-- DESC : descending ��������
SELECT * FROM employees
ORDER BY hire_date ASC;  -- ���� ORDER BY ���� �� �÷��� ���� �� ���� ����

SELECT * FROM employees
ORDER BY hire_date DESC;

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ASC;

SELECT * FROM employees
WHERE salary >= 5000
ORDER BY employee_id DESC;

SELECT first_name, salary * 12 AS pay
FROM employees
ORDER BY pay ASC;































