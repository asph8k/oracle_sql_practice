SELECT * FROM depts;

-- ����1
INSERT INTO depts
(department_id, department_name, location_id)
VALUES (280, '����', 1800);
INSERT INTO depts
(department_id, department_name, location_id)
VALUES (290, 'ȸ���', 1800);
INSERT INTO depts
VALUES (300, '����', 301, 1800);
INSERT INTO depts
VALUES (310, '�λ�', 302, 1800);
INSERT INTO depts
VALUES (320, '����', 303, 1700);

COMMIT;

-- ����2
UPDATE depts SET department_name = 'IT BANK'
WHERE department_name = 'IT Support';

UPDATE depts SET manager_id = 301
WHERE department_id = 290;

UPDATE depts SET department_name = 'IT Help', manager_id = 303, location_id = 1800
WHERE department_name = 'IT Helpdesk';

UPDATE depts SET manager_id = 301
WHERE department_id IN (290, 300, 310, 320);

-- ����3
DELETE FROM depts WHERE department_id = 320;
DELETE FROM depts WHERE department_id = 220;

-- ����4
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
-- ����5
SELECT * FROM jobs_it;

CREATE TABLE jobs_it AS 
 (SELECT * FROM jobs WHERE min_salary >= 6000);

INSERT INTO jobs_it
VALUES ('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO jobs_it
VALUES ('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO jobs_it
VALUES ('SEC_DEV', '���Ȱ�����', 6000, 19000);

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






































































