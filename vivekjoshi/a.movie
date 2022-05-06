use movie99;

create table actor(
act_id int primary key,
act_name varchar(50),
act_gender varchar(1)
);

create table director(
dir_id int primary key,
dir_name varchar(50),
dir_phone varchar(50)
);

create table movies(
mov_id int primary key,
mov_title varchar(50),
mov_year int,
mov_lang varchar(50),
dir_id int,
foreign key (dir_id) references director(dir_id)
);

create table movie_cast(
act_id int references actor(act_id),
mov_id int ,
role_ varchar(50),
foreign key (mov_id) references movies(mov_id)
);

create table rating(
mov_id int,
rev_star int,
foreign key (mov_id) references movies(mov_id)
);



#inserting values to the table

insert into actor( act_id, act_name, act_gender )
values 
(301, 'ANUSHKA', 'F'),
(302, 'PRABHAS', 'M'),
(303, 'PUNITH', 'M'),
(304, 'JERMY', 'M');

#SELECT * FROM ACTOR;

insert into director(dir_id, dir_name, dir_phone)
values
(60, 'RAJAMOULI', '8751611001'),
(61, 'HITCHCOCK', '7766138911'),
(62, 'FARAN', '9986776531'),
(63, 'STEVEN SPIELBERG', '8989776530');

#SELECT * FROM DIRECTOR;

insert into movies(mov_id, mov_title, mov_year, mov_lang, dir_id )
values
(1001, 'BAHUBALI-2', 2017, 'TELAGU', 60),
(1002, 'BAHUBALI-1', 2015, 'TELAGU', 60),
(1003, 'AKASH', 2008, 'KANNADA', 61),
(1004, 'WAR HORSE', 2011, 'ENGLISH', 63);

#SELECT * FROM MOVIES;

insert into movie_cast( act_id, mov_id, role_)
values
(301, 1002, 'HEROINE'),
(301, 1001, 'HEROINE'),
(303, 1003, 'HERO'),
(303, 1002, 'GUEST'),
(304, 1004, 'HERO');

#SELECT * FROM MOVIE_CAST;

insert into rating(mov_id, rev_star)
values
(1001, 4),
(1002, 2),
(1003, 5),
(1004, 4);

#SELECT * FROM RATING;

# WRITING QUERIES FROM HERE

#1 : MOVIES DIRECTED BY HITCHCOK
select mov_title from movies 
where dir_id in ( select dir_id from director where dir_name = 'HITCHCOCK');

#2: MOV_TITLE ? WHERE ONE OR MORE ACTOR WORKED IN TWO OR MORE MOVIE
select mov_title from movies
inner join movie_cast on movie_cast.mov_id = movies.mov_id
inner join actor on actor.act_id = movie_cast.act_id
group by movie_cast.act_id having count(movie_cast.act_id)> 1;

#3: select actor who worked in movies before 2000 and after 2015
select act_name from actor
join movie_cast on movie_cast.act_id = actor.act_id
join movies on movies.mov_id = movie_cast.mov_id
where mov_year < 2000 or mov_year >2015;

#4 
select mov_title, rev_star from rating
inner join movies on movies.mov_id = rating.mov_id
where rev_star > 1;

#5 update rating of movie directed by steven spielberg
update rating
set rev_star = 5 
where mov_id in ( 
select mov_id from movies 
inner join director on director.dir_id = movies.dir_id 
where dir_name = 'STEVEN SPIELBERG' 
);
#select * from rating;