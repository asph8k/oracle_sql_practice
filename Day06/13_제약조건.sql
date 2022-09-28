
-- 테이블 생성과 제약조건(CONSTRAINT)

-- 테이블 열레벨 제약조건 ( CHECK를 제외한 나머지 )
-- PRIMARY KEY : 테이블의 고유 식별 컬럼(주요 키). 테이블을 만들때 기본 하나는 있는게 좋음. UNIQUE와 NOT NULL을 합친 것과 같다.
-- UNIQUE : 유일한 값을 갖게 하는 컬럼 (중복값 방지)
-- NOT NULL : null을 허용하지 않음. 필수값에 설정
-- FOREIGN KEY : 참조하는 테이블의 PRIMARY KEY를 저장하는 컬럼.
-- CHECK : 정의된 형식만 저장되도록 허용.
-- REFERENCES( 참조형 제약조건 )

CREATE TABLE dept2 (
   dept_no NUMBER(2) CONSTRAINT dept2_deptno_pk PRIMARY KEY,
   dept_name VARCHAR2(14) NOT NULL CONSTRAINT dept2_deptname_uk UNIQUE,
   loca NUMBER(4) CONSTRAINT dept2_loca_locaid_fk REFERENCES locations(location_id),
   dept_bonus NUMBER(10),
   dept_gender VARCHAR2(1) CONSTRAINT dept2_gender_ck CHECK (dept_gender IN ('M', 'F'))
);

DROP TABLE dept2;

-- 테이블레벨 제약조건 (모든 열 선언 후 제약조건을 취하는 방식)
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

-- 외래키(FOREIGN KEY)가 부모테이블에 없다면 INSERT가 불가능.
INSERT INTO dept2
VALUES (10, 'gg', 4000, sysdate, 100000, 'M');

-- 외래키가 부모테이블에 있다면 INSERT 가능.
INSERT INTO dept2
VALUES (30, 'hh', 1800, sysdate, 100000, 'M');

UPDATE dept2
SET loca = 4000
WHERE loca = 1800; -- 실패

SELECT * FROM dept2;

UPDATE locations
SET location_id = 4000
WHERE location_id = 1800; -- 외래키 제약 조건 위반

-- 제약 조건 변경
-- 제약 조건은 추가, 삭제가 가능하나 변경은 안됨.
-- 변경할려면 삭제한 후 새로운 내용으로 추가해야 한다.
DROP TABLE dept2;

CREATE TABLE dept2 (
   dept_no NUMBER(2),
   dept_name VARCHAR2(14) NOT NULL,
   loca NUMBER(4),
   dept_date DATE,
   dept_bonus NUMBER(10),
   dept_gender VARCHAR2(1)
);

-- pk 추가
ALTER TABLE dept2 ADD CONSTRAINT dept_no_pk PRIMARY KEY(dept_no);
-- fk 추가
ALTER TABLE dept2 ADD CONSTRAINT dept_loca_fk FOREIGN KEY(loca) 
REFERENCES locations(location_id);
-- check 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_gender_ck CHECK(dept_gender IN('M', 'F'));
-- unique 추가
ALTER TABLE dept2 ADD CONSTRAINT dept2_deptdate_uk UNIQUE (dept_date);

ALTER TABLE dept2 MODIFY dept_date DATE NOT NULL; -- 열 속성 수정 방식으로 추가

-- 제약조건 삭제 (제약조건 이름으로)
ALTER TABLE dept2 DROP CONSTRAINT dept_no_pk; --컬럼명을 지정하는게 아니라 제약조건명으로 지정해야 함.

-- 제약 조건 확인
SELECT * FROM user_constraints
WHERE table_name = 'DEPT2';
-- 제약 조건은 변경 불가. 변경하기 위해선 아예 삭제하고 다시 조건을 걸어줘야 된다.

-- 문제1 
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

-- 문제2
SELECT m.m_name, m.m_num, tbl.* FROM members m JOIN
    (
    SELECT street_address, location_id
    FROM locations loc
    )tbl
ON m.loca = tbl.location_id
ORDER BY m.m_num ASC;

-- 문제2 강사님 방식
SELECT 
    m.m_name, m.m_num, loc.street_address, loc.location_id
FROM members m JOIN locations loc
ON m.loca = loc.location_id
ORDER BY m.m_num ASC;











































