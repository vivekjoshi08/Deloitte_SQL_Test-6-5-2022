use assessmentcompany_database;

/* creating the tables */
CREATE TABLE employee (
ssn VARCHAR(20) PRIMARY KEY,
f_name VARCHAR(20) NOT NULL,
l_name VARCHAR(20) NOT NULL,
address VARCHAR(20) NOT NULL,
sex VARCHAR(1) NOT NULL,
salary INT NOT NULL,
super_ssn VARCHAR(20),
d_no INT NOT NULL
);

CREATE TABLE departments (
d_no INT PRIMARY KEY,
d_name VARCHAR(20) NOT NULL,
mgr_startdate DATE, 
mgr_ssn VARCHAR(20) NOT NULL
);

CREATE TABLE dlocations (
d_loc VARCHAR(30) NOT NULL,
d_no INT REFERENCES departments(d_no)
);

CREATE TABLE projects (
p_no INT PRIMARY KEY,
p_name VARCHAR(30) NOT NULL,
p_location VARCHAR(20) NOT NULL,
d_no INT REFERENCES departments(d_no)
);

CREATE TABLE works_on (
hours INT NOT NULL,
ssn VARCHAR(20) NOT NULL,
p_no INT REFERENCES project(p_no)
);

/* inserting values in the table */
INSERT INTO employee(ssn, f_name, l_name, address, sex, salary, super_ssn, dno)
VALUES('RNSECE01', 'John', 'Scott', 'Bangalore', 'M', 450000, NULL, 3);
INSERT INTO employee(ssn, f_name, l_name, address, sex, salary, super_ssn, dno)
VALUES('RNSCSE01', 'James', 'Smith', 'Bangalore', 'M', 500000, 'RNSCSE02', 5);
INSERT INTO employee(ssn, f_name, l_name, address, sex, salary, super_ssn, dno)
VALUES('RNSCSE02', 'Hearn', 'Baker', 'Bangalore', 'M', 700000, 'RNSCSE03', 5);
INSERT INTO employee(ssn, f_name, l_name, address, sex, salary, super_ssn, dno)
VALUES('RNSCSE03', 'Edward', 'Scott', 'Mysore', 'M', 500000, 'RNSCSE04', 5);
INSERT INTO employee(ssn, f_name, l_name, address, sex, salary, super_ssn, dno)
VALUES('RNSCSE04', 'Pavan', 'Hegde', 'Mangalore', 'M', 650000, 'RNSCSE05', 5);
INSERT INTO employee(ssn, f_name, l_name, address, sex, salary, super_ssn, dno)
VALUES('RNSCSE05', 'Girish', 'Malya', 'Mysore', 'M', 450000, 'RNSCSE06', 5);
INSERT INTO employee(ssn, f_name, l_name, address, sex, salary, super_ssn, dno)
VALUES('RNSCSE06', 'Neha', 'Sn', 'Bangalore', 'F', 800000, NULL, 5);
INSERT INTO employee(ssn, f_name, l_name, address, sex, salary, super_ssn, dno)
VALUES('RNSACC01', 'Ahana', 'K', 'Mangalore', 'F', 350000, 'RNSACC02', 1);
INSERT INTO employee(ssn, f_name, l_name, address, sex, salary, super_ssn, dno)
VALUES('RNSACC02', 'Santosh', 'Kumar', 'Mangalore', 'M', 300000, NULL, 1);
INSERT INTO employee(ssn, f_name, l_name, address, sex, salary, super_ssn, dno)
VALUES('RNSISE01', 'Veena', 'M', 'Mysore', 'M', 600000, NULL, 4);
INSERT INTO employee(ssn, f_name, l_name, address, sex, salary, super_ssn, dno)
VALUES('RNSIT01', 'Nagesh', 'Hr', 'Bangalore', 'M', 500000, NULL, 2);

/* inserting into department table */
INSERT INTO departments(d_no, d_name, mgr_startdate, mgr_ssn)
VALUES(1, 'Accounts', '2001-01-01', 'RNSACC02');
INSERT INTO departments(d_no, d_name, mgr_startdate, mgr_ssn)
VALUES(2, 'IT', '2016-08;01', 'RNSIT01');
INSERT INTO departments(d_no, d_name, mgr_startdate, mgr_ssn)
VALUES(3, 'ECE', '2008-06-01', 'RNSECE01');
INSERT INTO departments(d_no, d_name, mgr_startdate, mgr_ssn)
VALUES(4, 'ISE', '2015-08-01', 'RNSISE01');
INSERT INTO departments(d_no, d_name, mgr_startdate, mgr_ssn)
VALUES(5, 'CSE', '2002-06-01', 'RNSCSE05');

/* inserting into dloactions table */
INSERT INTO dlocations(d_loc, d_no)
VALUES('Bangalore', 1);
INSERT INTO dlocations(d_loc, d_no)
VALUES('Bangalore', 2);
INSERT INTO dlocations(d_loc, d_no)
VALUES('Bangalore', 3);
INSERT INTO dlocations(d_loc, d_no)
VALUES('Mangalore', 4);
INSERT INTO dlocations(d_loc, d_no)
VALUES('Mangalore', 5);

/* inserting into projects table */
INSERT INTO projects(p_no, p_name, p_location, d_no)
VALUES(100, 'IOT', 'Bangalore', 5);
INSERT INTO projects(p_no, p_name, p_location, d_no)
VALUES(101, 'Cloud', 'Bangalore', 5);
INSERT INTO projects(p_no, p_name, p_location, d_no)
VALUES(102, 'BigData', 'Bangalore', 5);
INSERT INTO projects(p_no, p_name, p_location, d_no)
VALUES(103, 'Sensors', 'Bangalore', 3);
INSERT INTO projects(p_no, p_name, p_location, d_no)
VALUES(104, 'Bank Management', 'Bangalore', 1);
INSERT INTO projects(p_no, p_name, p_location, d_no)
VALUES(105, 'Salary Management', 'Bangalore', 1);
INSERT INTO projects(p_no, p_name, p_location, d_no)
VALUES(106, 'Open Stack', 'Bangalore', 4);
INSERT INTO projects(p_no, p_name, p_location, d_no)
VALUES(107, 'Smart City', 'Bangalore', 2);

/* inserting into works_on table */
INSERT INTO works_on(hours, ssn, p_no)
VALUES(4, 'RNSCSE01', 100);
INSERT INTO works_on(hours, ssn, p_no)
VALUES(6, 'RNSCSE01', 101);
INSERT INTO works_on(hours, ssn, p_no)
VALUES(8, 'RNSCSE01', 102);
INSERT INTO works_on(hours, ssn, p_no)
VALUES(10, 'RNSCSE02', 100);
INSERT INTO works_on(hours, ssn, p_no)
VALUES(3, 'RNSCSE04', 100);
INSERT INTO works_on(hours, ssn, p_no)
VALUES(4, 'RNSCSE05', 101);
INSERT INTO works_on(hours, ssn, p_no)
VALUES(5, 'RNSCSE06', 102);
INSERT INTO works_on(hours, ssn, p_no)
VALUES(6, 'RNSCSE03', 102);
INSERT INTO works_on(hours, ssn, p_no)
VALUES(7, 'RNSECE01', 103);
INSERT INTO works_on(hours, ssn, p_no)
VALUES(5, 'RNSACC01', 104);
INSERT INTO works_on(hours, ssn, p_no)
VALUES(6, 'RNSACC02', 105);
INSERT INTO works_on(hours, ssn, p_no)
VALUES(4, 'RNSISE01', 106);
INSERT INTO works_on(hours, ssn, p_no)
VALUES(10, 'RNSIT01', 107);

/* QUERY1 */
SELECT DISTINCT p_no
FROM projects p, departments d, employee e
WHERE e.dno = d.d_no
AND d.d_no = p.d_no
AND (e.l_name = 'Scott' OR d.mgr_ssn IN (SELECT ssn
FROM employee
WHERE l_name = 'Scott'));

/* query2 */
SELECT e.ssn, e.f_name, sum(e.salary+(e.salary*0.1)) AS hike_10_per
FROM employee e, departments d
WHERE e.dno = d.d_no 
AND d.d_name = 'IOT'
GROUP BY ssn, f_name;

/* query3 */
SELECT sum(salary) as sum_salary,
avg(salary) as avg_salary,
min(salary) as min_salary,
max(salary) as max_salary
from employee e, departments d
where e.dno = d.d_no and d.d_name='Accounts';

/*  query4 */
select e.f_name, e.l_name 
from employee e
where not exists (select p_no 
from projects
where d_no = '5' not in (select p_no 
from works_on
where e.ssn=ssn));

/* query5 */
SELECT d.d_no, count(*) as no_of_emp from employee e, departments d where
e.dno=d.d_no and e.salary>600000 and d.d_no in (select e1.dno from employee e1 group by e1.dno having count(*)>5)
group by d.d_no;