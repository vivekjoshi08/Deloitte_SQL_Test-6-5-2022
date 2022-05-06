use assessmentmovie_database;

/* creation of the tables */

CREATE TABLE actor (
act_id INT PRIMARY KEY,
act_name VARCHAR(20) NOT NULL,
act_gender VARCHAR(1) NOT NULL
);

CREATE TABLE director (
dir_id INT PRIMARY KEY,
dir_name VARCHAR(50) NOT NULL,
dir_phone VARCHAR(30) NOT NULL
);

CREATE TABLE movies (
mov_id INT PRIMARY KEY,
mov_title VARCHAR(50) NOT NULL,
mov_year INT NOT NULL,
mov_lang VARCHAR(50) NOT NULL,
dir_id INT REFERENCES director(dir_id)
);

CREATE TABLE movie_cast (
act_id INT REFERENCES actor(act_id),
mov_id INT REFERENCES movie(mov_id),
role1 VARCHAR(30) NOT NULL
);

CREATE TABLE rating (
mov_id INT REFERENCES movies(mov_id),
rev_stars INT NOT NULL
);

/* inserting values in the table */

/* inserting into actor table */
INSERT INTO actor(act_id, act_name, act_gender)
VALUES(301, 'Anushka', 'F');
INSERT INTO actor(act_id, act_name, act_gender)
VALUES(302, 'Prabhas', 'M');
INSERT INTO actor(act_id, act_name, act_gender)
VALUES(303, 'Punith', 'M');
INSERT INTO actor(act_id, act_name, act_gender)
VALUES(304, 'Jermy', 'M');

/* inserting into director table */
INSERT INTO director(dir_id, dir_name, dir_phone)
VALUES(60, 'RajaMouli', '8751611001');
INSERT INTO director(dir_id, dir_name, dir_phone)
VALUES(61, 'Hitchcock', 7766138911);
INSERT INTO director(dir_id, dir_name, dir_phone)
VALUES(62, 'Faran', 9986776531);
INSERT INTO director(dir_id, dir_name, dir_phone)
VALUES(63, 'Steven Speilberg', 8989776530);

/* inserting into movies table */
INSERT INTO movies(mov_id, mov_title, mov_year, mov_lang, dir_id)
VALUES(1001, 'Bahubali-2', 2017, 'Telagu', 60);
INSERT INTO movies(mov_id, mov_title, mov_year, mov_lang, dir_id)
VALUES(1002, 'Bahubali-1', 2015, 'Telagu', 60);
INSERT INTO movies(mov_id, mov_title, mov_year, mov_lang, dir_id)
VALUES(1003, 'Akash', 2008, 'Kannada', 61);
INSERT INTO movies(mov_id, mov_title, mov_year, mov_lang, dir_id)
VALUES(1004, 'War House', 2011, 'English', 63);

/* inserting into movie_cast table */
INSERT INTO movie_cast(act_id, mov_id, role1)
VALUES(301, 1002, 'Heroine');
INSERT INTO movie_cast(act_id, mov_id, role1)
VALUES(301, 1001, 'Heroine');
INSERT INTO movie_cast(act_id, mov_id, role1)
VALUES(303, 1003, 'Hero');
INSERT INTO movie_cast(act_id, mov_id, role1)
VALUES(303, 1002, 'Guest');
INSERT INTO movie_cast(act_id, mov_id, role1)
VALUES(304, 1004, 'Hero');

/* inserting into rating table */
INSERT INTO rating(mov_id, rev_stars)
VALUES(1001, 4);
INSERT INTO rating(mov_id, rev_stars)
VALUES(1002, 2);
INSERT INTO rating(mov_id, rev_stars)
VALUES(1003, 5);
INSERT INTO rating(mov_id, rev_stars)
VALUES(1004, 4);

/* now the queries */

/* query1(to list the movies directed by hitchcock) */
SELECT mov_title 
FROM movies
WHERE dir_id IN (SELECT dir_id
FROM director
WHERE dir_name = 'Hitchcock');

/* query2(movie names where 1 or more actors acted in 2 or more movies) */
SELECT mov_title
FROM movies
WHERE mov_id IN (SELECT mov_id
FROM movie_cast
WHERE act_id IN (SELECT act_id
FROM actor
WHERE act_id IN (SELECT act_id
FROM movie_cast
GROUP BY act_id HAVING COUNT(act_id) > 1)));

/* query3(actors who acted in a movie before 2000 and after 2015) */
SELECT act_name 
FROM actor
INNER JOIN movie_cast
ON actor.act_id = movie_cast.act_id
INNER JOIN movies
ON movie_cast.mov_id = movies.mov_id 
WHERE mov_year 
NOT BETWEEN 2000 AND 2015;

/* query4(mov_title and rev_stars for movies with atleast 1 rating and find the highest no of stars thar movie received) */
SELECT mov_title, MAX(rev_stars)
FROM movies
INNER JOIN rating USING(mov_id)
GROUP BY mov_title
HAVING MAX(rev_stars) > 0
ORDER BY mov_title;

/* query5(update ratings of movies directed by steven spielberg to 5) */
SET sql_safe_updates=0;
UPDATE rating 
SET rev_stars = 5
WHERE mov_id IN (SELECT mov_id
FROM movies
WHERE dir_id IN (SELECT dir_id
FROM director
WHERE dir_name = 'Steven Spielberg')
);

select * from rating;


