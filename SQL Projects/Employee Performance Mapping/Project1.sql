/*
1- Create a database named employee, then import data_science_team.csv proj_table.csv and 
emp_record_table.csv into the employee database from the given resources
    */

CREATE DATABASE employee;
USE employee;

/*
<p align="center">
  <img src="https://github.com/RazanKhAlhasan/Naqi/assets/148292301/c741a65a-5461-4a91-bc65-9711789b1176" width="200"/>
</p>
*/
-- 3
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table;

-- 4
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING 
FROM emp_record_table
WHERE EMP_RATING < 2 OR EMP_RATING > 4 OR EMP_RATING BETWEEN 2 AND 4;

-- 5
SELECT CONCAT(FIRST_NAME, " " ,LAST_NAME) AS FullName
FROM emp_record_table
WHERE DEPT = "Finance";

-- 6
SELECT e.EMP_ID, CONCAT(e.FIRST_NAME, " ", e.LAST_NAME) AS EmployeeName,
(SELECT COUNT(*) FROM emp_record_table r WHERE r.MANAGER_ID = e.EMP_ID) AS NumOfReporters
FROM emp_record_table e
WHERE e.EMP_ID IN (SELECT DISTINCT MANAGER_ID FROM emp_record_table)
ORDER BY e.EMP_ID;

-- 7
SELECT EMP_ID, FIRST_NAME, LAST_NAME FROM emp_record_table
WHERE DEPT = "FINANCE"
UNION 
SELECT EMP_ID, FIRST_NAME, LAST_NAME FROM emp_record_table
WHERE DEPT = "HEALTHCARE";

-- 8

SELECT e.EMP_ID, e.FIRST_NAME, e.LAST_NAME, e.ROLE, e.DEPT, e.EMP_RATING, d.max_emp_rating
FROM emp_record_table e
JOIN (
    SELECT DEPT, MAX(EMP_RATING) AS max_emp_rating
    FROM emp_record_table
    GROUP BY DEPT
) d ON e.DEPT = d.DEPT;

-- 9
SELECT MIN(SALARY) AS MIN_SALARY, MAX(SALARY) AS MAX_SALARY, ROLE
FROM emp_record_table
GROUP BY ROLE;

-- 10
SELECT EMP_ID, FIRST_NAME, LAST_NAME, RANK() OVER (ORDER BY EXP DESC) AS ExpRank
from emp_record_table;

-- 11

CREATE VIEW EM AS 
SELECT FIRST_NAME, LAST_NAME, COUNTRY, SALARY
FROM emp_record_table
WHERE SALARY > 6000;

SELECT * FROM EM;

-- 12

SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
FROM emp_record_table WHERE EMP_ID IN (SELECT EMP_ID FROM emp_record_table WHERE EXP > 10);

-- 13

DELIMITER &&
CREATE PROCEDURE get_experience_details()
BEGIN
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP FROM emp_record_table WHERE EXP > 3;
END &&
CALL get_experience_details();
DELIMITER;



-- 14
DELIMITER &&
CREATE FUNCTION CheckJobRoel(exp_years INT) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
    DECLARE job_Role VARCHAR(50);
    
    IF exp_years <= 2 THEN SET job_Role = 'JUNIOR DATA SCIENTIST';
    ELSEIF exp_years <= 5 THEN SET job_Role = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp_years <= 10 THEN SET job_Role = 'SENIOR DATA SCIENTIST';
    ELSEIF exp_years <= 12 THEN SET job_Role = 'LEAD DATA SCIENTIST';
    ELSE SET exp_years = 'MANAGER';
    END IF;
    
    RETURN job_Role;
END &&

DELIMITER ;

DROP FUNCTION CheckJobRoel;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP, Role,
CheckJobRoel(EXP) AS Assigned_Job_Profile FROM data_science_team;


-- 15
CREATE INDEX FNameCheck
ON emp_record_table (FIRST_NAME(20));

SELECT FIRST_NAME FROM emp_record_table
WHERE (FIRST_NAME = "Eric"); 

-- 16

SELECT EMP_ID, FIRST_NAME, LAST_NAME, SALARY, EMP_RATING,
          (SALARY * 0.05 * EMP_RATING) AS Bonus
FROM emp_record_table;

-- 17

SELECT CONTINENT, COUNTRY, AVG(SALARY)
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY
ORDER BY CONTINENT, COUNTRY;




