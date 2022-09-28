--1.구구단 중 3단을 출력하는 익명 블록을 만들어 보자 (출력문 9개를 복사해서 쓰세요.)
DECLARE
    A NUMBER := 3*1;
    B NUMBER := 3*2;
    C NUMBER := 3*3;
    D NUMBER := 3*4;
    E NUMBER := 3*5;
    F NUMBER := 3*6;
    G NUMBER := 3*7;
    H NUMBER := 3*8;
    I NUMBER := 3*9;
BEGIN
    DBMS_OUTPUT.PUT_LINE('3X1 = ' || TO_CHAR(A));
    DBMS_OUTPUT.PUT_LINE('3X2 = ' || TO_CHAR(B));
    DBMS_OUTPUT.PUT_LINE('3X3 = ' || TO_CHAR(C));
    DBMS_OUTPUT.PUT_LINE('3X4 = ' || TO_CHAR(D));
    DBMS_OUTPUT.PUT_LINE('3X5 = ' || TO_CHAR(E));
    DBMS_OUTPUT.PUT_LINE('3X6 = ' || TO_CHAR(F));
    DBMS_OUTPUT.PUT_LINE('3X7 = ' || TO_CHAR(G));
    DBMS_OUTPUT.PUT_LINE('3X8 = ' || TO_CHAR(H));
    DBMS_OUTPUT.PUT_LINE('3X9 = ' || TO_CHAR(I));
END;

-- 2. 사원 테이블에서 201번 사원의 이름과 이메일주소를 출력하는 익명 블록을 만들어보자
-- 변수에 담아서 출력하세요.
DECLARE
    v_emp_name employees.first_name%TYPE;
    v_emp_email employees.email%TYPE;
BEGIN
    SELECT 
        first_name, email
    INTO v_emp_name,v_emp_email
    FROM employees
    WHERE employee_id = 201;
    
    dbms_output.put_line(v_emp_name || '-' || v_emp_email);
END;

-- 3.사원 테이블(employees)에서 사원번호가 제일 큰 사원을 찾아낸 뒤 (MAX함수 사용),
-- 이 번호 + 1번으로 아래의 사원을 emps에
-- employee_id, last_name, email, hire_date, job_id를 신규 입력하는 익명 블록을 만드세요.
-- SELECT절 이후에 INSERT문을 사용이 가능합니다.
/*
<사원명>: steven
<이메일>: stevenjobs
<입사일자>: 오늘날짜
<JOB_ID>: CEO
*/
DECLARE
    a_max_empno employees.employee_id%TYPE;
BEGIN
    SELECT MAX(employee_id)
    INTO a_max_empno
    FROM employees;
    
    INSERT INTO emps
        (employee_id, last_name, email, hire_date, job_id)
    VALUES
        (a_max_empno + 1, 'steven', 'stevenjobs', sysdate, 'CEO');
        
    COMMIT;

END;

SELECT * FROM emps;

























































