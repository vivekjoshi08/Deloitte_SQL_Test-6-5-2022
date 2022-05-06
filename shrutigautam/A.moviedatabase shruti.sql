use movieassignment;

create table actor(
act_id INT PRIMARY KEY,
act_name VARCHAR(25),
A VARCHAR(1)
);
INSERT INTO actor VALUES(301, "Anushka", "F");
INSERT INTO actor VALUES(302, "Prabhas", "M");
INSERT INTO actor VALUES(303, "Punith", "M");
INSERT INTO actor VALUES(304, "Jermy", "M");
select* from actor;

create table directo(
dir_id INT primary key,
dir_name VARCHAR(25),
dir_phone varchar(20)
);
INSERT INTO directo VALUES(60, "Rajamouli", 8751611001);
INSERT INTO directo VALUES(61, "Hitchcock", 7766138911);
INSERT INTO directo VALUES(62, "Faran", 9986776531);
INSERT INTO directo VALUES(63, "Steven Spielberg", 8989776530);


create table movies(
mov_id int primary key,
mov_title varchar(20),
mov_year int,
mov_lang varchar(20),
dir_id int references directo(dir_id));

INSERT INTO movies VALUES(1001, "Bahubali-2",2017, "Telagu",60);
INSERT INTO movies VALUES(1002, "Bahubali-1",2015, "Telagu",60);
INSERT INTO movies VALUES(1003, "Akash",2008, "Kannada",61);
INSERT INTO movies VALUES(1004, "War Horse",2011, "English",63);


create table movie_cast(
act_id int references actor(act_id),
mov_id int references movies(mov_id),
role varchar(20)
);
INSERT INTO movie_cast VALUES(301,1002,"Heroine");
INSERT INTO movie_cast VALUES(301,1001,"Heroine");
INSERT INTO movie_cast VALUES(303,1003,"Hero");
INSERT INTO movie_cast VALUES(303,1002,"Guest");
INSERT INTO movie_cast VALUES(304,1004,"Hero");

create table rating(
mov_id int references movies(mov_id),
rev_stars int
);
INSERT INTO rating VALUES(1001,4);
INSERT INTO rating VALUES(1002,2);
INSERT INTO rating VALUES(1003,5);
INSERT INTO rating VALUES(1004,4);

SELECT* FROM movie_cast;

#1
SELECT mov_title from movies 
join directo on movies.dir_id=directo.dir_id
where dir_name="hitchcock";

#2
select mov_title from movies where mov_id in(
select mov_id from movie_cast where act_id in(
select act_id from actor where act_id in(
select act_id from movie_cast group by
act_id having count(*)>=2))); 

#3
select act_name from actor
inner join movie_cast on actor.act_id=movie_cast.act_id
inner join movies on movie_cast.mov_id=movies.mov_id
where mov_year<2000 or mov_year>2015;

#4
select mov_title,max(rev_stars)
from movies
inner join rating using(mov_id)
group by mov_title
having max(rev_stars)>0
order by mov_title;

#5
update rating set rev_stars=5 where  
mov_id in (select mov_id from  movies
 where dir_id in(select dir_id from directo where dir_name="Steven Spielberg"));
select* from rating;
