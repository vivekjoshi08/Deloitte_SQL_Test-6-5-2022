use company_database;
create table employee1 (
ssn varchar(20),
fname varchar (50),
lname varchar (50),
address varchar (50),
s char(1),
salary int,
super_ssn varchar(20),
dno int);

insert into employee1
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

create table departments (

dno int,
dname varchar(20),
mgr_startdate date,
mgr_ssn varchar(20));

insert into departments
values
('1','ACCOUNTS',str_to_date('01-JAN-01','%d-%b-%Y'),'RNSACC02'),
('2','ACCOUNTS',str_to_date('01-AUG-16','%d-%b-%Y'),'RNSIT01'),
('3','ACCOUNTS',str_to_date('01-JUN-08','%d-%b-%Y'),'RNSECE01'),
('4','ACCOUNTS',str_to_date('01-AUG-15','%d-%b-%Y'),'RNSISE01'),
('5','ACCOUNTS',str_to_date('01-JUN-02','%d-%b-%Y'),'RNSCSE05');

create table dlocation1 (
dloc varchar(20),
dno int);

insert into dlocation1
values
('Bangalore','1'),
('Bangalore','2'),
('Bangalore','3'),
('Mangalore','4'),
('Mangalore','5');

create table PROJECT1 (
pno int,
pname varchar(20),
ploc varchar(20),
dno int);

insert into PROJECT1
values
('100', 'IOT', 'BANGALORE', '5'),
('101', 'CLOUD', 'BANGALORE', '5'),
('102', 'BIG DATA', 'BANGALORE', '5'),
('103', 'SENSORS', 'BANGALORE', '3'),
('104', 'BANK MANAGEMENT', 'BANGALORE', '1'),
('105', 'SALARY MANAGEMENT', 'BANGALORE', '1'),
('106', 'OPEN STACK', 'BANGALORE', '4'),
('107', 'SMART CITY', 'BANGALORE', '2');

create table works_on1(
hours int,
ssn varchar(20),
pno int);

insert into works_on1
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

/*1...*/
select distinct p.pno
from project1 p,departments d,employee1 e
where p.dno=d.dno and
d.mgr_ssn=e.ssn and
e.lname='SCOTT'
UNION 
select  distinct w.pno
from works_on1 w, employee1 e1
where e1.ssn=w.ssn and
e1.lname ='SCOTT';


/*2...*/
select e.fname,e.lname,1.1*e.salary as incr_sal
from employee1 e, works_on1 w project p
where e.ssn=w.ssn and
w.pno=p.pno and
p.name ='IOT';
/*3..*/
select sum(e.salary), max(e.salary),min(e.salary), avg(e.salary)
from employee1 e,departments d
where e.dno=d.dno and 
d.name ='ACCOUNTS';
/*4*/
select e.name,e.lname 
from employee1 e 
where not exists (
select pno from project where dno=5
not in 
(select pno from works_on1 where e.ssn=ssn));
/*5*/
select e.dno,count(e.ssn) as "Number of employees"
from employee1 e
where e.salary > 60000 and
e.dno in (select e1.dno
from employee1 e1
group by e1.dno
having count(e1.dno) >5 )
group by e.dno;





