
-- NUMBER (2) -> 정수를 2자리까지 저장할 수 있는 숫자형 타입.
-- NUMBER (5, 2) -> 정수부, 실수부를 합친 총 자리수 5자리, 소수점 2자리
-- NUMBER -> 괄호를 생략할 시 (38, 0)으로 자동 지정된다.
-- VARCHAR2 (byte) -> 괄호 안에 들어올 문자열의 최대 길이를 지정. (4000byte까지)
-- DATE -> BC 4712년 1월 1일 ~ AD 9999년 12월 31일 까지 지정 가능.
-- 시, 분, 초 지원 가능.

CREATE TABLE dept2 (
    dept_no NUMBER(2),
    dept_name VARCHAR2(14),
    loca VARCHAR2(15),
    dept_date DATE,
    dept_bonus NUMBER(10)
);

DESC dept3;

SELECT * FROM dept3;

-- NUMBER타입에 들어가는 자리수를 확인
INSERT INTO dept2
VALUES (10, '영업', '서울', sysdate, 2000000);

-- 컬럼 추가. CREATE로 만든건 ALTER로 수정
ALTER TABLE dept2
ADD (dept_count NUMBER(3));

-- 열 이름 변경
ALTER TABLE dept2
RENAME COLUMN dept_count TO emp_count;

-- 열 속성 수정
ALTER TABLE dept2
MODIFY (emp_count NUMBER(4));

-- 열 삭제
ALTER TABLE dept2
DROP COLUMN emp_count;

ALTER TABLE dept2
RENAME TO dept3;

-- 테이블 삭제 (구조는 남겨두고 내부 데이터만 모두 삭제)
TRUNCATE TABLE dept3;

DROP TABLE dept2;
























































