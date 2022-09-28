SET SERVEROUTPUT ON;

-- WHILE문
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

-- 탈출문
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

-- FOR 문
DECLARE
    v_num NUMBER := 3;
BEGIN
    FOR i IN 1..9 -- .을 두개 작성해서 범위를 표현.
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

-- 1. 모든 구구단을 출력하는 익명 블록을 만드세요. (2~9단)
DECLARE
BEGIN
    FOR i IN 2..9
    LOOP
        dbms_output.put_line('<' || i || '단>');
            FOR j IN 1..9
            LOOP
                dbms_output.put_line(i || ' x ' || j || ' =' || i * j);
            END LOOP;
        END LOOP;    
END;
-- 2. INSERT를 300번 실행하는 익명 블록을 처리하세요.
-- board라는 이름의 테이블을 만드세요. (bno writer title 컬럼이 존재한다.)
-- bno는 SEQUENCE로 올려 주시고, writer와 title에 번호를 붙여서 INSERT 진행해 주세요.
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
[문항2] 프로시저명 emp_salary_proc을 작성하고
익명블록에서 실행하는 코드를 작성해 보세요. (프로시저 작성 / 익명블록에서 실행 둘 다 하세요.)
employee_id를 입력받아 employees에 존재하면,
해당사원의 salary를 원화로 out하는 프로시저를 작성하세요.
(salary는 달러로 치고, 원/달러 환율은 1달러 당 1200원으로 계산하겠습니다.)
사원이 존재하지 않다면 EXCEPTION 처리하세요.
(IN, OUT 변수를 사용합니다.)
*/




























