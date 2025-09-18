USE Schooldb;
IF OBJECT_ID('dbo.Employee1','U') IS NOT NULL
    DROP TABLE Employee1;
GO
 
 CREATE TABLE Employee1(
    EmplyeeID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(20) NOT NULL,
    Age INT,
    Department VARCHAR(10)
 );
 GO
 ALTER TABLE Employee1
 ALTER COLUMN Age int NOT NULL;

 ALTER TABLE Employee1
 ADD ID int UNIQUE;



 INSERT INTO Employee1(Name,Age, Department,ID) VALUES
 ('gopi',18,'cse',3);
 INSERT INTO Employee1(Name,Age, Department,ID) VALUES
 ('ABI',19,'IT',4);

SELECT * FROM Employee1;



ALTER TABLE Employee
ADD Bonus INT
CONSTRAINT CK_Employee_Bonus CHECK (Bonus > 10)

SELECT * FROM Employee;

INSERT INTO Employee(Name,Age,Department,Salary) VALUES
('KARTHICK',18,'CSE',100000)

ALTER TABLE Employee
DROP CONSTRAINT CK_Employee_Bonus;
ALTER TABLE Employee
ADD CONSTRAINT CK_Employee_Bonus DEFAULT 11 FOR Bonus;

SET SHOWPLAN_TEXT ON;
GO
SELECT *
FROM Employee1 WHERE Age = 18;
GO
SET SHOWPLAN_TEXT OFF;


CREATE INDEX idx_lastname
ON Employee1 (Age);
