use company_database;

Create table employee(
SSN VARCHAR(20) Primary key,
fname VARCHAR(40),
lname VARCHAR(30),
address VARCHAR(50),
sex VARCHAR(10),
salary INT,
SuperSSN VARCHAR(20) references employee(SSN),
Dno INT references department(Dno));

INSERT INTO employee(SSN,fname,lname ,address,sex ,salary,SuperSSN ,Dno ) VALUES
("RNSECE 01","John","Scott","Bangalore","M",450000,NULL,3),
("RNSCSE 01","James","Smith","Bangalore","M",500000,"RNSCSE 02",5),
("RNSCSE 02","Hearn","Baker","Bangalore","M",700000,"RNSCSE 03",5),
("RNSCSE 03","Edvard","Scott","Mysore","M",500000,"RNSCSE 04",5),
("RNSCSE 04","Pavan","Hegde","Mangalore","M",650000,"RNSCSE 05",5),
("RNSCSE 05","Girish","Malya","Mysore","M",450000,"RNSCSE 06",5),
("RNSCSE 06","Neha","SN","Bangalore","F",800000,NULL,5),
("RNSACC 01","Ahana","k","Mangalore","F",350000,"RNSACC 02",1),
("RNSACC 02","Santosh","kumar","Mangalore","M",300000,NULL,1),
("RNSISE 01","Veena","M","Mysore","F",600000,NULL,4),
("RNSIT 01","Nagesh","HR","Banglore","M",500000,NULL,2);


Create table department(
Dno INT Primary key,
Dname VARCHAR(50),
MgrSSN VARCHAR(20) references employee(SSN),
MgrSTART_DATE DATE);

Insert into department(Dno,Dname,MgrSSN,MgrSTART_DATE) values
(1,"Accounts","RNSACC 02",str_to_date("01-JAN-2001","%d-%b-%Y"));
Insert into department(Dno,Dname,MgrSSN,MgrSTART_DATE) values
(2,"IT","RNSIT 01",str_to_date("01-AUG-2016","%d-%b-%Y")),
(3,"ECE","RNSECE 01",str_to_date("01-JUN-2008","%d-%b-%Y")),
(4,"ISE","RNSISE 01",str_to_date("01-AUG-2015","%d-%b-%Y")),
(5,"CSE","RNSCSE 05",str_to_date("01-JUN-2002","%d-%b-%Y"));


CREATE table dlocation(
Dloc Varchar(30) NOT NULL,
Dno INT references department(Dno)
);

Insert INTO dlocation (Dloc,Dno) Values
("Bangalore",1),
("Bangalore",2),
("Bangalore",3),
("Mangalore",4),
("Mangalore",4);


Create table project(
Pno INT Primary key,
pname VARCHAR(50),
plocation VARCHAR(50),
Dno INT references department(Dno));

Insert into project (Pno,pname,plocation,Dno)  values
(100,"IOT","Bangalore",5),
(101,"Cloud","Bangalore",5),
(102,"Bigdata","Bangalore",5),
(103,"sensors","Bangalore",3),
(104,"Bank management","Bangalore",1),
(105,"salary management","Bangalore",1),
(106,"open stack","Bangalore",4),
(107,"smart city","Bangalore",2);


Create table works_on(
hours int,
SSN VARCHAR(50) references employee(SSN),
Pno INT references project(Pno));

Insert into works_on(hours,SSN,Pno) values
(4,"RNSCSE 01",100),
(6,"RNSCSE 01",101),
(8,"RNSCSE 01",102),
(10,"RNSCSE 02",100),
(3,"RNSCSE 04",100),
(4,"RNSCSE 05",101),
(5,"RNSCSE 06",102),
(6,"RNSCSE 03",102),
(7,"RNSECE 01",103),
(5,"RNSACC 01",104),
(6,"RNSACC 02",105),
(4,"RNSISE 01",106),
(10,"RNSIT 01",107);

#ANSWERS

#1

(SELECT DISTINCT P.Pno
FROM project P, department D, employee E
WHERE E.DNO=D.DNO
AND D.MGRSSN=E.SSN
AND E.LNAME='SCOTT')
UNION
(SELECT DISTINCT P1.Pno
FROM project P1, works_on W, employee E1
WHERE P1.Pno=W.Pno
AND E1.SSN=W.SSN
AND E1.LNAME='SCOTT');


#2

SELECT E.FNAME, E.LNAME, 1.1*E.SALARY AS INCR_SAL
FROM EMPLOYEE E, WORKS_ON W, PROJECT P
WHERE E.SSN=W.SSN
AND W.PNO=P.PNO
AND P.PNAME='IOT';

#3

SELECT SUM(SALARY), MAX(SALARY), MIN(SALARY), AVG(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO=D.DNO
AND D.DNAME='ACCOUNTS';

#4

SELECT E.FNAME, E.LNAME
FROM EMPLOYEE E
WHERE NOT EXISTS(SELECT PNO FROM PROJECT WHERE DNO='5' NOT IN (SELECT
PNO FROM WORKS_ON
WHERE E.SSN=SSN));

#5

SELECT E.DNO, COUNT(E.SSN) AS "Number of Employees"
FROM EMPLOYEE E
WHERE E.SALARY > 600000
AND E.DNO IN (SELECT E1.DNO
FROM EMPLOYEE E1
GROUP BY E1.DNO
HAVING COUNT(E.DNO) > 5 )
GROUP BY E.DNO;