use test_movie_schema;

create table actor (act_id int primary key, act_name varchar(50) not null,
act_gender char(1) not null);

insert into actor (act_id, act_name, act_gender) 
values (301, 'ANUSHKA', 'F'),
	   (302, 'PRABHAS', 'M'),
       (303, 'PUNITH', 'M'),
       (304, 'JERMY', 'M');
       
       
create table director(dir_id int primary key,dir_name varchar(50) not null, 
dir_phone char(10) not null);

insert into director(dir_id, dir_name, dir_phone)
values(60, 'RAJAMOULI', '8751611001'),
	  (61, 'HITCHCOCK', '7766138911'),
	  (62, 'FARAN', '9986776531'),
      (63, 'STEVEN SPIELBERG', '8989776530');
      
create table movies(mov_id int primary key, mov_title varchar(50) not null, 
mov_year int not null, mov_lang varchar(20) not null,dir_id int, 
foreign key(dir_id) references director(dir_id));

insert into movies(mov_id, mov_title, mov_year, mov_lang, dir_id)
values (1001, 'BAHUBALI-2', 2017, 'TELAGU', 60),
	   (1002, 'BAHUBALI-1', 2015, 'TELAGU', 60),
       (1003, 'AKASH', 2008, 'KANNADA', 61),
       (1004, 'WAR HORSE', 2011, 'ENGLISH', 63);
       
create table movie_cast(act_id int, mov_id int,
foreign key (act_id) references actor(act_id),
foreign key (mov_id) references movies(mov_id), 
role1 varchar(50) not null);

insert into movie_cast(act_id, mov_id, role1)
values(301, 1002, 'HEROINE'),
      (301, 1001, 'HEROINE'),
      (303, 1003, 'HERO'),
      (303, 1002, 'GUEST'),
      (304, 1004, 'HERO');
      
create table rating(mov_id int,
foreign key(mov_id) references movies(mov_id),
rev_stars char(1) not null);

insert into rating(mov_id, rev_stars)
values(1001, '4'),
      (1002, '2'),
      (1003, '5'),
      (1004, '4');

	
/*QUERIES*/

/*Q1*/
SELECT m.mov_title 
FROM movies m
JOIN director d
ON m.dir_id=d.dir_id
WHERE d.dir_name='HITCHCOCK';

/*Q2*/ 
SELECT m.mov_title 
FROM movies m, movie_cast mc
WHERE m.mov_id=mc.mov_id
AND act_id in 
(SELECT act_id FROM movie_cast 
GROUP BY  act_id HAVING COUNT(act_id)>1)
GROUP BY mov_title HAVING COUNT(mov_title)>1;

/*Q3*/
SELECT a.act_name 
FROM actor a
JOIN movie_cast mc
ON a.act_id=mc.act_id
JOIN movies m
ON m.mov_id=mc.mov_id
WHERE m.mov_year < 2000 
AND m.mov_year > 2015;

/*Q4*/
SELECT m.mov_title, MAX(rev_stars)
FROM movies m
INNER JOIN rating r
ON m.mov_id=r.mov_id
WHERE r.rev_stars>=1
GROUP BY m.mov_title
ORDER BY m.mov_title;

/*SET SQL_SAFE_UPDATES=0;*/

/*Q5*/

UPDATE rating r
JOIN movies m
ON m.mov_id=r.mov_id
JOIN director d
ON d.dir_id=m.dir_id
SET rev_stars=5
WHERE d.dir_name='STEVEN SPIELBERG';    

select * from rating;