
-- ���̺� ������ ��������(CONSTRAINT)

-- ���̺� ������ �������� ( CHECK�� ������ ������ )
-- PRIMARY KEY : ���̺��� ���� �ĺ� �÷�(�ֿ� Ű). ���̺��� ���鶧 �⺻ �ϳ��� �ִ°� ����. UNIQUE�� NOT NULL�� ��ģ �Ͱ� ����.
-- UNIQUE : ������ ���� ���� �ϴ� �÷� (�ߺ��� ����)
-- NOT NULL : null�� ������� ����. �ʼ����� ����
-- FOREIGN KEY : �����ϴ� ���̺��� PRIMARY KEY�� �����ϴ� �÷�.
-- CHECK : ���ǵ� ���ĸ� ����ǵ��� ���.
-- REFERENCES( ������ �������� )

CREATE TABLE dept2 (
   dept_no NUMBER(2) CONSTRAINT dept2_deptno_pk PRIMARY KEY,
   dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE,
   loca NUMBER(4) CONSTRAINT dept2_loca_locaid_fk REFERENCES locations(location_id),
   dept_bonus NUMBER(10),
   dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK (dept_gender IN ('M', 'F'))
);

DROP TABLE dept2;

-- ���̺��� �������� (��� �� ���� �� ���������� ���ϴ� ���)
CREATE TABLE dept2 (
   dept_no NUMBER(2),
   dept_name VARCHAR2(14) NOT NULL,
   loca NUMBER(4),
   dept_date DATE,
   dept_bonus NUMBER(10),
   dept_gender VARCHAR2(1),
   
   CONSTRAINT dept2_deptno_pk PRIMARY KEY(dept_no),
   CONSTRAINT dept_deptname_uk UNIQUE(dept_name),
   CONSTRAINT dept2_loca_locid_fk FOREIGN KEY (loca) REFERENCES locations(location_id),
   CONSTRAINT dept2_deptdate_uk UNIQUE (dept_date),
   CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'))
);

-- �ܷ�Ű(FOREIGN KEY)�� �θ����̺� ���ٸ� INSERT�� �Ұ���.
INSERT INTO dept2
VALUES (10, 'gg', 4000, sysdate, 100000, 'M');

-- �ܷ�Ű�� �θ����̺� �ִٸ� INSERT ����.
INSERT INTO dept2
VALUES (30, 'hh', 1800, sysdate, 100000, 'M');

UPDATE dept2
SET loca = 4000
WHERE loca = 1800; -- ����

SELECT * FROM dept2;

UPDATE locations
SET location_id = 4000
WHERE location_id = 1800; -- �ܷ�Ű ���� ���� ����

-- ���� ���� ����
-- ���� ������ �߰�, ������ �����ϳ� ������ �ȵ�.
-- �����ҷ��� ������ �� ���ο� �������� �߰��ؾ� �Ѵ�.
DROP TABLE dept2;

CREATE TABLE dept2 (
   dept_no NUMBER(2),
   dept_name VARCHAR2(14) NOT NULL,
   loca NUMBER(4),
   dept_date DATE,
   dept_bonus NUMBER(10),
   dept_gender VARCHAR2(1)
);

-- pk �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY(dept_no);
-- fk �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept_loca_fk FOREIGN KEY(loca) 
REFERENCES locations(location_id);
-- check �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'));
-- unique �߰�
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptdate_uk UNIQUE (dept_date);

ALTER TABLE dept2 MODIFY dept_date DATE NOT NULL; -- �� �Ӽ� ���� ������� �߰�

-- �������� ���� (�������� �̸�����)
ALTER TABLE dept2 DROP CONSTRAINT dept_no_pk; --�÷����� �����ϴ°� �ƴ϶� �������Ǹ����� �����ؾ� ��.

-- ���� ���� Ȯ��
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';
-- ���� ������ ���� �Ұ�. �����ϱ� ���ؼ� �ƿ� �����ϰ� �ٽ� ������ �ɾ���� �ȴ�.

-- ����1 
DROP TABLE members;

CREATE TABLE members (
   M_NAME VARCHAR2(3) NOT NULL,
   M_NUM NUMBER(1) CONSTRAINT mem_memnum_pk PRIMARY KEY,
   REG_DATE DATE NOT NULL CONSTRAINT mem_regdate_uk UNIQUE,
   GENDER VARCHAR2(1),
   LOCA NUMBER(4) CONSTRAINT mem_loca_loc_locid_fk REFERENCES locations(location_id)
);

SELECT * FROM user_constraints
WHERE table_name = 'MEMBERS';

INSERT INTO members
VALUES ('AAA', 1, '18/07/01', 'M', 1800);
INSERT INTO members
VALUES ('BBB', 2, '18/07/02', 'F', 1900);
INSERT INTO members
VALUES ('CCC', 3, '18/07/03', 'M', 2000);
INSERT INTO members
VALUES ('DDD', 4, sysdate, 'M', 2000);

COMMIT;

SELECT * FROM members;

-- ����2
SELECT m.m_name, m.m_num, tbl.* FROM members m JOIN
    (
    SELECT street_address, location_id
    FROM locations loc
    )tbl
ON m.loca = tbl.location_id
ORDER BY m.m_num ASC;

-- ����2 ����� ���
SELECT 
    m.m_name, m.m_num, loc.street_address, loc.location_id
FROM members m JOIN locations loc
ON m.loca = loc.location_id
ORDER BY m.m_num ASC;











































