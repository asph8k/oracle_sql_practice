SET SERVEROUTPUT ON;

-- WHILE��
DECLARE
    v_num NUMBER := 3;
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_num);
        v_count := v_count + 1;
    END LOOP;
END;

-- Ż�⹮
DECLARE
    v_num NUMBER := 3;
    v_count NUMBER := 1;
BEGIN
    WHILE v_count <= 10
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_num);
        EXIT WHEN v_count = 5;
        v_count := v_count + 1;
    END LOOP;
END;

-- FOR ��
DECLARE
    v_num NUMBER := 3;
BEGIN
    FOR i IN 1..9 -- .�� �ΰ� �ۼ��ؼ� ������ ǥ��.
    LOOP
        dbms_output.put_line(v_num || ' x ' || i || ' =' || v_num * i);
    END LOOP;
END;

-- CONTINUE
DECLARE
    v_num NUMBER := 3;
BEGIN
    FOR i IN 1..9 
    LOOP
        CONTINUE WHEN i = 5;
        dbms_output.put_line(v_num || ' x ' || i || ' =' || v_num * i);
    END LOOP;
END;

-- 1. ��� �������� ����ϴ� �͸� ����� ���弼��. (2~9��)
DECLARE
BEGIN
    FOR i IN 2..9
    LOOP
        dbms_output.put_line('<' || i || '��>');
            FOR j IN 1..9
            LOOP
                dbms_output.put_line(i || ' x ' || j || ' =' || i * j);
            END LOOP;
        END LOOP;    
END;
-- 2. INSERT�� 300�� �����ϴ� �͸� ����� ó���ϼ���.
-- board��� �̸��� ���̺��� ���弼��. (bno writer title �÷��� �����Ѵ�.)
-- bno�� SEQUENCE�� �÷� �ֽð�, writer�� title�� ��ȣ�� �ٿ��� INSERT ������ �ּ���.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3...
CREATE SEQUENCE board2_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10
    MINVALUE 1
    NOCACHE
    NOCYCLE;

CREATE TABLE board (
    seq_bno NUMBER NOT NULL,
    writer VARCHAR2(50),
    title VARCHAR2(30)
);

RENAME board2_seq TO board_seq;

DROP TABLE board;

DECLARE
    v_bn_writer VARCHAR2(100) := 'test';
    v_bn_title VARCHAR2(100) := 'title';
BEGIN
    FOR i IN 1..300
    LOOP
        INSERT INTO board
        VALUES(i, v_bn_writer || i, v_bn_title || i);
    END LOOP;    
END;


SELECT * FROM board;

---------------------------------------------------
/*
[����2] ���ν����� emp_salary_proc�� �ۼ��ϰ�
�͸��Ͽ��� �����ϴ� �ڵ带 �ۼ��� ������. (���ν��� �ۼ� / �͸��Ͽ��� ���� �� �� �ϼ���.)
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ش����� salary�� ��ȭ�� out�ϴ� ���ν����� �ۼ��ϼ���.
(salary�� �޷��� ġ��, ��/�޷� ȯ���� 1�޷� �� 1200������ ����ϰڽ��ϴ�.)
����� �������� �ʴٸ� EXCEPTION ó���ϼ���.
(IN, OUT ������ ����մϴ�.)
*/




























