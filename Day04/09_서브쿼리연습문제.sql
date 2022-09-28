-- 문제1
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT COUNT(*) FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees 
                WHERE job_id = 'IT_PROG');

-- 문제2
SELECT * FROM employees
WHERE department_id =
(SELECT department_id FROM departments
WHERE manager_id = 100);

-- 문제3
SELECT * FROM employees
WHERE manager_id >
(SELECT manager_id FROM employees
WHERE first_name = 'Pat');

SELECT * FROM employees
WHERE manager_id IN
(SELECT manager_id FROM employees
WHERE first_name = 'James');

-- 문제4
SELECT * FROM
    (
    SELECT ROWNUM AS rn, first_name FROM
        (
        SELECT * FROM employees
        ORDER BY first_name DESC
        )
    )
WHERE rn > 40 AND rn <= 50;

-- 문제5
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl.* FROM
        (
        SELECT employee_id, first_name, phone_number, hire_date
        FROM employees
        ORDER BY hire_date ASC
        ) tbl
    )
WHERE rn > 30 AND rn <= 40;

-- 문제6
SELECT 
    e.employee_id, e.first_name || ' ' || e.last_name AS 이름, e.department_id,
    d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.employee_id ASC;

-- 문제7
SELECT e.employee_id, CONCAT(e.first_name,e.last_name) AS 이름, e.department_id,
    (
    SELECT d.department_name
    FROM departments d
    WHERE e.department_id = d.department_id
    ) AS department
FROM employees e
ORDER BY e.employee_id ASC;

-- 문제8
SELECT 
    d.department_id, d.department_name, d.manager_id, d.location_id,
    loc.street_address, loc.postal_code, loc.city
FROM departments d LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY d.department_id ASC;

-- 문제9 
SELECT d.department_id, d.department_name, d.manager_id, d.location_id,
    (
    SELECT loc.city
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) AS city,
    (
    SELECT loc.postal_code
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) AS postal_code,
    (
    SELECT loc.street_address
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) AS street_address
FROM departments d
ORDER BY department_id ASC;

-- 문제10
SELECT
    loc.location_id, loc.street_address, loc.city,
    c.country_id, c.country_name
FROM locations loc LEFT JOIN countries c
ON loc.country_id = c.country_id
ORDER BY c.country_name ASC;

-- 문제11
SELECT loc.street_address, loc.city, loc.location_id,
    (
    SELECT country_id
    FROM countries c
    WHERE c.country_id = loc.country_id
    ) AS country_id,
    (
    SELECT country_name
    FROM countries c
    WHERE c.country_id = loc.country_id
    ) AS country_name
FROM locations loc
ORDER BY country_name ASC;

-- 문제12
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl.* FROM
        (
        SELECT 
             e.employee_id, e.first_name, e.phone_number, 
             e.hire_date, e.department_id, d.department_name
        FROM employees e LEFT JOIN departments d
        ON e.department_id = d.department_id
        ORDER BY e.hire_date ASC
        ) tbl
    )
WHERE rn > 0 AND rn <= 10;

-- 문제12 강사님 방식
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl.* FROM
        (
        SELECT
            e.employee_id, e.first_name, e.phone_number, e.hire_date,
            d.department_id, d.department_name
        FROM employees e LEFT JOIN departments d
        ON d.department_id = e.department_id
        ORDER BY hire_date ASC
        ) tbl
    )
WHERE rn > 0 AND rn <= 10;

-- 문제13
SELECT tbl.*, d.department_name FROM
    (
    SELECT last_name, job_id, department_id
    FROM employees
    WHERE job_id = 'SA_MAN'
    ) tbl
JOIN departments d
ON tbl.department_id = d.department_id;

-- 문제14
SELECT 
    d.department_id, d.department_name, d.manager_id, a.total
FROM departments d
JOIN
    (
    SELECT department_id, COUNT(*) AS total
    FROM employees
    GROUP BY department_id
    ) a
ON d.department_id = a.department_id
ORDER BY a.total DESC;

-- 문제15
SELECT 
    d.*, loc.street_address, loc.postal_code, 
    NVL(a.result, 0) AS 부서별평균급여
FROM departments d
JOIN locations loc
ON d.location_id = loc.location_id
LEFT JOIN
    (
    SELECT 
        department_id, TRUNC(AVG(salary)) AS result
    FROM employees 
    GROUP BY department_id
    ) a
ON d.department_id = a.department_id;

-- 문제16
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl.* FROM
        (
        SELECT 
            d.*, loc.street_address, loc.postal_code, 
            NVL(a.result, 0) AS 부서별평균급여
        FROM departments d
        JOIN locations loc
        ON d.location_id = loc.location_id
        LEFT JOIN
            (
            SELECT 
                department_id, TRUNC(AVG(salary)) AS result
            FROM employees 
            GROUP BY department_id
            ) a
        ON d.department_id = a.department_id
        )tbl
    )
WHERE rn > 10 AND rn <= 20;





-- 문제1 복습
SELECT * FROM employees
WHERE salary >
    (
    SELECT AVG(salary)
    FROM employees
    );

SELECT COUNT(*) FROM employees
WHERE salary >
    (
    SELECT AVG(salary)
    FROM employees
    );
    
SELECT * FROM employees
WHERE salary >
    (
    SELECT AVG(salary)
    FROM employees
    WHERE job_id = 'IT_PROG'
    );
    
-- 문제2 복습
SELECT * FROM employees
WHERE department_id =
    (
    SELECT department_id
    FROM departments
    WHERE manager_id = 100
    );
    
-- 문제3 복습
SELECT *
FROM employees
WHERE manager_id >
    (
    SELECT manager_id
    FROM employees
    WHERE first_name = 'Pat'
    );

SELECT *
FROM employees
WHERE manager_id IN
    (
    SELECT manager_id
    FROM employees
    WHERE first_name = 'James'
    );

-- 문제4 복습
SELECT * FROM
    (
    SELECT ROWNUM AS rn, first_name FROM
        (
        SELECT *
        FROM employees
        ORDER BY first_name DESC
        )
    )
WHERE rn > 40 AND rn <= 50;

-- 문제5 복습
SELECT * FROM
    (
    SELECT ROWNUM AS rn, employee_id, first_name, phone_number FROM
        (
        SELECT *
        FROM employees
        ORDER BY hire_date ASC
        )
    )
WHERE rn > 30 AND rn <= 40;

-- 문제6 복습
SELECT 
    e.employee_id, CONCAT(first_name, last_name),
    d.department_id, d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY e.employee_id ASC;

-- 문제7 복습
SELECT employee_id, CONCAT(first_name, last_name),
    (
    SELECT department_id
    FROM departments d
    WHERE d.department_id = e.department_id
    ) AS department_id,
    (
    SELECT department_name
    FROM departments d
    WHERE d.department_id = e.department_id
    ) AS department_name
FROM employees e
ORDER BY employee_id;
    
-- 문제8 복습
SELECT
    d.department_id, d.department_name, d.manager_id,
    loc.location_id, loc.street_address, loc.postal_code, loc.city
FROM departments d LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY d.department_id ASC;

-- 문제9 복습
SELECT d.department_id, d.department_name, d.manager_id,
    (
    SELECT loc.location_id
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) location_id,
    (
    SELECT loc.street_address
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) street_address,
    (
    SELECT loc.postal_code
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) postal_code,
    (
    SELECT loc.city
    FROM locations loc
    WHERE loc.location_id = d.location_id
    ) city
FROM departments d
ORDER BY d.department_id ASC;

-- 문제10 복습
SELECT
    loc.location_id, loc.street_address, loc.city,
    c.country_id, c.country_name
FROM locations loc LEFT JOIN countries c
ON loc.country_id = c.country_id
ORDER BY c.country_name ASC;

-- 문제11 복습
SELECT loc.location_id, loc.street_address, loc.city,
    (
    SELECT c.country_id
    FROM countries c
    WHERE c.country_id = loc.country_id
    ) country_id,
    (
    SELECT c.country_name
    FROM countries c
    WHERE c.country_id = loc.country_id
    ) country_name
FROM locations loc
ORDER BY country_name ASC;

-- 문제12 복습
SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl.* FROM
        (
        SELECT
            e.employee_id, e.first_name, e.phone_number, e.hire_date, e.department_id,
            d.department_name
        FROM employees e LEFT JOIN departments d
        ON e.department_id = d.department_id
        ORDER BY e.hire_date ASC
        ) tbl
    )
WHERE rn > 0 AND rn <= 10;

-- 문제13 복습
SELECT d.department_name, tbl.* FROM
    (
    SELECT e.last_name, e.job_id, e.department_id
    FROM employees e
    WHERE job_id = 'SA_MAN'
    )tbl
JOIN departments d
ON d.department_id = tbl.department_id;

-- 문제14 복습
SELECT d.department_id, d.department_name, d.manager_id, tbl.* 
FROM departments d
JOIN
    (
    SELECT department_id, COUNT(*) AS result
    FROM employees
    GROUP BY department_id
    )tbl
ON d.department_id = tbl.department_id
ORDER BY result DESC;

































