
-- 프로시저(procedure) -> void 메서드랑 유사.
-- 특정한 로직을 처리하고 결과값을 반환하지 않는 코드 덩어리 (쿼리).
-- PL/SQL에도 값을 전달받아서 코드를 실행 후 리턴하는 함수가 존재합니다.
-- 하지만 프로시저를 통해서도 값을 리턴하는 방법이 있습니다.

-- 매개값(인수) 없는 프로시저
CREATE PROCEDURE p_test
IS -- 선언부
    v_msg VARCHAR2(30) := 'Hello Procedure!';
BEGIN -- 실행부
    dbms_output.put_line(v_msg);
END; -- 종료부

EXEC p_test; -- 프로시저 호출문.

SELECT * FROM jobs;

-- IN 입력값을 받는 파라미터
CREATE PROCEDURE my_new_job_proc
(
    p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE,
    p_max_sal IN jobs.max_salary%TYPE
)
IS

BEGIN
    INSERT INTO jobs
    VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    COMMIT;
END;

EXEC my_new_job_proc('JOB1', 'test job1', 1000, 5000);


-- 이미 존재한다면 ALTER, 없다면 CREATE
CREATE OR REPLACE PROCEDURE my_new_job_proc
(
    p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE,
    p_max_sal IN jobs.max_salary%TYPE
)
IS
    v_cnt NUMBER := 0;
BEGIN

    -- 동일한 job_id가 있는지부터 체크
    -- 이미 존재한다면 1, 존재하지 않는다면 0 -> v_cnt에 대입할 예정.
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN -- 없다면 INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE -- 있다면 UPDATE
        UPDATE JOBS
        SET job_title = p_job_title,
            min_salary = p_min_sal,
            max_Salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
    COMMIT;
END;

SELECT * FROM jobs
WHERE job_id = 'JOB2';

EXEC my_new_job_proc('JOB2', 'test job2');

-- 매개변수(인수)의 디폴트 값(기본값) 설정
CREATE OR REPLACE PROCEDURE my_new_job_proc
(
    p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE := 0,
    p_max_sal IN jobs.max_salary%TYPE := 1000
)
IS
    v_cnt NUMBER := 0;
BEGIN

    -- 동일한 job_id가 있는지부터 체크
    -- 이미 존재한다면 1, 존재하지 않는다면 0 -> v_cnt에 대입할 예정.
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN -- 없다면 INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE -- 있다면 UPDATE
        UPDATE JOBS
        SET job_title = p_job_title,
            min_salary = p_min_sal,
            max_Salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
    COMMIT;
END;

------------------------------------------------------------------------

-- OUT, IN OUT 매개변수(인수) 사용.
-- OUT 변수를 사용하면 프로시저 바깥쪽으로 값을 보냅니다.
-- OUT을 통해서 보낸 값은 바깥 익명블록에서 실행해야 합니다.

CREATE OR REPLACE PROCEDURE my_new_job_proc
(
    p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE := 0,
    p_max_sal IN jobs.max_salary%TYPE := 1000,
    p_result OUT VARCHAR2 -- 바깥쪽에서 출력을 하기 위한 변수.
)
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '값이 존재하지 않아서 INSERT로 처리 되었습니다.';
BEGIN

    -- 동일한 job_id가 있는지부터 체크
    -- 이미 존재한다면 1, 존재하지 않는다면 0 -> v_cnt에 대입할 예정.
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN -- 없다면 INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
        
    ELSE -- 있다면 결과를 추출.
        SELECT
            p_job_id || '의 최대 연봉: ' || max_salary || ', 최소연봉: ' || min_salary
        INTO v_result -- 조회 결과를 대입.
        FROM jobs
        WHERE job_id = p_job_id;
    END IF;
    
    -- OUT 매개변수에 결과를 할당
    p_result := v_result;
    
    COMMIT;
END;

DECLARE
    str VARCHAR2(100);
BEGIN

    -- 프로시저를 부를 때 out되는 값을 받을 변수를 하나 더 전달해 주셔야 합니다.
    my_new_job_proc('JOB1', 'test_job1', 2000, 8000, str);
    DBMS_OUTPUT.put_line(str);
    
    my_new_job_proc('CEO', 'test_CEO', 10000, 100000, str);
    DBMS_OUTPUT.PUT_LINE(str);

END;

-- IN, OUT을 동시에 처리
CREATE OR REPLACE PROCEDURE my_parameter_test_proc
(
    -- 반환 불가
    p_var1 IN VARCHAR2,
    -- OUT변수는 프로시저가 끝나기 전까지는 값의 할당이 안됨.
    -- 끝나야 OUT이 가능.
    p_var2 OUT VARCHAR2,
    -- IN, OUT이 둘 다 가능함.
    p_var3 IN OUT VARCHAR2
)
IS

BEGIN
    dbms_output.put_line('p_var1: ' || p_var1); -- 출력 가능
    dbms_output.put_line('p_var2: ' || p_var2); -- 값이 전달이 안됐어요. (공백)
    dbms_output.put_line('p_var3: ' || p_var3); -- IN의 성질을 가지고 있구나~
    
    -- p_var1 := '결과1'; -> 할당 불가.
    p_var2 := '결과2';
    p_var3 := '결과3';
    
    dbms_output.put_line('--------------------------------');
     
END;


DECLARE
    v_var1 VARCHAR2(10) := 'value1';
    v_var2 VARCHAR2(10) := 'value2';
    v_var3 VARCHAR2(10) := 'value3';
BEGIN
    my_parameter_test_proc(v_var1, v_var2, v_var3);
    
    dbms_output.put_line('v_var1: ' || v_var1);
    dbms_output.put_line('v_var2: ' || v_var2);
    dbms_output.put_line('v_var3: ' || v_var3);
END;


-- RETURN
CREATE OR REPLACE PROCEDURE my_new_job_proc
(
    p_job_id IN jobs.job_id%TYPE,
    p_result OUT VARCHAR2 
)
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '값이 존재하지 않아서 INSERT로 처리 되었습니다.';
BEGIN

    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN 
        dbms_output.put_line(p_job_id || '는 테이블에 존재하지 않습니다.');
        RETURN; -- 프로시저 강제 종료.
    END IF;
        
    SELECT
        p_job_id || '의 최대 연봉: ' || max_salary || ', 최소연봉: ' || min_salary
    INTO v_result -- 조회 결과를 대입.
    FROM jobs
    WHERE job_id = p_job_id;

    
    -- OUT 매개변수에 결과를 할당
    p_result := v_result;
    
    COMMIT;
END;

DECLARE
    str VARCHAR2(100);
BEGIN
    my_new_job_proc('STUDENT', str);
    dbms_output.put_line(str);
END;

-- 예외 처리
DECLARE
    v_num NUMBER := 0;
BEGIN
    v_num := 10 / 0;
    
EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('0으로 나눌 수 없습니다.');
    dbms_output.put_line('SQL ERROR CODE: ' || SQLCODE);
    dbms_output.put_line('ERROR MSG: ' || SQLERRM);
END;



















