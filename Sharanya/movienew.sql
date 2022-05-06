use movienew_database;

CREATE TABLE actor(act_id INT PRIMARY KEY, act_name VARCHAR(50),
act_gender VARCHAR(1));

INSERT INTO actor(act_id,act_name,act_gender)
VALUES
(301,'Anushka','F'),
(302,'Prabhas','M'),
(303,'Punit','M'),
(304,'Jermy','M');
select * from actor;

CREATE TABLE director(dir_id INT PRIMARY KEY, dir_name VARCHAR(50), dir_phone varchar(10));

INSERT INTO director(dir_id,dir_name,dir_phone)
VALUES
(60 ,'Rajmouli','8751611001'),
(61,'Hitchcock', '7766138911'),		
(62 ,'Faran','9986776511'),		
(63 ,'Steven Spielberg','8989776530');

select * from director;

CREATE TABLE movie(mov_id INT PRIMARY KEY, mov_title VARCHAR(50) NOT NULL,
mov_year INT NOT NULL, mov_lang VARCHAR(50) NOT NULL, dir_id INT);

INSERT INTO movie(mov_id,mov_title,mov_year,mov_lang,dir_id)
VALUES
(1001,'Bahubali-1',2017,'Telugu',60),
(1002,'Bahubali-2',2015,'Telugu',60),
(1003,'Akash',2008,'Kannada',61),
(1004,'War Horse',2011,'English',63);

CREATE TABLE movie_cast(act_id INT, FOREIGN KEY(act_id) REFERENCES actor(act_id),
mov_id INT, FOREIGN KEY(mov_id) REFERENCES movie(mov_id),role1 VARCHAR(50));

INSERT INTO movie_cast(act_id, mov_id, role1)
VALUES		
(301,1002,'Heroine'),		
(301,1001 ,'Heroine'),			
(303,1003 ,'Hero'),			
(303,1002 ,'Guest'),
(304,1004 ,'Hero');


CREATE TABLE rating(mov_id INT REFERENCES movie(mov_id), rev_stars DECIMAL);
INSERT INTO rating(mov_id,rev_stars)
VALUES
(1001 , 4),		
(1002 ,2),			
(1003 , 5),	
(1004 ,4);

#Q1
select mov_title from movie where dir_id in (select dir_id from director where dir_name='hitchcock');

#Q2
select mov_title from movie where mov_id in(select mov_id from movie_cast where act_id in (select act_id from actor where 
act_id in( select act_id from movie_cast GROUP BY act_id having count(*)>=2)));

#Q3
select act_name from actor 
inner join movie_cast on movie_cast.act_id=actor.act_id
inner join  movie on movie.mov_id=movie_cast.mov_id
where mov_year>2015 or mov_year<2000;

#Q4
select mov_title , max(rev_stars) from movie m 
inner join rating r on
m.mov_id=r.mov_id
group by mov_title
order by mov_title;

#q5
update rating set rev_stars = '5' where mov_id in(select mov_id from movie where dir_id in
(select dir_id from director where dir_name='Steven Spielberg'));

select * from rating;


