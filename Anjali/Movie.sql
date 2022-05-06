use moviedatabase;
create table actor(
act_id int primary key,
act_name varchar(50) not null,
act_gen varchar(1) not null);
drop table director;
create table director(
dir_id int primary key,
dir_name varchar(50) not null,
dir_ph varchar(50)not null);
create table movie(
mov_id int primary key,
mov_title varchar(50) not null,
mov_year int not null,
mov_lang varchar(30) not null,
dir_id int references director(dir_id));
create table movie_cast(
act_id int references actor(act_id),
mov_id int references movie(mov_id),
role varchar(50) not null);
create table rating(
mov_id int references movie(mov_id),
rev_stars int not null);
#insertion
insert into actor(act_id,act_name,act_gen) values
(301,' Anushka','F'),
(302,' Prabhas','M'),
(303,' Punith','M'),
(304, 'Jermy','M');
INSERT into director(dir_id,dir_name,dir_ph)values
(60,'Rajamouli',8751611001),
(61,'Hitchcock',7766138911),
(62,'Faran',9986776531),
(63,'Steven Spielberg',8989776530);
insert into movie(mov_id,mov_title,mov_year,mov_lang,dir_id) values 
(1001,'Bahubali-2',2017,'Telagu',60),
(1002,'Bahubali-1',2015,'Telagu',60),
(1003, 'Akash',2008,'Kannada',61),
(1004,'War Horse',2011,'English',63);
insert into movie_cast(act_id,mov_id,role)values
(301,1002,'Heroine'),
(301,1001,'Heroine'),
(303,1003,'Hero'),
(303,1002,'Guest'),
(304,1004,'Hero');
insert into rating(mov_id,rev_stars)values
(1001,4),
(1002,2),
(1003,5),
(1004,4);
#queries
#1
select mov_title from movie where dir_id in(select dir_id from director where dir_name='Hitchcock');
#2
select mov_title from movie where mov_id in (select mov_id from movie_cast where act_id in(select act_id from actor 
where act_id in(select act_id from movie_cast group by act_id having count(act_id)>1)));
#3
select act_name from actor join movie_cast on actor.act_id=movie_cast.act_id join movie on movie_cast.mov_id=movie.mov_id
where mov_year not between 2000 and 2015;
#4
select mov_title, max(rev_stars)
from movie inner join rating using(mov_id)
group by mov_title having max(rev_stars)>0
order by mov_title;
#5
set sql_safe_updates=0;
update rating join movie on movie.mov_id=rating.mov_id
join director on director.dir_id=movie.mov_id set rev_stars=5
where dir_name= 'Steven Spielberg';