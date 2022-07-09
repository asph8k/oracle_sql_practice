-- ����Ŭ���� �����ϴ� dual �������̺�(�ƹ��� �����Ͱ� ���� ������ ����� Ȯ�� ���ִ� �뵵)
-- lower(�ҹ���), initcap(�ձ��ڸ� �빮��), upper(�빮��)

/*
dual�̶�� ���̺��� sys�� �����ϴ� ����Ŭ�� ǥ�� ���̺�μ�,
���� �� �࿡ �� �÷��� ��� �ִ� dummy ���̺��̴�.
�Ͻ����� ��� �����̳� ��¥ ���� ���� �ַ� ����Ѵ�.
��� ����ڰ� ������ �� �ִ�.
*/
SELECT 'abcDEF', lower('abcDEF'), upper('abcDEF')
FROM dual;

SELECT last_name, lower(last_name), INITCAP(last_name), upper(last_name)
FROM employees;

SELECT last_name FROM employees
WHERE lower(last_name) = 'austin';

-- length(����), instr(���� ã��. ������ 0 ����, �ε��������� ó��)
SELECT 'abcdef' AS ex, LENGTH('abcdef'), INSTR('abcdef','a')
FROM dual;

SELECT first_name, LENGTH(first_name), INSTR(first_name,'a')
FROM employees;

-- substr(���ڿ� �ڸ���), concat(���� ����) 1���� ����
SELECT 'abcdef' AS ex,
SUBSTR('abcdef', 1, 4), CONCAT('abc','def')
FROM dual;

SELECT first_name, SUBSTR(first_name, 1, 3),
CONCAT (first_name, last_name)
FROM employees;

-- LPAD, RPAD (��, ���� �������ڿ��� ä���)
SELECT LPAD('abc', 10, '*') FROM dual;
SELECT RPAD('abc', 10, '*') FROM dual;





























