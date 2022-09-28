-- ������ (���������� �����ϴ� ���� ����� �ִ� ��ü)
SELECT * FROM user_sequences;

-- ������ ����
CREATE SEQUENCE dept2_seq 
   START WITH 1 -- ���۰� (�⺻���� ������ ���� �ּҰ�, ������ ���� �ִ밪)
   INCREMENT BY 1 -- ������ (����� ����, ������ ����, �⺻�� 1)
   MAXVALUE 10 -- �ִ밪 (�⺻�� ���� 1027, ������ �� -1)
   MINVALUE 1 -- �ּҰ� (�⺻�� �����϶� 1, ������ �� -1028)
   NOCACHE -- ĳ���޸� ��� ���� (�⺻���� CACHE)
   NOCYCLE; -- ��ȯ���� (�⺻���� NOCYCLE, ��ȯ��Ű���� CYCLE)
   
CREATE TABLE dept3 (
   dept_no NUMBER(2),
   dept_name VARCHAR2(14),
   loca VARCHAR2(13),
   dept_date DATE
);

RENAME dept2_seq TO dept3_seq; -- ���̺� ������ ����

-- ������ ����ϱ� (NEXTVALUE, CURRVAL)
INSERT INTO dept3 
VALUES(dept3_seq.NEXTVAL, 'test', 'test', sysdate);

SELECT * FROM dept3;

SELECT dept3_seq.CURRVAL FROM dual;

-- ������ ���� (���� ���� ����)
-- START WITH�� ������ �Ұ���.
ALTER SEQUENCE dept3_seq MAXVALUE 9999; -- �ִ밪 ����.
ALTER SEQUENCE dept3_seq INCREMENT BY -1; -- ������ ����.
ALTER SEQUENCE dept3_seq MINVALUE 0; -- �ּҰ� ����.

-- ������ ���� �ٽ� ó������ ������ ���
SELECT dept3_seq.CURRVAL FROM dual;
ALTER SEQUENCE dept3_seq INCREMENT BY -10;
SELECT dept3_seq.NEXTVAL FROM dual;
ALTER SEQUENCE dept3_seq INCREMENT BY 1;

DROP SEQUENCE dept3_seq;

/*
- index
index�� primary key, unique ���� ���ǿ��� �ڵ����� �����ǰ�,
��ȸ�� ������ �� �ִ� hint������ �Ѵ�.
index�� ��ȸ�� ������ ������, �������ϰ� ���� �ε����� �����ؼ�
����ϸ� ������ ���� ���ϸ� ����ų �� �ִ�.
���� �ʿ��� ���� index�� ����ϴ� ���� �ùٸ���.
*/
SELECT * FROM employees
WHERE first_name = 'Nancy';

-- �ε��� �߰�
-- ���̺� ��ü�� 15%�� �Ѿ�� �ε����� ȿ���� ��������.
CREATE INDEX emp_first_name_idx ON employees(first_name);

/*
- �ε����� ����Ǵ� ��� 
1. �÷��� WHERE �Ǵ� �������ǿ��� ���� ���Ǵ� ���
2. ���� �������� ���� �����ϴ� ���
3. ���̺��� ������ ���
4. Ÿ�� �÷��� ���� ���� null���� �����ϴ� ���.
5. ���̺��� ���� �����ǰ�, �̹� �ϳ� �̻��� �ε����� ������ �ִ� ��쿡��
 �������� �ʽ��ϴ�.
*/

DROP INDEX emp_first_name_idx;


-- �������� �ε����� ����ϴ� hint���
CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- PRIMARY KEY�� �ڵ����� �ε����� �߰��ȴ�
CREATE TABLE tbl_board (
    bno NUMBER(10) PRIMARY KEY,
    writer VARCHAR2(20)
);

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'admin');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'hong');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'kim');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'test');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'admin');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'hong');

INSERT INTO tbl_board
VALUES(board_seq.NEXTVAL, 'kim');

SELECT * FROM tbl_board;

COMMIT;

-- �ε��� �̸� ����
ALTER INDEX SYS_C007026
RENAME TO tbl_board_idx;

-- /*+ INDEX_DESC (tbl_board tbl_board_idx) */
-- : ������ �ε����� ������ ���Բ� ����.
-- INDEX ASC, DESC�� �߰��ؼ� ������, ������������ ���Բ� ������ ����.
SELECT * FROM
    (
    SELECT /*+ INDEX_DESC (tbl_board tbl_board_idx) */ -- ����Ŭ�� ��Ʈ �����.
       ROWNUM AS rn,
       bno,
       writer
    FROM tbl_board
    )
WHERE rn > 10 AND rn <= 20;






































