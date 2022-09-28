SELECT * FROM depts;

-- 문제1
INSERT INTO depts
(department_id, department_name, location_id)
VALUES (280, '개발', 1800);
INSERT INTO depts
(department_id, department_name, location_id)
VALUES (290, '회계부', 1800);
INSERT INTO depts
VALUES (300, '재정', 301, 1800);
INSERT INTO depts
VALUES (310, '인사', 302, 1800);
INSERT INTO depts
VALUES (320, '영업', 303, 1700);

COMMIT;

-- 문제2
UPDATE depts SET department_name = 'IT BANK'
WHERE department_name = 'IT Support';

UPDATE depts SET manager_id = 301
WHERE department_id = 290;

UPDATE depts SET department_name = 'IT Help', manager_id = 303, location_id = 1800
WHERE department_name = 'IT Helpdesk';

UPDATE depts SET manager_id = 301
WHERE department_id IN (290, 300, 310, 320);

-- 문제3
DELETE FROM depts WHERE department_id = 320;
DELETE FROM depts WHERE department_id = 220;

-- 문제4
DELETE FROM depts WHERE department_id > 200;

UPDATE depts SET manager_id = 100
WHERE manager_id IS NOT NULL;

MERGE INTO depts d
  USING 
      (SELECT * FROM departments) dep
  ON 
      (d.department_id = dep.department_id)
WHEN MATCHED THEN
  UPDATE SET
     d.department_name = dep.department_name,
     d.manager_id = dep.manager_id,
     d.location_id = dep.location_id
WHEN NOT MATCHED THEN
  INSERT VALUES
     (dep.department_id,
     dep.department_name,
     dep.manager_id,
     dep.location_id);

SELECT * FROM depts;
-- 문제5
SELECT * FROM jobs_it;

CREATE TABLE jobs_it AS 
 (SELECT * FROM jobs WHERE min_salary >= 6000);

INSERT INTO jobs_it
VALUES ('IT_DEV', '아이티개발팀', 6000, 20000);
INSERT INTO jobs_it
VALUES ('NET_DEV', '네트워크개발팀', 5000, 20000);
INSERT INTO jobs_it
VALUES ('SEC_DEV', '보안개발팀', 6000, 19000);

MERGE INTO jobs_it j
   USING 
      (SELECT * FROM jobs WHERE min_salary >= 0) jo
   ON
      (j.job_id = jo.job_id)
WHEN MATCHED THEN
   UPDATE SET
      j.min_salary = jo.min_salary,
      j.max_salary = jo.max_salary
WHEN NOT MATCHED THEN
   INSERT VALUES
      (jo.job_id, jo.job_title, jo.min_salary, jo.max_salary);






































































