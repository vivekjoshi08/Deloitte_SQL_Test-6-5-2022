use new_database;
create table actor(act_id int primary key,
act_name varchar(50) not null,
act_gender varchar(1) not null);

create table director1( dir_id int primary key,
dir_name varchar(50) not null,
dir_phone varchar(50) not null);

create table movie(mov_id int primary key,
movie_title varchar(50) not null,
mov_year int not null,
mov_lang varchar(20) not null,
dir_id int references director1(dir_id) 
);

create table movie_cast1( act_id int references actor(act_id),
mov_id int references movie(mov_id),
roles varchar(20) not null); 

create table ratings( mov_id int references movie(mov_id),
rev_stars decimal(5,2)
);


insert into actor(act_id, act_name, act_gender)
values
( 301, 'ANUSHKA', 'F'),
( 302, 'PRABHAS', 'M'),
( 303, 'PUNITH', 'M'),
( 304, 'JERMY', 'M');

insert into director1(dir_id, dir_name, dir_phone)
values 
(60, 'RAJAMOULI', '8751611001'),
(61, 'HITCHCOCK', '7766138911'),
(62, 'FARAN', '9986776531'),
(63, 'STEVEN SPIELBERG', '8989776530');

insert into movie(mov_id, movie_title,mov_year, mov_lang, dir_id)
values
(1001, 'BAHUBALI-2', 2017, 'TELAGU', 60),
(1002, 'BAHUBALI-1', 2015, 'TELAGU', 60),
(1003, 'AKASH', 2008, 'KANNADA', 61),
(1004, 'WAR HORSE', 2011, 'ENGLISH',63);

insert into movie_cast1(act_id, mov_id, roles)
values
( 301, 1002, 'HEROINE'),
( 301, 1001, 'HEROINE'),
( 303, 1003, 'HERO'),
( 303, 1002, 'GUEST'),
( 304, 1004, 'HERO');

insert into ratings(mov_id, rev_stars)
values
(1001, 4.00),
(1002, 2.00),
(1003, 5.00),
(1004, 4.00);

/* 1 */
select movie_title from movie where dir_id in(
select dir_id from director1 where dir_name ='HITCHCOCK');

/* 2 */
select movie_title from movie m, movie_cast1 m1 where 
m.mov_id = m1.mov_id and act_id in (
select act_id from movie_cast1 group by act_id having count(act_id)>1)
group by movie_title having count(movie_title) >1;

/* 3 */
select act_name from actor join movie_cast1 on movie_cast1.act_id = actor.act_id 
join movie on movie.mov_id = movie_cast1.mov_id
where mov_year<2000 or mov_year>2015;

/* 4 */
select movie_title, max(rev_stars) from movie m inner join ratings r on
m.mov_id = r.mov_id group by 
movie_title order by movie_title;

set SQL_SAFE_UPDATES = 0;
/* 5 */
update ratings 
set rev_stars=5
where mov_id in(select mov_id from movie where dir_id in(
select dir_id from director1 where dir_name = 'STEVEN SPIELBERG'));
select * from ratings;