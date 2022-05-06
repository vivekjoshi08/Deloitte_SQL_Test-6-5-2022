use test_movie_database;

create table actor (
act_id int primary key,
act_name varchar (50),
act_gender char(1)
);

insert into actor 
values
('301', 'ANUSHKA', 'F'),
('302', 'PRABHAS', 'M'),
('303', 'PUNITH', 'M'),
('304', 'GEREMY', 'M');

create table director (
dir_id int primary key,
dir_name varchar(50),
dir_phone varchar(10));

insert into director
values
('60', 'RAJAMOULI', '8751611001'),
('61', 'HITCHCOCK', '7766138911'),
('62', 'FARAN', '9986776531'),
('63', 'STEVEN SPIELBERG', '8989776530');

create table movies (
mov_id int primary key,
mov_title varchar(50) not null,
mov_year int,
mov_lang varchar(50),
dir_id int);

insert into movies
values
('1001', 'BAHUBALI-2', '2017', 'TELAGU', '60'),
('1002', 'BAHUBALI-1', '2015', 'TELAGU', '60'),
('1003', 'AKASH', '2008', 'KANNADA', '61'),
('1004', 'WAR HORSE', '2011', 'ENGLISH', '63');

create table movie_cast(
act_id int not null,
mov_id int not null,
role1 varchar(20));

insert into movie_cast
values
('301','1002','HEROINE'),
('301','1001','HEROINE'),
('303','1003','HERO'),
('303','1002','GUEST'),
('304','1004','HERO');

create table rating(
mov_id int not null,
rev_stars int);

insert into rating
values
('1001','4'),
('1002','2'),
('1003','5'),
('1004','4');

#queries

/*1.....*/
select mov_title
from movies inner join director
on movies.dir_id=director.dir_id
where dir_name='HITCHCOCK';

/*2.....*/
select mov_title
from movies where mov_id in (select mov_id from movie_cast where act_id in 
(select act_id from actor where act_id in 
(select act_id from movie_cast group by act_id having count(*)>=2)));

/*3.....*/
select act_name, mov_title, mov_year
from actor 
inner join movie_cast
 on actor.act_id=movie_cast.act_id
inner join movies
 on movies.mov_id=movie_cast.mov_id
 where mov_year <2000 or mov_year > 2015;
 
 /*4.....*/
 select mov_title,max(rev_stars)
 from movies inner join rating on movies.mov_id=rating.mov_id
 group by mov_title
 having max(rev_stars) >= 1
 order by mov_title asc;
 
 /*5.....*/
 update rating set rev_stars=5
 where mov_id in (select mov_id from movies wherE dir_id in
  (select dir_id from director where dir_name ='STEVEN SPIELBERG'));