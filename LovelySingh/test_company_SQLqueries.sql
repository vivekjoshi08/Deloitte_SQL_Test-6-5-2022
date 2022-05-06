use test_company_schema1;

create table employee (
ssn varchar(20),
fname varchar (50),
lname varchar (50),
address varchar (50),
s char(1),
salary int,
super_ssn varchar(20),
dno int);

insert into employee 
values
('RNSECE01', 'JOHN', 'SCOTT', 'BANGALORE', 'M', '450000', '', '3'),
('RNSCSE01', 'JAMES', 'SMITH', 'BANGALORE', 'M', '500000', 'RNSCSE02', '5'),
('RNSCSE02', 'HEARN', 'BAKER', 'BANGALORE', 'M', '700000', 'RNCSEE03', '5'),
('RNCSEE03', 'EDWARD', 'SCOTT', 'MYSORE', 'M', '500000', 'RNSCSE04', '5'),
('RNSCSE04', 'PAWAN', 'HEGDE', 'MANGALORE', 'M', '650000', 'RNSCSE05', '5'),
('RNSCSE05', 'GIRISH', 'MALYA', 'MYSORE', 'M', '450000', 'RNSCSE06', '5'),
('RNSCSE06', 'NEHA', 'SN', 'BANGALORE', 'F', '800000', '', '5'),
('RNSACC01', 'AHANA', 'K', 'MANGALORE', 'F', '350000', 'RNSACC02', '1'),
('RNSACC02', 'SANTHOSH', 'KUMAR', 'MANGALORE', 'M', '300000', '', '1'),
('RNSISE01', 'VEENA', 'M', 'MYSORE', 'M', '600000', '', '4'),
('RNSIT01', 'NAGESH', 'HR', 'BANGALORE', 'M', '500000', '', '2');

create table department (
dno int,
dname varchar(20),
mgr_startdate date,
mgr_ssn varchar(20));

insert into department
values
('1','ACCOUNTS',str_to_date('01-JAN-01','%d-%b-%Y'),'RNSACC02'),
('2','ACCOUNTS',str_to_date('01-AUG-16','%d-%b-%Y'),'RNSIT01'),
('3','ACCOUNTS',str_to_date('01-JUN-08','%d-%b-%Y'),'RNSECE01'),
('4','ACCOUNTS',str_to_date('01-AUG-15','%d-%b-%Y'),'RNSISE01'),
('5','ACCOUNTS',str_to_date('01-JUN-02','%d-%b-%Y'),'RNSCSE05');

create table dlocation (
dloc varchar(20),
dno int);

insert into dlocation
values
('Bangalore','1'),
('Bangalore','2'),
('Bangalore','3'),
('Mangalore','4'),
('Mangalore','5');

create table PROJECT (
pno int,
pname varchar(20),
ploc varchar(20),
dno int);

insert into PROJECT
values
('100', 'IOT', 'BANGALORE', '5'),
('101', 'CLOUD', 'BANGALORE', '5'),
('102', 'BIG DATA', 'BANGALORE', '5'),
('103', 'SENSORS', 'BANGALORE', '3'),
('104', 'BANK MANAGEMENT', 'BANGALORE', '1'),
('105', 'SALARY MANAGEMENT', 'BANGALORE', '1'),
('106', 'OPEN STACK', 'BANGALORE', '4'),
('107', 'SMART CITY', 'BANGALORE', '2');

create table works_on(
hours int,
ssn varchar(20),
pno int);

insert into works_on
values
('4','RNSCSE01', '100'),
('6','RNSCSE01', '101'),
('8','RNSCSE01', '102'),
('10','RNSCSE02', '100'),
('3','RNSCSE04', '100'),
('4','RNSCSE05', '101'),
('5','RNSCSE06', '102'),
('6','RNSCSE03', '102'),
('7','RNSECE01', '103'),
('5','RNSACC01', '104'),
('6','RNSACC02', '105'),
('4','RNSISE01', '106'),
('10','RNSIT01', '107');


/*QUERIES*/

/*Q1*/
SELECT DISTINCT P.PNO
FROM PROJECT P, DEPARTMENT D, EMPLOYEE E
WHERE P.DNO=D.DNO
AND D.MGR_SSN=E.SSN
AND E.LNAME='SCOTT'
UNION
SELECT DISTINCT P1.PNO
FROM PROJECT P1, WORKS_ON W, EMPLOYEE E1
WHERE P1.PNO=W.PNO
AND E1.SSN=W.SSN
AND E1.LNAME='SCOTT';

/*Q2*/
SELECT E.FNAME, E.LNAME, 1.1*E.SALARY AS INCR_SAL
FROM EMPLOYEE E, WORKS_ON W, PROJECT P
WHERE E.SSN=W.SSN
AND W.PNO=P.PNO
AND P.PNAME='IOT';

/*Q3*/
SELECT SUM(E.SALARY), MAX(E.SALARY), MIN(E.SALARY), AVG(E.SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO=D.DNO
AND D.DNAME='ACCOUNTS';

/*Q4*/
SELECT E.FNAME, E.LNAME
FROM EMPLOYEE E
WHERE NOT EXISTS(SELECT PNO FROM PROJECT WHERE DNO='5' NOT IN (SELECT
PNO FROM WORKS_ON
WHERE E.SSN=SSN));

/*Q5*/

SELECT E.DNO, COUNT(E.SSN) AS "Number of Employees"
FROM EMPLOYEE E
WHERE E.SALARY > 600000 
AND E.DNO IN (SELECT E1.DNO
FROM EMPLOYEE E1
GROUP BY E1.DNO
HAVING COUNT(E.DNO) > 5 )
GROUP BY E.DNO;