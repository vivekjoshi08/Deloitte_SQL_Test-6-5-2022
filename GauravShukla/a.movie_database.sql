use movies_practical;

create table actor(act_id int primary key,act_name varchar(40) not null,act_gender varchar(20) not null);

create table director(dir_id int primary key,dir_name varchar(40) not null,dir_phone varchar(50));

drop table movies;
create table movies(mov_id int primary key,mov_title varchar(30) not null,mov_year int not null,mov_lang varchar(10),dir_id INT references director(dir_id));

create table movie_cast(act_id int references actor(act_id),mov_id INT references movie(mov_id),role VARCHAR(50) NOT NULL);

drop table rating;
create table rating(mov_id int references movie(mov_id),rev_stars int not null);

insert into actor (act_id,act_name,act_gender) values(301,'ANUSHKA','F'),
(302,'PRABHAS','M'),(303,'PUNITH','M'),(304,'JERMY','M');

INSERT INTO director (dir_id,dir_name,dir_phone)VALUES(60,'Rajamouli','8751611001'),
(61,'Hitchcock','7766138911'),
(62,'Faran','9986776531'),
(63,'Steven Spielberg','8989776530');

INSERT INTO movies (mov_id,mov_title,mov_year,mov_lang,dir_id)VALUES(1001,'Bahubali-2',2017,'Telagu',60),
(1002,'Bahubali-1',2015,'Telagu',60),
(1003,'Akash',2008,'Kannada',61),
(1004,'War Horse',2011,'English',63);

Insert into movie_cast(act_id, mov_id,role) values(301,1002,'Heroine'),
(301,1001,'Heroine'),
(303,1003,'Hero'),
(303,1002,'Guest'),
(304,1004,'Hero');

insert into rating (mov_id,rev_stars)values(1001,4),
(1002,2),(1003,5),(1004,4);

Select * from actor;
Select * from director;
Select * from movies;
Select * from movie_cast;
Select * from rating;

#1
select mov_title from movies a join director b on a.dir_id = b.dir_id where dir_name = 'Hitchcock';

#2
select mov_title from movies a ,movie_cast b where a.mov_id = b.mov_id and act_id in (select act_id from movie_cast group by act_id having count(act_id)>1) group by mov_title having count(mov_title)>1;

#3
SELECT act_name FROM actor JOIN movie_cast ON actor.act_id=movie_cast.act_id
JOIN movies ON movie_cast.mov_id=movies.mov_id WHERE mov_year NOT BETWEEN 2000 and 2015;


#4
SELECT mov_title, MAX(rev_stars)
FROM movies
INNER JOIN rating USING(mov_id)
GROUP BY mov_title
HAVING MAX(rev_stars)>0
ORDER BY mov_title;

#5
UPDATE rating r inner join movies m on r.mov_id = m.mov_id inner join director d on d.dir_id=m.dir_id
 SET rev_stars=5 where d.dir_name='Steven Spielberg';

