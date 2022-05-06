use employee99;

create table employee (
ssn varchar(50) primary key,
fname varchar(50),
lname varchar(50),
address varchar(50),
sex varchar(1),
salary  bigint,
superssn varchar(50),
dno int
);

create table department (
dno int primary key,
dname varchar(50),
mgrssn varchar(50),
mgrstartdate date
);

create table dlocation (
dno int,
dloc varchar(50),
foreign key (dno) references department(dno)
);

create table project (
pno int primary key,
pname varchar(50),
plocation varchar(50),
dno int,
foreign key ( dno) references department(dno)
);

create table works_on (
hours int,
ssn varchar(50),
pno int,
foreign key (pno) references project(pno),
foreign key (ssn) references employee(ssn)
);

#inserting values in schema

insert into employee ( ssn, fname, lname, address, sex, salary, superssn, dno)
values
('RNSECE01', 'JOHN', 'SCOTT', 'BANGLORE', 'M', 450000, NULL, 3);
SELECT * FROM EMPLOYEE;


insert into employee ( ssn, fname, lname, address, sex, salary, superssn, dno)
values
('RNSCSE01', 'JAMES', 'SMITH', 'BANGLORE', 'M', 500000, 'RNSCSE02', 5),
('RNSCSE02', 'HEARN', 'BAKER', 'BANGLORE', 'M', 700000, 'RNSCSE03', 5),
('RNSCSE03', 'EDWARD', 'SCOTT', 'MYSORE', 'M', 500000, 'RNSCSE04', 5),
('RNSCSE04', 'PAVAN', 'HEDGE', 'MANGALORE', 'M', 650000, 'RNSCSE05', 5),
('RNSCSE05', 'GIRISH', 'MALYA', 'MYSORE', 'M', 450000,  'RNSCSE06', 5),
('RNSCSE06', 'NEHA', 'SN', 'BANGLORE', 'F', 800000, NULL, 5),
('RNSACC01', 'AHANA', 'K', 'MANGALORE', 'F', 350000, 'RNSACC02', 1),
('RNSACC02', 'SANTOSH', 'KUMAR', 'MANGLORE', 'M', 300000, NULL, 1),
('RNSISE01', 'VEENA', 'M', 'MYSORE', 'M', 600000, NULL, 4),
('RNSIT01', 'NAGESH', 'HR', 'BANGLORE', 'M', 500000, NULL, 2);


insert into department ( dno, dname, mgrssn, mgrstartdate)
values
(1, 'ACCOUNTS', 'RNSACC02', '01-01-01'),
(2, 'IT', 'RNSIT01',  '01-08-16'),
(3, 'ECS', 'RNSECE01',  '01-06-08'),
(4, 'ISE',  'RNSISE01', '01-08-15'),
(5, 'CSE',  'RNSCSE05', '01-06-06');

SET FOREIGN_KEY_CHECKS = 0;
insert into dlocation( dno, dloc)
values 
( 1, 'BANGLORE'),
( 2, 'BANGLORE'),
( 3, 'BANGLORE'),
( 4, 'MANGLORE'),
( 5, 'MANGLORE');

insert into project ( pno, pname, plocation, dno)
values
(100, 'IOT', 'BANGLORE', 5),
(101, 'CLOUD', 'BANGLORE', 5),
(102, 'BIGDATA', 'BANGLORE', 5),
(103, 'SENSORS', 'BANGLORE', 3),
(104, 'BANK MANAGEMENT', 'BANGLORE', 1),
(105, 'SALARY MANAGEMENT', 'BANGLORE', 1),
(106, 'OPENSTACK', 'BANGLORE', 4),
(107, 'SMARTCITY', 'BANGLORE', 2);

insert into works_on( hours, ssn, pno)
values
(4, 'RNSCSE01', 100),
(6, 'RNSCSE01', 101),
(8, 'RNSCSE01', 102),
(10, 'RNSCSE02', 100),
(3, 'RNSCSE04', 100),
(4, 'RNSCSE05', 101),
(5, 'RNSCSE06', 102),
(6, 'RNSCSE03', 102),
(7, 'RNSECE01', 103),
(5, 'RNSACC01', 104),
(6, 'RNSACC02', 105),
(4, 'RNSISE01', 106),
(10, 'RNSIT01', 107);


#QUERRIES NOW

#1
select pno from project 
inner join employee  on project.dno = employee.dno 
where pname = 'IOT';

#2
select 1.1*salary as r_salary from employee
inner join project on project.dno = employee.dno
where pname = 'IOT';

#3
select sum(salary), avg(salary), max(salary), min(salary) from employee
left join department on department.dno = employee.dno
where dname = 'ACCOUNTS';

#4
select fname from employee
inner join works_on on works_on.ssn = employee.ssn
not in 
( select fname from employee 
where not exists ( 
select pno from project 
where dno = 5 
)
);

#5
select department.dno, count(*) from department
inner join employee on department.dno= employee.dno
where salary > 600000
and department.dno in (
select employee.dno from employee
group by employee.dno
having count(*)> 5);