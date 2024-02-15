use mydatabase;
CREATE TABLE employees(
e_id int not null,
e_name varchar(20),
e_salary int,
e_age int,
e_gender varchar(20),
e_dept varchar(20),
primary key(e_id)
);

CREATE TABLE sample(
s_name varchar(20),
s_num int
)


INSERT into employees
VALUES(1, 'Namir', 90000, 20, 'Male', 'Data Engg')
INSERT INTO employees
VALUES(2, 'Shah', 80000, 18, 'Male', 'Computer Engg')
INSERT INTO employees
VALUES(3, 'Vahid', 100000, 40, 'Male', 'Business analyst')
INSERT INTO employees
VALUES(4, 'Samira', 90000, 35, 'Female', 'Testing')
INSERT INTO employees
VALUES(8, 'Ibaad', 100000, 32, 'Male', 'Data Engg', 8694959382);
INSERT INTO employees
VALUES(6, 'Armaan', 80000, 34, 'Male', 'Business analyst', 6957380584);

SELECT * from employees; 
Select e_name from employees;
SELECT * from employees WHERE e_dept ='Data Engg';

SELECT DISTINCT e_gender from employees;
SELECT DISTINCT e_name from employees;
SELECT DISTINCT e_dept from employees;

SELECT e_gender from employees WHERE e_gender = 'Male'
SELECT e_salary from employees WHERE e_salary>80000
SELECT e_salary from employees WHERE e_salary>=80000
SELECT * from employees WHERE e_gender='Female'
SELECT * from employees WHERE e_salary>80000

Select * from employees WHERE e_salary >80000 AND e_gender='Male'
SELECT * from employees WHERE e_gender = 'Male' AND e_age<30;
SELECT * from employees WHERE e_gender = 'Male' OR e_age <30;
SELECT * from employees Where e_id = 1 OR e_dept = 'Business analyst';
SELECT * from employees Where NOT e_dept = 'Testing'; 
SELECT * from employees WHERE NOT  e_age>30;

SELECT MIN(e_age) from employees;
SELECT MAX(e_age) from employees; 
SELECT COUNT(*) from employees WHERE e_gender = 'Male';
SELECT SUM(e_salary) from employees;
SELECT AVG(e_age) from employees;

SELECT LTRIM('Female') from employees;
SELECT LOWER('Female') from employees;
SELECT UPPER('Female') from employees;
SELECT REVERSE('Male') from employees;

SELECT * from employees ORDER BY e_salary DESC;
SELECT * FROM employees ORDER BY e_age ASC;
SELECT TOP 3 * from employees;
SELECT TOP 2 * from employees;
SELECT TOP 3 * from employees ORDER BY e_age DESC;

UPDATE employees SET e_age=50 WHERE e_name = 'Vahid';
SELECT * FROM employees;

DELETE FROM employees Where e_name = 'Shah';

TRUNCATE TABLE employees;


--CREATING NEW TABLE
CREATE TABLE company(
c_id int,
c_name varchar(30),
c_revenue bigint,
c_dept varchar(30)
);

Drop Table company;

--INSERTING VALUES
INSERT into company
VALUES(1, 'Wipro', 1000000000, 'Data Engg');
INSERT into company
VALUES(2, 'Infotech',300000000, 'Information Technology');
INSERT into company
VALUES(3, 'Tata', 200000000, 'Production');
SELECT * from company;
INSERT INTO company
VALUES (4, 'MAXUS', 400000000, 'Testing');

--INNER JOIN
SELECT employees.e_dept, employees.e_name, employees.e_salary, company.c_name, company.c_dept, company.c_revenue
FROM employees
INNER JOIN company ON employees.e_dept = company.c_dept;

--LEFT JOIN 
SELECT employees.e_dept, employees.e_salary, company.c_dept, company.c_revenue
FROM employees
LEFT JOIN company
ON employees.e_dept = company.c_dept; 

--RIGHT JOIN
SELECT employees.e_dept, employees.e_name, company.c_name, company.c_dept
FROM employees
RIGHT JOIN company
ON employees.e_dept = company.c_dept;

--FULL JOIN
SELECT employees.e_name, employees.e_dept, company.c_name, company.c_dept
FROM employees
FULL JOIN company
ON employees.e_dept = company.c_dept;

--UPDATING USING JOIN
UPDATE employees
SET e_salary = e_salary + 1000
from employees
JOIN company 
ON employees.e_dept = company.c_dept
WHERE e_dept = 'Data Engg';
SELECT * FROM employees

--DELETING USING JOIN
DELETE employees
From employees
Join company
ON employees.e_dept = company.c_dept
Where e_dept = 'Testing';

--UNION OPERATOR
SELECT  * from employees
UNION
SELECT * from company

--UNION ALL OPERATOR
SELECT  * from employees
UNION ALL
SELECT * from company

--EXCEPT OPERATOR
SELECT  * from employees
EXCEPT
SELECT * from company

--INTERSECT OPERATOR
SELECT  * from employees
INTERSECT
SELECT * from company

--CREATING VIEW
CREATE VIEW female_employee AS
SELECT *from employees
WHERE e_gender = 'Female';
SELECT *from female_employee

CREATE VIEW data_dept AS
SELECT *from employees
WHERE e_dept = 'Data Engg';
SELECT * from data_dept;

--GROUP BY and ORDER BY
SELECT e_dept, SUM(e_salary) AS [TOTAL SALARY OF SPECIFIC DEPARTMENT]
FROM employees
GROUP BY e_dept
ORDER BY [TOTAL SALARY OF SPECIFIC DEPARTMENT] DESC;


--DROP A VIEW
DROP VIEW data_dept;

--ALTER ADD COLUMN
ALTER TABLE employees
ADD e_surname varchar(20);
ALTER TABLE company
ADD c_owner varchar(20);

--ALTER DROP COLUMN
ALTER TABLE employees
DROP COLUMN e_surname;
ALTER TABLE company
DROP c_owner;

--CREATING USER DEFINED FUNCTION(SCALAR)
CREATE FUNCTION  add_number(@num int)
RETURNS int
AS
BEGIN
    DECLARE @result int ;
    SET @result = 5 + @num;
    RETURN @result;
END;


SELECT dbo.add_five(10);  
SELECT dbo.add_five(20);  


--CREATE USER DEFINED FUNCTION(TABLE)
CREATE FUNCTION select_gender(@gender varchar(20))
RETURNS able
AS
RETURN(SELECT * from employees WHERE e_gender=@gender)

SELECT *from dbo.select_gender('Male');
SELECT *from dbo.select_gender('Female');

CREATE FUNCTION salary_of_person(@ename varchar(20))
RETURNS TABLE 
AS
RETURN (SELECT e_salary from employees WHERE e_name = @ename )
drop function salary_of_person;
SELECT *from dbo.salary_of_person('Namir');
SELECT *from dbo.salary_of_person('Vahid');

CREATE FUNCTION employee_detail_by_name(@ename varchar(20))
RETURNS TABLE
AS
RETURN (SELECT *from employees WHERE e_name = @ename)

SELECT *from dbo.employee_detail_by_name('Namir');
SELECT *from dbo.employee_detail_by_name('Samira');



--CREATIN TEMPORARY TABLE
CREATE TABLE #students(
s_id int,
s_name varchar(20)
);

INSERT INTO #students
VALUES(1, 'Namir');
INSERT INTO #students
VALUES(2, 'Shah');

SELECT *from #students;

--CASE STATEMENT
SELECT 
CASE 
WHEN 10>20 THEN '10 is greater than 20'
WHEN 20>10 THEN '20 is greater than 10'
else '10 is equal to 20'
END;

--APPLYING CASE STATEMENT ON EMPLOYEES TABLE
SELECT *,grade = 
CASE
WHEN e_salary<90000 THEN 'C'
WHEN e_salary<100000 THEN 'B'
ELSE 'C'
END
FROM employees
GO

--IIF function
SELECT 
IIF(10>20, '10 is greater thann 20', '10 is less than 20');

--IMPLEMENTING IIF FUNCTION IN EMPLOYYE TABLE
SELECT * from employees;
SELECT e_id, e_name, e_age, IIF(e_age>30, 'Old employee', 'Young employee') AS employee_generation;


--STORED PROCEDURE
CREATE PROCEDURE employee_age
AS
SELECT e_age from employees
GO;
EXEC employee_age;

CREATE PROCEDURE employee_details
AS
SELECT * from employees
GO;
EXEC employee_details;

CREATE PROCEDURE employee_gender @gender varchar(20)
AS
SELECT * from employees
WHERE e_gender = @gender
GO
EXEC employee_gender @gender = 'Male';
EXEC employee_gender @gender = 'Female';


--TRIGGERS


--EXCEPTION HANDLING
DECLARE @val1 INT;
DECLARE @val2 INT;

BEGIN TRY
SET @val1 = 8;
SET @val2 = @val1/0;
END TRY

BEGIN CATCH
Print error_message()
END CATCH

DECLARE @val1 INT;
DECLARE @val2 INT;

SELECT *from employees;
BEGIN TRY
SELECT e_salary+e_name from employees
END TRY

BEGIN CATCH
PRINT 'Cannot add a string to numerical value'
END CATCH
GO

BEGIN TRY
DECLARE @name varchar(20);
DECLARE @sal bigint;
SET @name = 'Namir';
SET @sal = 9000000;
Print @name + 'earns' + @sal
End TRY

BEGIN CATCH
SELECT 
@@ERROR AS Error,
ERROR_NUMBER() AS Error_Number,
ERROR_SEVERITY() AS Error_Severity,
ERROR_STATE() AS Error_State,
ERROR_PROCEDURE() AS Error_Procedure,
ERROR_LINE() AS Error_Line,
ERROR_MESSAGE() AS Error_Message;
END CATCH






--TRANSACTION
BEGIN TRANSACTION
UPDATE employees SET e_age = 21 Where e_age = 20;
SELECT * from employees;

ROLLBACK TRANSACTION
SELECT * from employees;

UPDATE employees SET e_age = 21 Where e_age = 20;
SELECT * from employees;
COMMIT TRANSACTION  --NOW IT CANNOT BE ROLLED BACK

--USING TRANSACTION INSIDE TRY AND CATCH
BEGIN TRY
BEGIN TRANSACTION
UPDATE employees SET e_salary = e_salary+2000 WHERE e_gender = 'Male'
COMMIT TRANSACTION
Print 'Transaction committed'
END TRY

BEGIN CATCH
ROLLBACK TRANSACTION
PRINT 'Transaction Rolled back'
END CATCH

SELECT *FROM employees;

BEGIN TRY
BEGIN TRANSACTION
UPDATE employees SET e_salary = e_salary+e_name WHERE e_gender = 'Male'
COMMIT TRANSACTION
Print 'Transaction committed'
END TRY

BEGIN CATCH
ROLLBACK TRANSACTION
PRINT 'Transaction Rolled back'
END CATCH


--SUBQUERIES
SELECT * from employees WHERE e_salary > (SELECT avg(e_salary) from employees);

SELECT *from employees WHERE e_salary > (SELECT SUM(e_salary)  from employees WHERE e_dept = 'Testing');


--RECOVERY MODEL(SIMPLE)
USE[master]
GO
ALTER DATABASE [mydatabase]
SET RECOVERY SIMPLE WITH NO_WAIT
GO

--RECOVERY MODEL(FULL)
USE[master]
GO
ALTER DATABASE [mydatabase]
SET RECOVERY FULL WITH NO_WAIT
GO

--RECOVERY MODEL(BULK LOGGED)
USE[master]
GO
ALTER DATABASE[mydatabase]
SET RECOVERY BULK_LOGGED WITH NO_WAIT
GO

ALTER TABLE employees
ADD e_phone_number bigint;

UPDATE employees
SET e_phone_number = 9326922187 WHERE e_name = 'Namir';
UPDATE employees
SET e_phone_number = 9876598032 WHERE e_name = 'Shah';
UPDATE employees
SET e_phone_number = 9702457719 WHERE e_name = 'Vahid';
UPDATE employees
SET e_phone_number = 8355940919 WHERE e_name = 'Samira';

