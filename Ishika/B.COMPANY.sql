USE COMPANY;

CREATE TABLE EMPLOYEE
(
SSN VARCHAR(20) PRIMARY KEY NOT NULL,
FNAME VARCHAR(20),
LNAME VARCHAR(20),
ADDRESS VARCHAR(20),
S VARCHAR(1),
SALARY INT,
SUPERSSN VARCHAR(20),
DNO INT REFERENCES DEPARTMENT
);

INSERT INTO EMPLOYEE VALUES
('RNSECE01','JOHN','SCOTT','BANGALORE','M',450000,'',3),
('RNSCSE01','JAMES','SMITH','BANGALORE','M','500000','RNSCSE02',5),
('RNSCSE02','HEARN','BAKER','BANGALORE','M',700000,'RNSCSE03',5),
('RNSCSE03','EDWARD','SCOTT','MYSORE','M',500000,'RNSCSE04',5),
('RNSCSE04','PAVAN','HEDGE','MANGALORE','M',650000,'RNSCSE05',5),
('RNSCSE05','GIRISH','MALYA','MYSORE','M',450000,'RNSCSE06',5),
('RNSCSE06','NEHA','SN','BANGALORE','F',800000,'',5),
('RNSACC01','AHANA','K','MANGALORE','F',350000,'RNSACC02',1),
('RNSACC02','SANTOSH','KUMAR','MANGALORE','M',300000,'',1),
('RNSISE01','VEENA','M','MYSORE','M',600000,'',4),
('RNSIT01','NAGESH','HR','BANGALORE','M',500000,'',2);



CREATE TABLE DEPARTMENT
(
DNO INT PRIMARY KEY,
DNAME VARCHAR(10),
MGRSTARTD DATE,
MGRSSN VARCHAR(10)
);

INSERT INTO DEPARTMENT VALUES
(1,'ACCOUNTS',STR_TO_DATE("01-JAN-2001","%d-%b-%Y"),'RNSACC02'),
(2,'IT',STR_TO_DATE('01-AUG-2016','%d-%b-%Y'),'RNSIT01'),
(3,'ECE',STR_TO_DATE('01-JUN-2008','%d-%b-%Y'),'RNSECE01'),
(4,'ISE',STR_TO_DATE('01-AUG-2015','%d-%b-%Y'),'RNSISE01'),
(5,'CSE',STR_TO_DATE('01-JUN-2002','%d-%b-%Y'),'RNSCSE05');



CREATE TABLE DLOCATION
(
DLOC VARCHAR(10) ,
DNO INT REFERENCES DEPARTMENT(DNO)
);

INSERT INTO DLOCATION VALUES
('BANGALORE',1),
('BANGALORE',2),
('BANGALORE',3),
('MANGALORE',4),
('MANGALORE',5);

CREATE TABLE PROJECT
(
PNO INT PRIMARY KEY,
PNAME VARCHAR(20),
PLOCATION VARCHAR(10),
DNO INT REFERENCES DEPARTMENT(DNO)
);

INSERT INTO PROJECT VALUES 
(100,'IOT','BANGALORE',5),
(101,'CLOUD','BANGALORE',5),
(102,'BIG DATA','BANGALORE',5),
(103,'SENSORS','BANGALORE',3),
(104,'BANK MANAGEMENT','BANGALORE',1),
(105,'SALARY MANAGEMENT','BANGALORE',1),
(106,'OPENSTACK','BANGALORE',4),
(107,'SMART CITY','BANGALORE',2);

CREATE TABLE WORKSON
(
HOURS INT,
SSN VARCHAR(20) REFERENCES EMPLOYEE(SSN),
PNO INT REFERENCES PROJECT(PNO)
);

INSERT INTO WORKSON VALUES
(4,'RNSCSE01',100),
(6,'RNSCSE01',101),
(8,'RNSCSE01',102),
(10,'RNSCSE02',100),
(3,'RNSCSE04',100),
(4,'RNSCSE05',101),
(5,'RNSCSE06',102),
(6,'RNSCSE03',102),
(7,'RNSECE01',103),
(5,'RNSACC01',104),
(6,'RNSACC02',105),
(4,'RNSISE01',106),
(10,'RNSIT01',107);

SELECT * FROM EMPLOYEE;
select * from department;
select * from dlocation;
select * from project;
select * from workson;

-- q1
select pno from employee e join project p on
e.dno=p.dno where lname='SCOTT';

-- Q2
SELECT FNAME, SALARY* 1.1 AS SALARY  FROM EMPLOYEE E JOIN PROJECT P ON
E.DNO=P.DNO WHERE PNAME='IOT';

-- Q3
SELECT SUM(SALARY),MAX(SALARY),MIN(SALARY),AVG(SALARY) FROM EMPLOYEE E JOIN DEPARTMENT D ON
E.DNO=D.DNO GROUP BY DNAME HAVING DNAME='ACCOUNTS';

-- Q4
SELECT FNAME FROM EMPLOYEE E INNER JOIN WORKSON W ON
E.SSN=W.SSN NOT IN 
(SELECT FNAME FROM EMPLOYEE WHERE NOT EXISTS 
(SELECT PNO FROM PROJECT WHERE DNO=5));

-- Q5
SELECT D.DNO , COUNT(*) AS COUNT FROM DEPARTMENT D
INNER JOIN EMPLOYEE E ON D.DNO=E.DNO
WHERE SALARY>600000 AND D.DNO IN
(SELECT DNO FROM EMPLOYEE GROUP BY DNO HAVING COUNT(*)>=5);