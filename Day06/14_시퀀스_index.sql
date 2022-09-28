-- 시퀀스 (순차적으로 증가하는 값을 만들어 주는 객체)
SELECT * FROM user_sequences;

-- 시퀀스 생성
CREATE SEQUENCE dept2_seq 
   START WITH 1 -- 시작값 (기본값은 증가할 때는 최소값, 감소할 때는 최대값)
   INCREMENT BY 1 -- 증가값 (양수면 증가, 음수면 감소, 기본값 1)
   MAXVALUE 10 -- 최대값 (기본값 증가 1027, 감소일 때 -1)
   MINVALUE 1 -- 최소값 (기본값 증가일때 1, 감소일 때 -1028)
   NOCACHE -- 캐쉬메모리 사용 여부 (기본값이 CACHE)
   NOCYCLE; -- 순환여부 (기본값은 NOCYCLE, 순환시키리면 CYCLE)
   
CREATE TABLE dept3 (
   dept_no NUMBER(2),
   dept_name VARCHAR2(14),
   loca VARCHAR2(13),
   dept_date DATE
);

RENAME dept2_seq TO dept3_seq; -- 테이블 시퀀스 변경

-- 시퀀스 사용하기 (NEXTVALUE, CURRVAL)
INSERT INTO dept3 
VALUES(dept3_seq.NEXTVAL, 'test', 'test', sysdate);

SELECT * FROM dept3;

SELECT dept3_seq.CURRVAL FROM dual;

-- 시퀀스 수성 (직접 수정 가능)
-- START WITH은 수정이 불가능.
ALTER SEQUENCE dept3_seq MAXVALUE 9999; -- 최대값 증가.
ALTER SEQUENCE dept3_seq INCREMENT BY -1; -- 증가값 변경.
ALTER SEQUENCE dept3_seq MINVALUE 0; -- 최소값 변경.

-- 시퀀스 값을 다시 처음으로 돌리는 방법
SELECT dept3_seq.CURRVAL FROM dual;
ALTER SEQUENCE dept3_seq INCREMENT BY -10;
SELECT dept3_seq.NEXTVAL FROM dual;
ALTER SEQUENCE dept3_seq INCREMENT BY 1;

DROP SEQUENCE dept3_seq;

/*
- index
index는 primary key, unique 제약 조건에서 자동으로 생성되고,
조회를 빠르게 해 주는 hint역할을 한다.
index는 조회를 빠르게 하지만, 무작위하게 많은 인덱스를 생성해서
사용하면 오히려 성능 부하를 일으킬 수 있다.
정말 필요할 때만 index를 사용하는 것이 올바르다.
*/
SELECT * FROM employees
WHERE first_name = 'Nancy';

-- 인덱스 추가
-- 테이블 전체의 15%가 넘어가면 인덱스의 효과는 떨어진다.
CREATE INDEX emp_first_name_idx ON employees(first_name);

/*
- 인덱스가 권장되는 경우 
1. 컬럼이 WHERE 또는 조인조건에서 자주 사용되는 경우
2. 열이 광범위한 값을 포함하는 경우
3. 테이블이 대형인 경우
4. 타겟 컬럼이 많은 수의 null값을 포함하는 경우.
5. 테이블이 자주 수정되고, 이미 하나 이상의 인덱스를 가지고 있는 경우에는
 권장하지 않습니다.
*/

DROP INDEX emp_first_name_idx;


-- 시퀀스와 인덱스를 사용하는 hint방법
CREATE SEQUENCE board_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- PRIMARY KEY는 자동으로 인덱스가 추가된다
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

-- 인덱스 이름 변경
ALTER INDEX SYS_C007026
RENAME TO tbl_board_idx;

-- /*+ INDEX_DESC (tbl_board tbl_board_idx) */
-- : 지정된 인덱스를 강제로 쓰게끔 지정.
-- INDEX ASC, DESC를 추가해서 내림차, 오름차순으로 쓰게끔 지정도 가능.
SELECT * FROM
    (
    SELECT /*+ INDEX_DESC (tbl_board tbl_board_idx) */ -- 오라클의 힌트 사용방법.
       ROWNUM AS rn,
       bno,
       writer
    FROM tbl_board
    )
WHERE rn > 10 AND rn <= 20;






































