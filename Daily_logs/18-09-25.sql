SELECT GETUTCDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'India Standard Time' AS LocalTime;
SELECT GETDATE() AT TIME ZONE 'India Standard Time' AT TIME ZONE 'UTC' AS UTC;

--index

CREATE TABLE Employee2(
    EmplyeeID INT PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
 );
 INSERT INTO Employee2(EmplyeeID,Name) VALUES
 (21,'cse');

 INSERT INTO Employee2(EmplyeeID,Name) VALUES
 (19,'IT');

 create index edx_name on Employee2(EmplyeeID);

 SELECT * FROM Employee2;
 EXEC sp_helpindex 'Employee2';

 -- alter table Employee2 Rename column EmplyeeID to empId;
 alter table Employee2 add email varchar(30);

 EXEC sp_rename 'Employee2', 'emp2' ;
 select * from emp2;

  create clustered index edx_email on Employee2(email);

  CREATE TABLE Employee3(
    EmplyeeID INT,
    Name VARCHAR(20) NOT NULL,
 );
 alter table Employee3 
 add age int;
  alter table Employee3 
 add num int;

INSERT INTO Employee3 VALUES
 (6);

 INSERT INTO Employee3(EmplyeeID,Name) VALUES
 (1,'surya');

 create clustered index idx_name on Employee3(EmplyeeID);
 create nonclustered index idx_age_num on Employee3(num,age);

 EXEC sp_helpindex 'Employee3';


 --join

create table Department(
	ID int,
	depart varchar(10),
	);

insert into Department (ID,depart) values
(1,'ECE'),
(2,'CSE'),
(3,'IT'),
(4,'BIO');

create table student3(
	EID int,
	Name varchar(20),
	depart varchar(20)
	);
insert into student3 (EID, Name,depart) values
(1,'kishor','ECE'),
(5,'gopi','CSE'),
(5,'arul','IT'),
(4,'arun','BIO');
--innerjoin
select Name from student3 inner join Department on student3.EID=Department.ID 
--left join
select Name from student3 left join Department on student3.EID=Department.ID 
SELECT 
    s.EID,
    s.Name,
    s.depart AS StudentDept,
    d.depart AS DeptFromMaster
FROM student3 AS s
LEFT JOIN Department AS d
    ON s.EID = d.ID;
--right join
SELECT 
    s.EID,
    s.Name,
    s.depart AS StudentDept,
    d.depart AS DeptFromMaster
FROM student3 AS s
RIGHT JOIN Department AS d
    ON s.EID = d.ID;

SELECT 
    s.EID,
    s.Name,
    s.depart AS StudentDept,
    d.depart AS DeptFromMaster
FROM student3 AS s
FULL OUTER JOIN Department AS d
    ON s.EID = d.ID;

select a.Name,a.depart,b.depart from student3 a,student3 b where a.EID = b.EID 

--agregate function
select avg(EID) from student3;

select * from student3
where name like 'k__h__%';

select depart from student3
union all
select depart from Department ;
