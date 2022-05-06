use companyassignment;

create table employee(
ssn varchar(20) primary key,
fname varchar(10),
lname varchar(10),
address varchar(20),
S char(1),
salary int,
superssn varchar(20),
dno int
);
INSERT INTO employee VALUES("RNSECE01", "JOHN","SCOTT","BANGALORE","M",45000,NULL,3);
INSERT INTO employee VALUES("RNSCSE01", "JAMES","SMITH","BANGALORE","M",50000,"RNSCSE02",5);
INSERT INTO employee VALUES("RNSCSE02", "HEARN","BAKER","BANGALORE","M",70000,"RNSCSE03",5);
INSERT INTO employee VALUES("RNSCSE03", "EDWARD","SCOTT","MYSORE","M",50000,"RNSCSE04",5);
INSERT INTO employee VALUES("RNSCSE04", "PAVAN","HEDGE","MANGALORE","M",65000,"RNSCSE05",5);
INSERT INTO employee VALUES("RNSCSE05", "GIRISH","MALYA","MYSORE","M",45000,"RNSCSE06",5);
INSERT INTO employee VALUES("RNSCSE06", "NEHA","SN","BANGALORE","F",80000,NULL,5);
INSERT INTO employee VALUES("RNSACC01", "AHANA","K","MANGALORE","F",35000,"RNSCSE02",1);
INSERT INTO employee VALUES("RNSACC02", "SANTOSH","KUMAR","MANGALORE","M",30000,NULL,1);
INSERT INTO employee VALUES("RNSISE01", "VEENA","M","MYSORE","M",60000,NULL,4);
INSERT INTO employee VALUES("RNSIT01", "NAGESH","HR","BANGALORE","M",50000,NULL,2);
SELECT*FROM EMPLOYEE;

create table department(
dno int references employee(dno),
dname varchar(25),
mgrstartd date,
mgrssn varchar(20)
);

INSERT INTO department VALUES(1,"Accounts",str_to_date('01-Jan-01','%d-%b-%Y'),"RNSACC02");
INSERT INTO department VALUES(2,"IT",str_to_date('01-Aug-16','%d-%b-%Y'),"RNSIT01");
INSERT INTO department VALUES(3,"ECE",str_to_date('01-Jun-08','%d-%b-%Y'),"RNSECE01");
INSERT INTO department VALUES(4,"ISE",str_to_date('01-Aug-15','%d-%b-%Y'),"RNSISE01");
INSERT INTO department VALUES(5,"CSE",str_to_date('01-Jun-02','%d-%b-%Y'),"RNSCSE05");
SELECT*FROM DEPARTMENT;

CREATE TABLE dlocation(
dloc varchar(20),
dno int references employee(dno));

insert into dlocation values("BANGALORE",1);
insert into dlocation values("BANGALORE",2);
insert into dlocation values("BANGALORE",3);
insert into dlocation values("MANGALORE",4);
insert into dlocation values("MANGALORE",5);

SELECT*FROM DLOCATION;
CREATE TABLE project(
pno int primary key,
pname varchar(25),
plocation varchar(25),
dno int references employee(dno));

insert into project values(100,"IOT","BANGALORE",5);
insert into project values(101,"CLOUD","BANGALORE",5);
insert into project values(102,"BIGDATA","BANGALORE",5);
insert into project values(103,"SENSORS","BANGALORE",3);
insert into project values(104,"BANK MANAGEMENT","BANGALORE",1);
insert into project values(105,"SALARY MANAGEMENT","BANGALORE",1);
insert into project values(106,"OPENSTACK","BANGALORE",4);
insert into project values(107,"SMART CITY","BANGALORE",2);
SELECT*FROM PROJECT;

create table works_on(
hours int,
ssn varchar(20) references employee(ssn),
pno int references project(pno)
);
INSERT INTO works_on values(4,"RNSCSE01",100);
INSERT INTO works_on values(6,"RNSCSE01",101);
INSERT INTO works_on values(8,"RNSCSE01",102);
INSERT INTO works_on values(10,"RNSCSE02",100);
INSERT INTO works_on values(3,"RNSCSE04",100);
INSERT INTO works_on values(4,"RNSCSE05",101);
INSERT INTO works_on values(5,"RNSCSE06",102);
INSERT INTO works_on values(6,"RNSCSE03",102);
INSERT INTO works_on values(7,"RNSECE01",103);
INSERT INTO works_on values(5,"RNSACC01",104);
INSERT INTO works_on values(6,"RNSACC02",105);
INSERT INTO works_on values(4,"RNSISE01",106);
INSERT INTO works_on values(10,"RNSIT01",107);

SELECT*FROM WORKS_ON;



#1
select pno from works_on join
employee on works_on.ssn=employee.ssn
where lname="scott";

#2
select salary+salary*0.1 as incsalary from employee e, works_on w,
project p where e.ssn=w.ssn and 
w.pno=p.pno and
p.pname="IOT";

#3
select sum(a.salary),max(a.salary),min(a.salary),
avg(a.salary) from employee a , department b where 
a.dno=b.dno and b.dname="accounts";

#4
select a.fname,a.lname from employee a 
where not exists(
select pno from project where dno=5
not in (select pno from works_on where a.ssn=ssn));

#5
select e.dno,count(e.ssn) from employee e where
e.salary>60000 and e.dno in(
select e1.dno from employee e1 group by e1.dno having
count(e1.dno)>5) group by e.dno;