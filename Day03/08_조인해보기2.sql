-- INNER ���� (���� ����)
SELECT * FROM info i INNER JOIN auth a
ON i.auth_id = a.auth_id;

-- ����Ŭ ���� (�� ��� ����)
SELECT * FROM info i, auth a
WHERE i.auth_id = a.auth_id;

-- auth_id �÷��� �׳� ���� ��ȣ�ϴ� ��� ��
-- �� ������ ���� ���̺� ��� �����ϱ� �����̴�.
-- �̷��� �÷��� ���̺� �̸��� ���̴���, ��Ī�� �Ἥ ������ Ȯ���ϰ� ������Ѵ�.
SELECT info.auth_id, title, content, name
FROM info INNER JOIN auth
ON info.auth_id = auth.auth_id;

-- �ʿ��� �����͸� ��ȸ�ϰڴ�! ��� �Ѵٸ�
-- WHERE ������ ���� �Ϲ� ������ �ɾ��ָ� �ȴ�.
SELECT
    i.auth_id, i.title, i.content,
    a.name
FROM info i INNER JOIN auth a
ON i.auth_id = a.auth_id
WHERE a.name = 'ȫ����';

-- OUTER JOIN (�ܺ� ����)
SELECT * 
FROM info i LEFT OUTER JOIN auth a
ON i.auth_id = a.auth_id;

SELECT * 
FROM info i RIGHT OUTER JOIN auth a
ON i.auth_id = a.auth_id;

-- ����Ŭ ����
SELECT *
FROM info i, auth a
WHERE i.auth_id = a.auth_id(+);

-- ���� ���̺�� ���� ���̺� �����͸� ��� �о �ߺ��� �����ʹ� �����Ǵ� �ܺ� ����.
SELECT * 
FROM info i FULL OUTER JOIN auth a
ON i.auth_id = a.auth_id;

-- CROSS JOIN�� JOIN������ �������� �ʱ� ������ ��� �÷��� ���� JOIN�� ����
-- �����δ� ���� ������� �ʴ´�.
SELECT *
FROM info CROSS JOIN auth
ORDER BY id ASC;

-- ���� �� ���̺� ���� -> Ű ���� ã�Ƽ� ������ �����ؼ� ���� �ȴ�.
SELECT *
FROM employees e
LEFT OUTER JOIN departments d ON e.department_id = d.department_id
LEFT OUTER JOIN locations loc ON d.department_id = loc.location_id;

/*
- ���̺� ��Ī a, i�� �̿��Ͽ� LEFT OUTER JOIN ���.
- info, auth ���̺� ���.
- job �÷��� scientist�� ����� id, title, content, job�� ���.
*/
SELECT
    i.id, i.title, i.content, a.job
FROM auth a LEFT OUTER JOIN info i
ON i.auth_id = a.auth_id
WHERE a.job = 'scientist';

SELECT 
    e1.employee_id, e1.first_name, e1.manager_id,
    e2.first_name, e2.employee_id
FROM employees e1 JOIN employees e2
ON e1.manager_id = e2.employee_id;


-- ����1
SELECT *
FROM employees emp INNER JOIN departments dep -- 106��
ON emp.department_id = dep.department_id;

SELECT *
FROM employees emp LEFT OUTER JOIN departments dep -- 107��
ON emp.department_id = dep.department_id;

SELECT *
FROM employees emp RIGHT OUTER JOIN departments dep -- 122��
ON emp.department_id = dep.department_id;

SELECT *
FROM employees emp FULL OUTER JOIN departments dep -- 123��
ON emp.department_id = dep.department_id;

-- ����2
SELECT
    emp.first_name || ' ' || emp.last_name AS �̸�,
    emp.department_id
FROM employees emp INNER JOIN departments dep
ON emp.department_id = dep.department_id
WHERE emp.employee_id = 200;

-- ����3
SELECT
    emp.first_name AS ����̸�, emp.job_id AS �������̵�, jo.job_title AS ����Ÿ��Ʋ
FROM employees emp INNER JOIN jobs jo
ON emp.job_id = jo.job_id
ORDER BY emp.first_name ASC;
    
-- ����4
SELECT *
FROM jobs jo LEFT OUTER JOIN job_history joh
ON jo.job_id = joh.job_id;

-- ����5
SELECT
    e.first_name || ' ' || e.last_name,
    d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE e.first_name = 'Steven'
AND e.last_name = 'King';

-- ����6
SELECT * 
FROM employees e CROSS JOIN departments d;

-- ����7
SELECT
    emp.employee_id AS �����ȣ, emp.first_name AS �̸�, emp.salary AS �޿�, 
    dep.department_name AS �μ���, loc.city AS �ٹ���
FROM employees emp INNER JOIN departments dep
ON emp.department_id = dep.department_id
INNER JOIN locations loc ON dep.location_id = loc.location_id
WHERE emp.job_id = 'SA_MAN';

-- ����7 ����� ���
SELECT
    e.employee_id, e.first_name, e.salary,
    d.department_name, loc.city
FROM employees e JOIN departments d
ON e.department_id = d.department_id
INNER JOIN locations loc ON d.location_id = loc.location_id
WHERE e.job_id = 'SA_MAN';

-- ����8
SELECT
    emp.employee_id,emp.first_name,
    jo.job_title
FROM employees emp INNER JOIN jobs jo
ON emp.job_id = jo.job_id
WHERE job_title IN('Stock Manager', 'Stock Clerk');

-- ����8 ����� ���
SELECT
    e.employee_id, e.first_name,
    j.job_title
FROM employees e
JOIN jobs j
ON e.job_id = j.job_id
WHERE job_title IN('Stock Manager', 'Stock Clerk'); -- IN : or�Լ�

-- ����9
SELECT
    dep.department_name
FROM departments dep LEFT OUTER JOIN employees emp
ON dep.department_id = emp.department_id
WHERE emp.employee_id IS NULL;

-- ����9 ����� ���
SELECT
    d.department_name
FROM departments d LEFT OUTER JOIN employees e
ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- ����10
SELECT
    emp1.first_name,
    emp2.first_name AS manager_name
FROM employees emp1 JOIN employees emp2
ON emp1.manager_id = emp2.employee_id;

-- ����10 ����� ���
SELECT
    e1.first_name, e2.first_name AS manager_name
FROM employees e1 JOIN employees e2
ON e1.manager_id = e2.employee_id;

-- ����11
SELECT
    e1.employee_id, e1.first_name, e1.manager_id,
    e2.first_name, e2.job_id, e2.salary
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL
ORDER BY e1.salary DESC;

-- ����11 ����� ���
SELECT
    e1.employee_id, e1.first_name, e1.manager_id,
    e2.first_name, e2.job_id, e2.salary
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e1.manager_id IS NOT NULL
ORDER BY e1.salary DESC;



























