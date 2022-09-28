
-- ���ν���(procedure) -> void �޼���� ����.
-- Ư���� ������ ó���ϰ� ������� ��ȯ���� �ʴ� �ڵ� ��� (����).
-- PL/SQL���� ���� ���޹޾Ƽ� �ڵ带 ���� �� �����ϴ� �Լ��� �����մϴ�.
-- ������ ���ν����� ���ؼ��� ���� �����ϴ� ����� �ֽ��ϴ�.

-- �Ű���(�μ�) ���� ���ν���
CREATE PROCEDURE p_test
IS -- �����
    v_msg VARCHAR2(30) := 'Hello Procedure!';
BEGIN -- �����
    dbms_output.put_line(v_msg);
END; -- �����

EXEC p_test; -- ���ν��� ȣ�⹮.

SELECT * FROM jobs;

-- IN �Է°��� �޴� �Ķ����
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


-- �̹� �����Ѵٸ� ALTER, ���ٸ� CREATE
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

    -- ������ job_id�� �ִ������� üũ
    -- �̹� �����Ѵٸ� 1, �������� �ʴ´ٸ� 0 -> v_cnt�� ������ ����.
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN -- ���ٸ� INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE -- �ִٸ� UPDATE
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

-- �Ű�����(�μ�)�� ����Ʈ ��(�⺻��) ����
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

    -- ������ job_id�� �ִ������� üũ
    -- �̹� �����Ѵٸ� 1, �������� �ʴ´ٸ� 0 -> v_cnt�� ������ ����.
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN -- ���ٸ� INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
    ELSE -- �ִٸ� UPDATE
        UPDATE JOBS
        SET job_title = p_job_title,
            min_salary = p_min_sal,
            max_Salary = p_max_sal
        WHERE job_id = p_job_id;
    END IF;
    COMMIT;
END;

------------------------------------------------------------------------

-- OUT, IN OUT �Ű�����(�μ�) ���.
-- OUT ������ ����ϸ� ���ν��� �ٱ������� ���� �����ϴ�.
-- OUT�� ���ؼ� ���� ���� �ٱ� �͸��Ͽ��� �����ؾ� �մϴ�.

CREATE OR REPLACE PROCEDURE my_new_job_proc
(
    p_job_id IN jobs.job_id%TYPE,
    p_job_title IN jobs.job_title%TYPE,
    p_min_sal IN jobs.min_salary%TYPE := 0,
    p_max_sal IN jobs.max_salary%TYPE := 1000,
    p_result OUT VARCHAR2 -- �ٱ��ʿ��� ����� �ϱ� ���� ����.
)
IS
    v_cnt NUMBER := 0;
    v_result VARCHAR2(100) := '���� �������� �ʾƼ� INSERT�� ó�� �Ǿ����ϴ�.';
BEGIN

    -- ������ job_id�� �ִ������� üũ
    -- �̹� �����Ѵٸ� 1, �������� �ʴ´ٸ� 0 -> v_cnt�� ������ ����.
    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN -- ���ٸ� INSERT
        INSERT INTO jobs
        VALUES(p_job_id, p_job_title, p_min_sal, p_max_sal);
        
    ELSE -- �ִٸ� ����� ����.
        SELECT
            p_job_id || '�� �ִ� ����: ' || max_salary || ', �ּҿ���: ' || min_salary
        INTO v_result -- ��ȸ ����� ����.
        FROM jobs
        WHERE job_id = p_job_id;
    END IF;
    
    -- OUT �Ű������� ����� �Ҵ�
    p_result := v_result;
    
    COMMIT;
END;

DECLARE
    str VARCHAR2(100);
BEGIN

    -- ���ν����� �θ� �� out�Ǵ� ���� ���� ������ �ϳ� �� ������ �ּž� �մϴ�.
    my_new_job_proc('JOB1', 'test_job1', 2000, 8000, str);
    DBMS_OUTPUT.put_line(str);
    
    my_new_job_proc('CEO', 'test_CEO', 10000, 100000, str);
    DBMS_OUTPUT.PUT_LINE(str);

END;

-- IN, OUT�� ���ÿ� ó��
CREATE OR REPLACE PROCEDURE my_parameter_test_proc
(
    -- ��ȯ �Ұ�
    p_var1 IN VARCHAR2,
    -- OUT������ ���ν����� ������ �������� ���� �Ҵ��� �ȵ�.
    -- ������ OUT�� ����.
    p_var2 OUT VARCHAR2,
    -- IN, OUT�� �� �� ������.
    p_var3 IN OUT VARCHAR2
)
IS

BEGIN
    dbms_output.put_line('p_var1: ' || p_var1); -- ��� ����
    dbms_output.put_line('p_var2: ' || p_var2); -- ���� ������ �ȵƾ��. (����)
    dbms_output.put_line('p_var3: ' || p_var3); -- IN�� ������ ������ �ֱ���~
    
    -- p_var1 := '���1'; -> �Ҵ� �Ұ�.
    p_var2 := '���2';
    p_var3 := '���3';
    
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
    v_result VARCHAR2(100) := '���� �������� �ʾƼ� INSERT�� ó�� �Ǿ����ϴ�.';
BEGIN

    SELECT COUNT(*)
    INTO v_cnt
    FROM jobs
    WHERE job_id = p_job_id;

    IF v_cnt = 0 THEN 
        dbms_output.put_line(p_job_id || '�� ���̺� �������� �ʽ��ϴ�.');
        RETURN; -- ���ν��� ���� ����.
    END IF;
        
    SELECT
        p_job_id || '�� �ִ� ����: ' || max_salary || ', �ּҿ���: ' || min_salary
    INTO v_result -- ��ȸ ����� ����.
    FROM jobs
    WHERE job_id = p_job_id;

    
    -- OUT �Ű������� ����� �Ҵ�
    p_result := v_result;
    
    COMMIT;
END;

DECLARE
    str VARCHAR2(100);
BEGIN
    my_new_job_proc('STUDENT', str);
    dbms_output.put_line(str);
END;

-- ���� ó��
DECLARE
    v_num NUMBER := 0;
BEGIN
    v_num := 10 / 0;
    
EXCEPTION WHEN OTHERS THEN
    dbms_output.put_line('0���� ���� �� �����ϴ�.');
    dbms_output.put_line('SQL ERROR CODE: ' || SQLCODE);
    dbms_output.put_line('ERROR MSG: ' || SQLERRM);
END;



















