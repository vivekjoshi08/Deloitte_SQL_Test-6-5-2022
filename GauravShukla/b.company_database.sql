use employee_practical;

create table employee(
ssn varchar(10) not null primary key,
f_name varchar(50) not null,
l_name varchar(50) not null,
address varchar(50) not null,
sex varchar(1) not null,
salary int not null,
superssn varchar(50),
dno int not null
);

create table department(
dno int references employee(dno),
dname varchar(50) not null,
mgr_ssn varchar(50) not null,
mgr_startdate date not null
);

create table dlocation(
dloc varchar(50) not null,
dno int references employee(dno)
);

create table project(
pno int primary key,
pname varchar(50) not null,
plocation varchar(50) not null,
dno int references employee(dno)
);

create table works_on(
hours int not null,
ssn varchar(10) references employee(ssn),
pno int references project(pno)
);


insert into employee values ('RNSECE01','JOHN','SCOTT','BANGALORE','M',450000, NULL,3),
                            ('RNSCSE01','JAMES','SMITH','BANGALORE','M',500000, 'RNSCSE02',5),
                            ('RNSCSE02','HEARN','BAKER','BANGALORE','M',700000, 'RNSCSE03',5),
                            ('RNSCSE03','EDWARD','SCOTT','MYSORE','M',500000, 'RNSCSE04',5),
                            ('RNSCSE04','PAVAN','HEGDE','MANGALORE','M',650000, 'RNSCSE05',5);
 insert into employee values ('RNSCSE05','GIRISH','MALYA','MYSORE','M',450000, 'RNSCSE06',5),
							 ('RNSCSE06','NEHA','SN','BANGALORE','F',800000, NULL,5),
                             ('RNSACC01','AHANA','K','MANGALORE','F',350000, 'RNSACC02',1),
                             ('RNSACC02','SANTOSH','KUMAR','MANGALORE','M',300000, NULL,1),
                             ('RNSISE01','VEENA','M','MYSORE','M',600000, NULL,4),
                             ('RNSIT01','NAGESH','HR','BANGALORE','M',500000, NULL,2);
                             
                            
SELECT * FROM EMPLOYEE;
insert into department values (1,'ACCOUNTS','RNSACC02','01-01-01');
insert into department values (2,'IT','RNSIT01','01-08-16'),
							  (3,'ECE','RNSECE01','01-06-08'),
                              (4,'ISE','RNSISE01','01-08-15'),
                              (5,'CSE','RNSCSE05','01-06-02');

insert into dlocation values ('BANGALORE',1),
							 ('BANGALORE',2),
                             ('BANGALORE',3),
                             ('MANGALORE',4),
                             ('MANGALORE',5);
                             
insert into project values (100,'IOT','BANGALORE',5),
                           (101,'CLOUD','BANGALORE',5),
                           (102,'BIGDATA','BANGALORE',5),
                           (103,'SENSORS','BANGALORE',3),
                           (104,'BANK MANAGEMENT','BANGALORE',1),
                           (105,'SALARY MANAGEMENT','BANGALORE',1),
                           (106,'OPEN STACK','BANGALORE',4),
                           (107,'SMART CITY','BANGALORE',2);
                           
insert into works_on values (4,'RNSCSE01',100),
                            (6,'RNSCSE01',101),
                            (8,'RNSCSE01',102),
                            (10,'RNSCSE02',100),
                            (3,'RNSCSE04',100),
                            (4,'RNSCSE05',101),
                            (5,'RNSCSE06',102),
                            (6,'RNSCSE03',102),
                            (7,'RNSECE01',103),
                            (5,'RNACCE01',104),
                            (6,'RNSACC02',105),
                            (4,'RNSISE01',106),
                            (10,'RNSIT01',107);
                            

#1
Select pno as project_number from employee e join project p on e.dno=p.dno where l_name='SCOTT';

#2
select f_name,l_name, salary*1.10 as salary from employee e join project p on e.dno=p.dno where pname='IOT';

#3
select sum(salary), max(salary),min(salary),avg(salary) from employee e join department d  on e.dno=d.dno
group by dname having dname='ACCOUNTS';

#4a
select f_name from employee e join works_on w on e.ssn=w.ssn not in
(select f_name from employee where not exists (select pno from project where dno=5));

#4b
select d.dno, count(*) as employee_count from department d inner join employee e on d.dno=e.dno
where salary>600000 and d.dno in (select dno from employee group by dno having count(*)>5);





							  
					
                            
                            
