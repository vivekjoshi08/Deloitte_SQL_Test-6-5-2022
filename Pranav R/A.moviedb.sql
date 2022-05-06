use mov_dbtest;
CREATE TABLE actor(act_id INT PRIMARY KEY
, act_name VARCHAR(50), act_gender VARCHAR(1));

CREATE TABLE director( dir_id INT PRIMARY KEY,
dir_name VARCHAR(50), dir_phone VARCHAR(10));

CREATE TABLE movies(mov_id INT PRIMARY KEY,
mov_title VARCHAR(50), mov_year INT NOT NULL, mov_lang VARCHAR(50)
, dir_id INT REFERENCES director(dir_id));

CREATE TABLE movie_cast(act_id INT REFERENCES actor(act_id),
mov_id INT REFERENCES movies(mov_id), act_role VARCHAR(50));

CREATE TABLE rating(mov_id INT REFERENCES movies(mov_id), rev_stars INT NOT NULL);


INSERT INTO actor VALUES(301 , 'ANUSHKA', 'F');
INSERT INTO actor VALUES(302 , 'PRABHAS', 'M');
INSERT INTO actor VALUES(303 , 'PUNITH', 'M');
INSERT INTO actor VALUES(304 , 'JERMY', 'M');

SELECT * FROM actor;

DROP TABLE director;

CREATE TABLE director( dir_id INT PRIMARY KEY,
dir_name VARCHAR(50), dir_phone VARCHAR(20));

INSERT INTO director VALUES(60 , 'RAJAMOULI', 8751611001);
INSERT INTO director VALUES(61 , 'HITCHCOCK', 7766138911 );
INSERT INTO director VALUES(62 , 'FARAN', 9986776531 );
INSERT INTO director VALUES(63 , 'STEVEN SPIELBERG', 8989776530 );

SELECT * FROM director;

INSERT INTO movies VALUES(1001 , 'BAHUBALI-2', 2017, 'TELAGU', 60);
INSERT INTO movies VALUES(1002 , 'BAHUBALI-1', 2015, 'TELAGU', 60);
INSERT INTO movies VALUES(1003 , 'AKASH', 2008, 'KANNADA', 61);
INSERT INTO movies VALUES(1004 , 'WAR HORSE', 2011, 'ENGLISH', 63);

INSERT INTO movie_cast VALUES(301, 1002, 'HEROINE');
INSERT INTO movie_cast VALUES(301, 1001, 'HEROINE');
INSERT INTO movie_cast VALUES(303, 1003, 'HERO');
INSERT INTO movie_cast VALUES(303, 1002, 'GUEST');
INSERT INTO movie_cast VALUES(304, 1004, 'HERO ');


INSERT INTO rating VALUES(1001, 4);
INSERT INTO rating VALUES(1002, 2);
INSERT INTO rating VALUES(1003, 5);
INSERT INTO rating VALUES(1004, 4);


#QUERIES

#1
SELECT mov_title FROM movies
INNER JOIN director 
ON director.dir_id = movies.dir_id 
WHERE director.dir_name='HITCHCOCK';

#2
SELECT mov_title FROM movies
WHERE mov_id IN(SELECT mov_id FROM movie_cast
WHERE act_id IN(SELECT act_id FROM actor
WHERE act_id IN(SELECT act_id FROM movie_cast
GROUP BY act_id HAVING COUNT(act_id)>1)));

#3
SELECT act_name FROM actor
INNER JOIN movie_cast
ON movie_cast.act_id=actor.act_id
INNER JOIN movies
ON movies.mov_id=movie_cast.mov_id
WHERE movies.mov_year<2000
OR movies.mov_year>2015;

#4
SELECT mov_title, MAX(rev_stars) FROM movies
INNER JOIN rating
GROUP BY mov_title HAVING MAX(rev_stars)>1
ORDER BY mov_title;

#5
UPDATE rating SET rev_stars=5
WHERE mov_id IN(SELECT mov_id FROM movies
WHERE dir_id IN(SELECT dir_id FROM director
WHERE dir_name='STEVEN SPIELBERG'));

