-- <- ����Ŭ�� �ּ�ǥ��.
/* ���� �� �ּ� ǥ��. */

-- select �÷���(������ ����) from ���̺� �̸�
SELECT * FROM employees;

SELECT employee_id, first_name, last_name FROM employees;

SELECT email, phone_number, hire_date
FROM employees;

-- �÷��� ��ȸ�ϴ� ��ġ���� * / + - ������ �����ϴ�.
SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    salary + salary*0.1
FROM
    employees;

-- null ���� Ȯ�� (���� 0�̳� �����̶��� �ٸ� �����̴�.)
SELECT department_id, commission_pct
FROM employees;

-- as�� �̿��Ͽ� �÷����� ����(��Ī�� ���δ�)
-- alias (�÷���, ���̺���� �̸��� �����ؼ� ��ȸ�Ѵ�.)
SELECT first_name as �̸�, last_name as ��, 
salary as �޿�
FROM employees;

-- || = ���ڿ� ���� ��ȣ
-- ����Ŭ�� Ȭ����ǥ''�� ���ڸ� ǥ���ϰ�, ���ڿ� �ȿ� Ȭ����ǥ�� 
-- ǥ���ϰ� �ʹٸ� ''�� �ι� �������� ���� �ȴ�.
-- || -> ������
SELECT 
first_name || ' ' || last_name || '''s salary is $' || salary as �޿�����
FROM employees;

-- DISTINCT -> �ߺ��� ����
-- DISTINCT (�ߺ� ���� ���� ����)
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees;

-- ROWNUM, ROWID
-- (**ROWNUM : ������ ���� ��ȯ�Ǵ� �� ��ȣ�� ���)
-- (ROWID : �����ͺ��̽����� ���� �ּҰ��� ��ȯ)
SELECT ROWNUM, ROWID, employee_id
FROM employees;


































