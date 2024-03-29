-- 오토커밋 확인 방법. 오라클은 기본적으로 오토커밋은 꺼져있음
SHOW AUTOCOMMIT;
-- 오토커밋 온. 오토커밋 키는 법
SET AUTOCOMMIT ON;
-- 오토커밋 오프. 오토커밋 끄는 법
SET AUTOCOMMIT OFF;

SELECT * FROM emps;

INSERT INTO emps 
    (employee_id, last_name, email, hire_date, job_id)
VALUES (300, 'kim', 'abc@naver.com', sysdate, 1800);

-- 보류중인 모든 데이터 변경사항을 취소(폐기), 직전 커밋 단계로 회귀(돌아가기 및 트랜잭션 종료)
ROLLBACK;

-- 세이브 포인트 생성 
-- 롤백할 포인트를 직접 이름을 붙여서 지정.
-- ANSI 표준 문법이 아니기 때문에 그렇게 권장하지는 않음.
SAVEPOINT insert_kim;

INSERT INTO emps 
    (employee_id, last_name, email, hire_date, job_id)
VALUES (301, 'Park', 'park@naver.com', sysdate, 1800);

ROLLBACK TO SAVEPOINT insert_Kim;

-- 보류중인 모든 데이터 변경사항을 영구적으로 적용하면서 트랜잭션을 종료.
-- 커밋한 이후에는 어떤 방법을 사용하더라도 되돌릴 수 없다.
COMMIT;














































