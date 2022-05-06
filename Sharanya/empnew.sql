use empnew_database;

CREATE TABLE EMPLOYEE
(SSN VARCHAR (20) PRIMARY KEY,
FNAMEE VARCHAR (20),
LNAMEE VARCHAR (20),
ADDRESS VARCHAR (20),
SEX CHAR (1),
SALARY INTEGER,
SUPERSSN VARCHAR(20),
DNO INT);

select*from employee;

drop table employee;

INSERT INTO EMPLOYEE (SSN, FNAMEE, LNAMEE, ADDRESS, SEX, SALARY,SUPERSSN,DNO) 
VALUES
 ('RNSECE01','JOHN','SCOTT','BANGALORE','M', 450000,null,3),
 ('RNSCSE01','JAMES','SMITH','BANGALORE','M', 500000,'RNSCSE02',5),
 ('RNSCSE02','HEARN','BAKER','BANGALORE','M', 700000,'RNSCSE03',5),
 ('RNSCSE03','EDWARD','SCOTT','MYSORE','M', 500000,'RNSCSE04',5),
 ('RNSCSE04','PAVAN','HEGDE','MANGALORE','M', 650000,'RNSCSE05',5),
 ('RNSCSE05','GIRISH','MALYA','MYSORE','M', 450000,'RNSCSE06',5),
 ('RNSCSE06','NEHA','SN','BANGALORE','F', 800000,null,5),
 ('RNSACC01','AHANA','K','MANGALORE','F', 350000,'RNSCSE02',1),
 ('RNSACC02','SANTHOSH','KUMAR','MANGALORE','M', 300000,null,1),
 ('RNSISE01','VEENA','M','MYSORE','M', 600000,null,4),
 ('RNSIT01','NAGESH','HR','BANGALORE','M', 500000,null,2);
 
CREATE TABLE DEPARTMENT(DNO VARCHAR (20) PRIMARY KEY,DNAME VARCHAR (20),
MGRSTARTDATE DATE, MGRSSN VARCHAR(20));

INSERT INTO DEPARTMENT VALUES 
(1,'ACCOUNTS','2001-01-01','RNSACC02');
INSERT INTO DEPARTMENT VALUES 
(2,'IT','2001-08-16','RNSIT01'),
(3,'ECE','2001-06-08','RNSECE01'),
(4,'ISE','2001-08-15','RNSISE01'),
(5,'CSE','2001-06-02','RNSCSE05');

CREATE TABLE DLOCATION (DLOC VARCHAR (20),DNO int);

INSERT INTO DLOCATION VALUES ('BANGALORE', '1');
INSERT INTO DLOCATION VALUES ('BANGALORE', '2');
INSERT INTO DLOCATION VALUES ('BANGALORE', '3');
INSERT INTO DLOCATION VALUES ('MANGALORE', '4');
INSERT INTO DLOCATION VALUES ('MANGALORE', '5');

select * from dlocation;


CREATE TABLE PROJECT(PNO INT PRIMARY KEY,PNAME VARCHAR (20),PLOCATION VARCHAR (20),DNO INT);

INSERT INTO PROJECT VALUES (100,'IOT','BANGALORE','5');
INSERT INTO PROJECT VALUES (101,'CLOUD','BANGALORE','5');
INSERT INTO PROJECT VALUES (102,'BIGDATA','BANGALORE','5');
INSERT INTO PROJECT VALUES (103,'SENSORS','BANGALORE','3');
INSERT INTO PROJECT VALUES (104,'BANK MANAGEMENT','BANGALORE','1');
INSERT INTO PROJECT VALUES (105,'SALARY MANAGEMENT','BANGALORE','1');
INSERT INTO PROJECT VALUES (106,'OPENSTACK','BANGALORE','4');
INSERT INTO PROJECT VALUES (107,'SMART CITY','BANGALORE','2');

select * from PROJECT;

CREATE TABLE WORKS_ON(HOURS INT(2),SSN varchar(20),PNO INT);

INSERT INTO WORKS_ON VALUES (4, 'RNSCSE01', 100);
INSERT INTO WORKS_ON VALUES (6, 'RNSCSE01', 101);
INSERT INTO WORKS_ON VALUES (8, 'RNSCSE01', 102);
INSERT INTO WORKS_ON VALUES (10, 'RNSCSE02',100);
INSERT INTO WORKS_ON VALUES (3, 'RNSCSE04', 100);
INSERT INTO WORKS_ON VALUES (4, 'RNSCSE05', 101);
INSERT INTO WORKS_ON VALUES (5, 'RNSCSE06', 102);
INSERT INTO WORKS_ON VALUES (6, 'RNSCSE03', 102);
INSERT INTO WORKS_ON VALUES (7, 'RNSECE01', 103);
INSERT INTO WORKS_ON VALUES (5, 'RNSACC01', 104);
INSERT INTO WORKS_ON VALUES (6, 'RNSACC02', 105);
INSERT INTO WORKS_ON VALUES (4, 'RNSISE01', 106);
INSERT INTO WORKS_ON VALUES (10,'RNSITE01', 107);

select * from works_on;

#Q1
(SELECT DISTINCT P.PNO
FROM PROJECT P, DEPARTMENT D, EMPLOYEE E
WHERE E.DNO=D.DNO
AND D.MGRSSN=E.SSN
AND E.LNAMEE='SCOTT')
UNION
(SELECT DISTINCT P1.PNO
FROM PROJECT P1, WORKS_ON W, EMPLOYEE E1
WHERE P1.PNO=W.PNO
AND E1.SSN=W.SSN
AND E1.LNAMEE='SCOTT');

#Q2
select fnamee,lnamee,salary,(salary+(salary*0.1)) as hike from employee where 
dno in(select dno from project where pname='IOT');

#Q3
select max(salary), min(salary), avg(salary), sum(salary) from employee where  
dno in(select dno from department where dname='accounts');

#Q4
SELECT E.FNAMEE, E.LNAMEE FROM EMPLOYEE E
WHERE NOT EXISTS(SELECT PNO FROM PROJECT WHERE DNO='5' 
NOT IN (SELECT PNO FROM WORKS_ON WHERE E.SSN=SSN)); 


#Q5
select dno, count(*) from employee where salary>600000 and dno in 
(select dno from employee
group by dno having count(*)> 5);
