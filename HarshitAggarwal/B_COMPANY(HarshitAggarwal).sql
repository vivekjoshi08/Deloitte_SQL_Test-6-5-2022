use companydatabase;
create table DEPARTMENT(
	dno int primary key,
    dname varchar(25) not null,
    mgrssn varchar(25) not null,
    mgrstartdate date
);
create table EMPLOYEE(
	ssn varchar(25) primary key,
    fname varchar(25) not null,
    lname varchar(25) not null,
    address varchar(25) not null,
    sex varchar(1) not null,
    salary int not null,
    superssn varchar(25),
    dno int,
    foreign key(dno) references DEPARTMENT(dno)
);
create table DLOCATION(
	dloc varchar(25) NOT NULL,
    dno int,
    foreign key(dno) references DEPARTMENT(dno)
);
create table PROJECT(
	pno int primary key,
    pname varchar(25) not null,
    plocation varchar(25) not null,
    dno int,
    foreign key(dno) references DEPARTMENT(dno)
);
create table works_on (
	hours int not null,
    ssn varchar(25),
    pno int,
    foreign key(ssn) references EMPLOYEE(ssn),
    foreign key(pno) references PROJECT(pno)
);
SET FOREIGN_KEY_CHECKS=0;
insert into EMPLOYEE(ssn,fname,lname,address,sex,salary,superssn,dno) values ('RNSECE01','JOHN','SCOTT','BANGALORE','M',450000,NULL,3),('RNSCSE01','JAMES','SMITH','BANGALORE','M',500000,'RNSCSE02',5),('RNSCSE02','HEARN','BAKER','BANGALORE','M',700000,'RNSCSE03',5),('RNSCSE03','EDWARD','SCOTT','MYSORE','M',500000,'RNSCSE04',5),('RNSCSE04','PAVAN','HEDGE','MANGALORE','M',650000,'RNSCSE05',5),('RNSCSE05','GIRISH','MALYA','MYSORE','M',450000,'RNSCSE06',5),('RNSCSE06','NEHA','SN','BANGALORE','F',800000,NULL,5),('RNSACC01','AHANA','K','MANGALORE','F',350000,'RNSACC02',1),('RNSACC02','SANTOSH','KUMAR','MANGALORE','M',300000,NULL,1),('RNSISE01','VEENA','M','MYSORE','M',600000,NULL,4),('RNSIT01','NAGESH','HR','BANGALORE','M',500000,NULL,2);
INSERT INTO DEPARTMENT(dno,dname,mgrstartdate,mgrssn) values (1,'ACCOUNTS','01-01-01','RNSACC02'),(2,'IT','01-08-16','RNSIT01'),(3,'ECE','01-06-08','RNSECE01'),(4,'ISE','01-08-15','RNSISE01'),(5,'CSE','01-06-02','RNSCSE05');
INSERT INTO DLOCATION(dloc,dno) values ('BANGALORE',1),('BANGALORE',2),('BANGALORE',3),('MANGALORE',4),('MANGALORE',5);
INSERT INTO PROJECT(pno,pname,plocation,dno) values (100,'IOT','BANGALORE',5),(101,'CLOUD','BANGALORE',5),(102,'BIGDATA','BANGALORE',5),(103,'SENSORS','BANGALORE',3),(104,'BANK MANAGEMENT','BANGALORE',1),(105,'SALARY MANAGEMENT','BANGALORE',1),(106,'OPENSTACK','BANGALORE',4),(107,'SMART CITY','BANGALORE',2);
INSERT INTO works_on(hours,ssn,pno) values (4,'RNSCSE01',100),(6,'RNSCSE01',101),(8,'RNSCSE01',102),(10,'RNSCSE02',100),(3,'RNSCSE04',100),(4,'RNSCSE05',101),(5,'RNSCSE06',102),(6,'RNSCSE03',102),(7,'RNSECE01',103),(5,'RNSACC01',104),(6,'RNSACC02',105),(4,'RNSISE01',106),(10,'RNSIT01',107);

#QUERY1
SELECT pno from PROJECT p inner join EMPLOYEE e on p.dno=e.dno where lname='SCOTT';

#QUERY2
select 1.1*salary as resultsalary from EMPLOYEE e inner join PROJECT p on e.dno=p.dno where pname = 'IOT';

#QUERY3
select sum(salary),avg(salary),max(salary),min(salary) from EMPLOYEE E LEFT JOIN DEPARTMENT D ON E.dno = D.dno where dname='ACCOUNTS';

#QUERY4
select fname from EMPLOYEE e
inner join works_on w on e.ssn=w.ssn
not in (select fname from EMPLOYEE where not exists (select pno from PROJECT where dno=5));

#QUERY5
SELECT d.dno,count(*) from DEPARTMENT d
inner join EMPLOYEE e on d.dno=e.dno
where salary>600000 and d.dno in (select dno from EMPLOYEE  group by dno having count(*)>5);
