-- ����� ���� Ȯ��
SELECT * FROM all_users;

-- ���� ���� ���
CREATE USER user1 IDENTIFIED BY user1; -- IDENTIFIED BY �ڿ� �ִ� ���� ��й�ȣ ����.

-- DCL : GRANT(���� �ο�), REVOKE(���� ȸ��). ������ ���� ��� 
/*
CREATE USER -> �����ͺ��̽� ���� ���� ����
CREATE SESSION -> �����ͺ��̽� ���� ����
CREATE TABLE -> ���̺� ���� ����
CREATE VIEW ->  �� ���� ����
CREATE SEQUENCE -> ������ ���� ����
ALTER ANY TABLE -> ��� ���̺� ������ �� �ִ� ����.
INSERT ANY TABLE -> ��� ���̺��� �����͸� �����ϴ� ����
SELECT ANY TABLE....

SELECT ON [���̺� ��] TO [���� ��] -> Ư�� ���̺� ��ȸ �� �� �ִ� ����
INSERT ON....
UPDATE ON....'

-- �����ڿ� ���ϴ� ������ �ο��ϴ� ����.
RESOURCE, CONNECT, DBA TO [���� ��] -- ���� ��� ������ �Ѳ����� �� �� ����
*/

GRANT CREATE SESSION TO user1;

GRANT SELECT ON hr.employees TO user1;

GRANT CONNECT, RESOURCE TO user1;

CREATE TABLE t_test (
   bno NUMBER(3)
);

CREATE SEQUENCE t_test_seq;

INSERT INTO t_test
VALUES(t_test_seq.NEXTVAL);

SELECT * FROM t_test;

REVOKE CONNECT, RESOURCE FROM user1;

--����� ���� ����
--DROP USER [�����̸�] CASCADE;
-- -> CASCADE ���� �� -> ���̺� ������ �����Ѵٸ� ���� ���� �ȵ�.
DROP USER user1 CASCADE;

/*
���̺� �����̽��� �����ͺ��̽� ��ü �� ���� �����Ͱ� ����Ǵ� �����̴�.
���̺� �����̽��� �����ϸ� ������ ��ο� ���� ���Ϸ� ������ �뷮��ŭ��
������ ������ �ǰ�, �����Ͱ� ���������� ����ȴ�.
�翬�� ���̺� �����̽��� �뷮�� �ʰ��Ѵٸ� ���α׷��� ������������ �����Ѵ�.
*/

SELECT * FROM dba_tablespaces;

-- USERS ���̺� �����̽��� �⺻ ��� �������� ����.
ALTER USER user1 DEFAULT TABLESPACE USER_TABLESPACE
QUOTA UNLIMITED ON users;

-- ���̺� �����̽� ���� ��ü�� ��ü �����ϴ� ��.
DROP TABLESPACE USER_TABLESPACE INCLUDING CONTENTS;

-- ������ ���ϱ��� �ѹ��� �����ϴ� ��.
DROP TABLESPACE USER_TABLESPACE INCLUDING CONTENTS AND DATAFILES;







































































