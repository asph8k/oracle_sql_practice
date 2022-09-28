
CREATE SEQUENCE board2_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10
    MINVALUE 1
    NOCACHE
    NOCYCLE;

CREATE TABLE board ( 
    bno NUMBER(10) PRIMARY KEY,
    writer VARCHAR2(50) NOT NULL,
    title VARCHAR2(30) NOT NULL
);

RENAME board2_seq TO board_seq;

DROP SEQUENCE board_seq;

DROP TABLE board;