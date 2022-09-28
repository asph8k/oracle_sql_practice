-- ����Ŀ�� Ȯ�� ���. ����Ŭ�� �⺻������ ����Ŀ���� ��������
SHOW AUTOCOMMIT;
-- ����Ŀ�� ��. ����Ŀ�� Ű�� ��
SET AUTOCOMMIT ON;
-- ����Ŀ�� ����. ����Ŀ�� ���� ��
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

INSERT INTO emps 
    (employee_id, last_name, email, hire_date, job_id)
VALUES (300, 'kim', 'abc@naver.com', sysdate, 1800);

-- �������� ��� ������ ��������� ���(���), ���� Ŀ�� �ܰ�� ȸ��(���ư��� �� Ʈ����� ����)
ROLLBACK;

-- ���̺� ����Ʈ ���� 
-- �ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����.
-- ANSI ǥ�� ������ �ƴϱ� ������ �׷��� ���������� ����.
SAVEPOINT insert_kim;

INSERT INTO emps 
    (employee_id, last_name, email, hire_date, job_id)
VALUES (301, 'Park', 'park@naver.com', sysdate, 1800);

ROLLBACK TO SAVEPOINT insert_Kim;

-- �������� ��� ������ ��������� ���������� �����ϸ鼭 Ʈ������� ����.
-- Ŀ���� ���Ŀ��� � ����� ����ϴ��� �ǵ��� �� ����.
COMMIT;














































