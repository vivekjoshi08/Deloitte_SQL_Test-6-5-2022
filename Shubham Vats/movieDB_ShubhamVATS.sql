use movie_assessment;
CREATE TABLE Actor(act_id INT PRIMARY KEY,
	act_name VARCHAR(20) NOT NULL,
    act_gender VARCHAR(50) NOT NULL);
    
CREATE TABLE director(dir_id INT PRIMARY KEY,
	dir_name VARCHAR(50) NOT NULL ,
    dir_phone VARCHAR(20) NOT NULL);
    
CREATE TABLE movie(mov_id INT PRIMARY KEY , 
	mov_title VARCHAR(50) NOT NULL, 
	mov_year INT NOT NULL, 
	mov_lang VARCHAR(50) NOT NULL, 
	dir_id INT NOT NULL,
	FOREIGN KEY(dir_id) REFERENCES director(dir_id));
    
CREATE TABLE movie_cast(act_id INT,
	mov_id INT,
    role1 VARCHAR(50) NOT NULL,
    FOREIGN KEY(act_id) REFERENCES Actor(act_id),
    FOREIGN KEY(mov_id) REFERENCES movie(mov_id));
    
CREATE TABLE rating(mov_id INT,
    rev_stars INT,
    FOREIGN KEY(mov_id) REFERENCES Movie(mov_id));
    
    
INSERT INTO Actor(act_id,act_name,act_gender) Values 
(301,"Anushka","F"),
(302,"Prabhas","M"),
(303,"Punith","M"),
(304,"Jermy","M");


INSERT INTO director(dir_id,dir_name,dir_phone) VALUES
(60,"Rajamouli","8751611011"),
(61,"Hitchcock","7766138911"),
(62,"Faran","9986776531"),
(63,"Steven Spielberg","8989776530");

INSERT INTO movie(mov_id, mov_title,mov_year,mov_lang,dir_id) VALUES 
(1001,"Bahubali-2",2017,"Telagu",60),
(1002,"Bahubali-1",2015,"Telagu",60),
(1003,"Akash",2008,"Kannada",61),
(1004,"War House",2011,"English",63);


INSERT INTO movie_cast(act_id,mov_id,role1)	VALUES 
(301,1002,"Heroine"),
(301,1001,"Heroine"),
(303,1003,"Hero"),
(303,1002,"Guest"),
(304,1004,"Hero");


INSERT INTO rating(mov_id,rev_stars) VALUES	
(1001,4),
(1002,2),
(1003,5),
(1004,4);


#QUERY 1

Select mov_title from
movie m INNER JOIN director d 
ON m.dir_id=d.dir_id
where 
dir_name="Hitchcock";


#QUERY 2
SELECT mov_title
FROM movie m,movie_cast c
WHERE m.mov_id=c.mov_id AND act_id IN (SELECT act_id
FROM movie_cast GROUP BY act_id
HAVING COUNT(act_id)>=1)
GROUP BY mov_title
HAVING COUNT(mov_title)>=2;

#query3
SELECT act_name
FROM Actor a
JOIN movie_cast c
ON a.act_id=c.act_id
JOIN movie m
ON c.mov_id=m.mov_id
WHERE m.mov_year < 2000 AND m.mov_year > 2015;

#query4
SELECT mov_title,MAX(rev_stars)
FROM movie
INNER JOIN rating USING (mov_id)
GROUP BY mov_title
HAVING rev_stars>1
ORDER BY mov_title;

#query5
UPDATE rating
SET rev_stars=5
WHERE mov_id IN (SELECT mov_id FROM movie
WHERE dir_id IN (SELECT dir_id
FROM director
WHERE dir_name='Steven Spielberg'));


