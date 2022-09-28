--1.������ �� 3���� ����ϴ� �͸� ����� ����� ���� (��¹� 9���� �����ؼ� ������.)
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

-- 2. ��� ���̺��� 201�� ����� �̸��� �̸����ּҸ� ����ϴ� �͸� ����� ������
-- ������ ��Ƽ� ����ϼ���.
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

-- 3.��� ���̺�(employees)���� �����ȣ�� ���� ū ����� ã�Ƴ� �� (MAX�Լ� ���),
-- �� ��ȣ + 1������ �Ʒ��� ����� emps��
-- employee_id, last_name, email, hire_date, job_id�� �ű� �Է��ϴ� �͸� ����� ���弼��.
-- SELECT�� ���Ŀ� INSERT���� ����� �����մϴ�.
/*
<�����>: steven
<�̸���>: stevenjobs
<�Ի�����>: ���ó�¥
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

























































