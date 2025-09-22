-- Use database
\c SchoolDB;

-- Table creation
CREATE TABLE Developer (
    SNO SERIAL PRIMARY KEY,
    EPID INT,
    Name VARCHAR(20),
    Date_of_joining TIMESTAMP,
    Salary INT,
    Roll VARCHAR(10)
);

CREATE TABLE Test (
    SNO SERIAL PRIMARY KEY,
    EPID INT,
    Name VARCHAR(20),
    Date_of_joining TIMESTAMP,
    Salary INT,
    Roll VARCHAR(10)
);

-- View tables
SELECT * FROM Developer;
SELECT * FROM Test;

-- Current timestamp
SELECT NOW();

-- Data insertion
INSERT INTO Developer(EPID, Name, Date_of_joining, Salary, Roll) VALUES
(7, 'arun', NOW(), 20000, 'TL')
(1, 'kishor', NOW(), 54000, 'React'),
(3, 'arul', NOW() - INTERVAL '5 hours', 50000, 'SQL'),
(4, 'ravi', NOW() - INTERVAL '10 days', 34000, 'postgras'),
(5, 'priya', NOW() - INTERVAL '2 months', 70000, 'React'),
(6, 'varun', NOW() - INTERVAL '3 days', 58000, 'manager'),
;

INSERT INTO Test(EPID, Name, Date_of_joining, Salary, Roll) VALUES
(1, 'kishor', NOW(), 40000, 'backend'),
(2, 'pram', NOW() - INTERVAL '5 hours', 35000, 'tester'),
(3, 'guna', NOW() - INTERVAL '5 days', 50000, 'TL');

-- Group employees joined on specific date
SELECT * FROM Developer WHERE Date(Date_of_joining) = '2025-09-19'
UNION ALL
SELECT * FROM Test WHERE Date(Date_of_joining) = '2025-09-19';

-- Minimum salary across both tables
SELECT * FROM (
    SELECT * FROM Developer
    UNION ALL
    SELECT * FROM Test
) AS combined
WHERE Salary = (
    SELECT MIN(COALESCE(d.Salary, t.Salary))
    FROM Developer d
    FULL OUTER JOIN Test t ON d.EPID = t.EPID
);

SELECT * FROM (
    SELECT * FROM Developer
    UNION ALL
    SELECT * FROM Test
) AS combined
WHERE Salary = (
    SELECT MAX(COALESCE(d.Salary, t.Salary))
    FROM Developer d
    FULL OUTER JOIN Test t ON d.EPID = t.EPID
);
-- Remove duplicates using ROW_NUMBER
WITH cts AS (
    SELECT *,
           ROW_NUMBER() OVER(PARTITION BY EPID ORDER BY SNO) AS rn
    FROM Developer
)
SELECT * FROM cts WHERE rn = 1 ORDER BY EPID;

-- Convert Date_of_joining to UTC (Postgres)
SELECT SNO, EPID, Name,
       Date_of_joining AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Kolkata' AS utctime,
       Salary, Roll
FROM Developer;

-- Order A-Z with department
SELECT *, 'dev' AS depart FROM Developer
UNION ALL
SELECT *, 'test' AS depart FROM Test
ORDER BY Name ASC;

-- Order Developer [A-Z] then Test [A-Z]
SELECT *, 'dev' AS sortorder FROM Developer
UNION ALL
SELECT *, 'test' AS sortorder FROM Test
ORDER BY sortorder, Name;

-- Select top next 3 salaries (skip top 3)
SELECT * FROM (
    SELECT * FROM Developer
    UNION ALL
    SELECT * FROM Test
) AS combined
ORDER BY Salary DESC
OFFSET 3
LIMIT 3;

--store procedure to update salary
create procedure update_salary (in em_id int,in em_salary int)
language plpgsql
as $$
begin
update Developer set
Salary=em_salary where EPID = em_id;
end;
$$;

call update_salary(1,80000)
--functions
CREATE FUNCTION get_salary(em_id INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    emp_salary INT;
BEGIN
    SELECT salary INTO emp_salary
    FROM Developer
    WHERE EPID = em_id;

    RETURN emp_salary;
END;
$$;

SELECT get_salary(1)
