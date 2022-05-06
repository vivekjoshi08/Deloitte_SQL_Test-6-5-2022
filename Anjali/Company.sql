use companydatabase;
create table employee(
SSN varchar(50) primary key,
fname varchar(30) not null, lname varchar(30) not null,
address varchar(50) not null, sex varchar(1)not null,
salary int not null, superssn varchar(50));
create table department (
dno int primary key, dname varchar(50), mgrstartd date, mgrssn varchar(50));
alter table employee add dno int references department(dno);
create table dlocation(
dno int references department(dno),
dloc varchar(50));
create table project(
pno int primary key,
pname varchar(50),
plocation varchar(50), dno int references department(dno));
create table works_on(
ssn varchar(50) references employee(ssn),
hours int,
pno int references project(pno) );
#insertion
insert into employee(ssn,fname,lname,address,sex,salary,superssn,dno)values
('RNSECE01','John','Scott','Bangalore','M',450000,null,3),
('RNSCSE01','James','Smith','Bangalore','M',500000,'RNSCSE02',5),
('RNSCSE02','Hearn','Baker','Bangalore','M',700000,'RNSCSE03',5),
('RNSCSE03','Edward','Scott','Mysore','M',500000,'RNSCSE04',5),
('RNSCSE04','Pavan','Hegde','Mangalore','M',650000,'RNSCSE05',5),
('RNSCSE05','Girish','Malya','Mysore','M',450000,'RNSCSE06',5),
('RNSCSE06','Neha','SN','Bangalore','F',800000,null,5),
('RNSACC01','Ahana','K','Mangalore','F',350000,'RNSACC02',1),
('RNSACC02','Santosh','Kumar','Mangalore','M',300000,null,1),
('RNSISE01','Veena','M','Mysore','M',600000,null,4),
('RNSIT01','Nagesh','HR','Bangalore','M',500000,null,2);
INSERT INTO department(dno,dname,mgrstartd,mgrssn) values
(1,'Accounts','2001-01-01','RNSACC02'),
(2,'IT','2016-08-01','RNSIT01'),
(3,'ECE','2008-06-01','RNSECE01'),
(4,'ISE','2015-08-01','RNSISE01'),
(5,'CSE','2002-06-01','RNSCSE05');
insert into dlocation(dloc,dno)values
('Bangalore',1),
('Bangalore',2),
('Bangalore',3),
('Mangalore',4),
('Mangalore',5);
insert into project(pno,pname,plocation,dno) values
(100,'IOT','Bangalore',5),
(101,'Cloud','Bangalore',5),
(102,'BigData','Bangalore',5),
(103,'Sensors','Bangalore',3),
(104,'Bank Management','Bangalore',1),
(105,'Salary Management','Bangalore',1),
(106,'OpenStack','Bangalore',4),
(107,'Smart City','Bangalore',2);
insert into works_on(hours,ssn,pno)values
(4,'RNSCSE01',100),
(6,'RNSCSE01',100),
(8,'RNSCSE01',101),
(10,'RNSCSE01',102),
(3,'RNSCSE02',100),
(4,'RNSCSE04',100),
(5,'RNSCSE05',101),
(6,'RNSCSE06',102),
(7,'RNSCSE03',103),
(5,'RNSACC01',104),
(6,'RNSACC02',105),
(4,'RNSISE01',106),
(10,'RNSIT01',107);
#QUERIES
#1
select distinct pno from project p,department d,employee e where e.dno=d.dno AND d.dno=p.dno and (e.lname='Scott' or d.mgrssn in
(select ssn from employee where lname='Scott'));
#2
select e.ssn,e.fname,sum(e.salary+(e.salary*0.1)) as hike_10_per from employee e, department d
where e.dno=d.dno and d.dname='IOT' group by ssn,fname;
#3
select sum(salary) as sum_salary,
avg(salary) as avg_salary,
min(salary)as min_salary,
max(salary) as max_salary from employee e, department d
where e.dno=d.dno and d.dname='Accounts';
#4
select e.fname,e.lname from employee e where not exists (select pno from project
where dno='5' not in  (select pno from works_on where e.ssn=ssn));
#5
select d.dno,count(*) as no_of_emp from employee e, department d where 
e.dno=d.dno and e.salary>600000 and d.dno in(select e1.dno from employee e1 group by e1.dno having count(*)>5)
group by d.dno; 