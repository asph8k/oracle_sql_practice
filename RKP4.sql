DELETE FROM totalapplier
WHERE app_num_seq = 2;

DELETE FROM instt
WHERE instt_num_seq = 2;

DELETE FROM ts
WHERE ts_num_seq = 2;

DELETE FROM gh
WHERE gh_num_seq = 2;

alter table GH modify GH_SRTTN varchar2(50);
alter table INSTT modify INSTT_SRTTN varchar2(50);
alter table INSTT modify INSTT_DTL_SRTTN varchar2(50);

ALTER TABLE announcement modify ANM_FILE_LOCA VARCHAR2(100) NULL;

MERGE INTO userdetail ud USING 
    (
        SELECT ub.joinid, ins.ins_name, ins.ins_phone, ins.ins_addr, ub.joinsocnum
        FROM userbasic ub INNER JOIN Ins ins
        ON (ub.joinid = ins.joinid)
        WHERE ub.joinid = '0번째 아이디'
    ) d
ON (d.joinsocnum = '3' AND ud.joinsocnum = d.joinsocnum) 
WHEN MATCHED THEN
UPDATE SET ud.joinpw = '9999999', d.ins_name = '수정된 기관명';

UPDATE (
   SELECT ud.joinpw
   FROM userdetail ud INNER JOIN UserBasic ub ON ud.joinsocnum = ub.joinsocnum
   ) d
SET d.joinpw = '111111';


SELECT APP_NUM_SEQ, JOIN_ID, APP_NAME, APP_CLASSIFICATION, APP_DATE
FROM Totalapplier;


DROP TABLE TS;
DROP TABLE INSTT;
DROP TABLE GH;

ALTER TABLE TS ADD TS_YEAR VARCHAR2(30) NULL;
ALTER TABLE TS ADD TS_SRTTN VARCHAR2(30) NOT NULL;
ALTER TABLE TS ADD TS_DTL_SRTTN VARCHAR2(30) NOT NULL;

ALTER TABLE GH ADD GH_DTL_SRTTN VARCHAR2(30) NULL;

SELECT ts.ts_name, ta.join_id, ts.ts_soc_num, ts.ts_home_num, ts.ts_phone_num, ts.ts_email,
	        ts.ts_bank, ts.ts_acc_hol, ts.ts_bank_num, ts.ts_exprt, ts.ts_lngg, ts.ts_dsg_crt, ts.ts_active_area,
	        ts.ts_acad_back, ts.ts_acad_back_file, ts.ts_carrer, ts.ts_carrer_file,
	        ts.ts_addr, ts.ts_dtl_addr, ts.ts_post_num, ts.ts_srttn, ts.ts_year, ts.ts_dtl_srttn
		FROM Totalapplier ta INNER JOIN Ts ts
		    ON ta.JOIN_ID = ts.JOIN_ID
		WHERE ts.ts_num_seq = 3;

SELECT gh.gh_name, ta.join_id, gh.gh_soc_num, gh.gh_home_num, gh.gh_phone_num, gh.gh_email,
        		gh.gh_job, gh.gh_fax, gh.gh_bank, gh.gh_acc_hol, gh.gh_bank_num, gh.gh_srttn, gh.gh_year,
        		gh.gh_bsns_num, gh.gh_ofc_num, gh.gh_ofc_name, gh.gh_acad_back, gh.gh_acad_back_file,
        		gh.gh_carrer, gh.gh_carrer_file, gh.gh_addr, gh.gh_dtl_addr, gh.gh_dtl_srttn
		FROM TotalApplier ta INNER JOIN GH gh
        	ON ta.APP_NUM_SEQ = gh.APP_NUM_SEQ
		WHERE ta.app_classification = '일반조력자'
        AND ta.app_num_seq = 3;

SELECT gh.gh_name, ta.join_id, gh.gh_soc_num, gh.gh_home_num, gh.gh_phone_num, gh.gh_email,
        		gh.gh_job, gh.gh_fax, gh.gh_bank, gh.gh_acc_hol, gh.gh_bank_num, gh.gh_srttn, gh.gh_year,
        		gh.gh_bsns_num, gh.gh_ofc_num, gh.gh_ofc_name, gh.gh_acad_back, gh.gh_acad_back_file,
        		gh.gh_carrer, gh.gh_carrer_file, gh.gh_addr, gh.gh_dtl_addr, gh.gh_dtl_srttn
		FROM TotalApplier ta INNER JOIN GH gh
        	ON ta.join_id = gh.join_id
		WHERE ta.app_num_seq = 1;
        
SELECT ts.ts_name, ta.join_id, ts.ts_soc_num, ts.ts_home_num, ts.ts_phone_num, ts.ts_email,
	        ts.ts_bank, ts.ts_acc_hol, ts.ts_bank_num, ts.ts_exprt, ts.ts_lngg, ts.ts_dsg_crt, ts.ts_active_area,
	        ts.ts_acad_back, ts.ts_acad_back_file, ts.ts_carrer, ts.ts_carrer_file,
	        ts.ts_addr, ts.ts_dtl_addr, ts.ts_post_num, ts.ts_srttn, ts.ts_year, ts.ts_dtl_srttn
		FROM Totalapplier ta INNER JOIN Ts ts
		    ON ta.JOIN_ID = ts.JOIN_ID
		WHERE ts.APP_NUM_SEQ = 1;


UPDATE Ts SET 
    ts_name = '수정테스트10', ts_soc_num = '수정된주민번호', ts_home_num = '수정된집전번',
    ts_phone_num = '수정된폰번', ts_email = '수정된이메일', ts_bank = '수정된은행', ts_acc_hol = '수정된예금주', ts_bank_num = '수정된계좐호', ts_exprt = '수정된전문분야', ts_lngg = '수정된언어',
    ts_dsg_crt = '수정된지정법원', ts_active_area = '수정된활동지역', ts_acad_back = '수정된학력', ts_acad_back_file = '수정된학력파일',
    ts_carrer = '수정된경력', ts_carrer_file = '수정된경력파일',
    ts_addr = '수정된주소', ts_dtl_addr = '수정된상세주소', ts_post_num = '수정된우편번호'
WHERE TS_NUM_SEQ = 10;

ALTER TABLE Ts MODIFY TS_SOC_NUM VARCHAR2(50);
ALTER TABLE Ts MODIFY TS_POST_NUM VARCHAR2(30);

SELECT ts.TS_NUM_SEQ, ts.ts_name, ta.join_id, ts.ts_soc_num, ts.ts_home_num, ts.ts_phone_num, ts.ts_email,
    ts.ts_bank, ts.ts_acc_hol, ts.ts_bank_num, ts.ts_exprt, ts.ts_lngg, ts.ts_dsg_crt, ts.ts_active_area,
    ts.ts_acad_back, ts.ts_acad_back_file, ts.ts_carrer, ts.ts_carrer_file,
    ts.ts_addr, ts.ts_dtl_addr, ts.ts_post_num, ts.ts_srttn, ts.ts_year, ts.ts_dtl_srttn, ts.APP_NUM_SEQ
FROM Totalapplier ta INNER JOIN Ts ts
    ON ta.JOIN_ID = ts.JOIN_ID
WHERE ta.APP_NUM_SEQ = 1;

COMMIT;

SELECT ud.joinname, ta.join_id, ud.joinpw, ud.joinphone, ud.joinemail, ud.joingen, ub.joinsocnum, ud.joinaddrbasic, ud.joinaddrdetail,
        ins.ins_name, ins.ins_phone, ins.ins_addr
FROM totalapplier ta INNER JOIN Ins ins
ON ta.join_id = ins.joinid
INNER JOIN userbasic ub
ON ins.joinid = ub.joinid
INNER JOIN userdetail ud
ON ub.joinsocnum = ud.joinsocnum
WHERE ta.app_num_seq = 2;

SELECT ud.joinname, ub.joinid, ud.joinpw, ud.joinphone, ud.joinemail, ud.joingen, ub.joinsocnum, ud.joinaddrbasic, ud.joinaddrdetail,
        ins.ins_name, ins.ins_phone, ins.ins_addr
FROM userdetail ud INNER JOIN Userbasic ub 
        ON ud.joinsocnum = ub.joinsocnum
    INNER JOIN Ins ins
        ON ub.joinid = ins.joinid
WHERE ub.joinid = '2번째 아이디';

COMMIT; 

SELECT APP_NUM_SEQ, APP_NAME, JOINID, APP_CLASSIFICATION, APP_DATE
FROM totalapplier;

ALTER TABLE GH ADD GhSupappMemo VARCHAR2(1000) NULL;
ALTER TABLE Ts ADD TsSupappMemo VARCHAR2(1000) NULL;
ALTER TABLE Instt ADD InsttSupappMemo VARCHAR2(1000) NULL;

UPDATE Gh SET
GhSupappMemo = '수정된 보완요청 메모'
WHERE GH_NUM_SEQ = 2;


ALTER TABLE TS ADD ANN_NUM NUMBER(10)  NULL;
ALTER TABLE GH ADD ANN_NUM NUMBER(10)  NULL;
ALTER TABLE INSTT ADD ANN_NUM NUMBER(10)  NULL;

SELECT it.INSTT_NUM_SEQ, it.instt_name, ta.joinid, it.instt_soc_num, it.instt_home_num, it.instt_phone_num, it.instt_email,
	        it.instt_job, it.instt_fax, it.instt_bank, it.instt_acc_hol, it.instt_bank_num,
	        it.instt_srttn, it.instt_dtl_srttn, it.instt_year,
	        it.instt_bsns_num, it.instt_ofc_name,
	        it.instt_acad_back, it.instt_acad_back_file, it.instt_carrer, it.instt_carrer_file,
	        it.instt_addr, it.instt_dtl_addr, it.instt_post_num, it.APP_NUM_SEQ, it.instt_memo, an.ANM_NO_SEQ, uq.unq_reason
		FROM announcement an INNER JOIN userbasic ub
			ON an.anm_no_seq = ub.anmnoseq 
			INNER JOIN unqualify uq
            ON ub.joinid = uq.join_id
            INNER JOIN totalapplier ta
            ON uq.join_id = ta.joinid
            INNER JOIN Instt it
            ON ta.joinid = it.joinid
		WHERE an.anm_no_seq = 1;
        
        
INSERT INTO unqualify
VALUES ('101번째 아이디' ,'추가된 부적격 메모');

ALTER TABLE unqualify MODIFY JOIN_ID VARCHAR2(20) NOT NULL;

DELETE FROM unqualify
WHERE join_id = '4번째 아이디';














