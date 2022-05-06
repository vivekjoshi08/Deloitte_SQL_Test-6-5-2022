use practical;
create table actor( Act_id INT PRIMARY KEY, Act_Name VARCHAR(50),Act_Gender VARCHAR(5));
INSERT INTO actor (Act_Id,Act_Name,Act_Gender)VALUES(301,'Anushka','F');
INSERT INTO actor (Act_Id,Act_Name,Act_Gender)VALUES(302,'Prabhas','M');
INSERT INTO actor (Act_Id,Act_Name,Act_Gender)VALUES(303,'Punith','M');
INSERT INTO actor (Act_Id,Act_Name,Act_Gender)VALUES(304,'Jermy','M');
CREATE TABLE director ( Dir_Id INT PRIMARY KEY, Dir_Name VARCHAR(50),Dir_Phone varchar(50));
INSERT INTO director (Dir_Id,Dir_Name,Dir_Phone)VALUES(60,'Rajamouli','8751611001'),
(61,'Hitchcock','7766138911'),
(62,'Faran','9986776531'),
(63,'Steven Spielberg','8989776530');
CREATE TABLE movie ( Mov_Id INT PRIMARY KEY, Mov_Title VARCHAR(50) NOT NULL,Dir_Id int,
 Mov_Year INT NOT NULL,Mov_Lang VARCHAR(50) NOT NULL, FOREIGN KEY(Dir_Id) REFERENCES director(Dir_Id));
INSERT INTO movie (Mov_Id,Mov_Title,Mov_Year,Mov_Lang,Dir_Id)VALUES(1001,'Bahubali-2',2017,'Telagu',60),
(1002,'Bahubali-1',2015,'Telagu',60),
(1003,'Akash',2008,'Kannada',61),
(1004,'War Horse',2011,'English',63);
create table movie_cast (Act_id int,Mov_Id int,Role varchar(30),
Foreign key(Act_id) references actor(Act_id),foreign key (Mov_id) references movie(Mov_Id));
Insert into movie_cast(Act_id, Mov_Id,Role) values(301,1002,'Heroine'),
(301,1001,'Heroine'),
(303,1003,'Hero'),
(303,1002,'Guest'),
(304,1004,'Hero');
create table rating (Mov_Id int , Rev_Stars int,foreign key (Mov_id) references movie(Mov_Id));
insert into rating (Mov_Id,Rev_Stars)values(1001,4),
(1002,2),(1003,5),(1004,4);
Select * from actor;
Select * from director;
Select * from movie;
Select * from movie_cast;
Select * from rating;
Select Mov_Title from movie join director on movie.Dir_Id=director.Dir_Id where Dir_Name='Hitchcock';
SELECT Mov_Title FROM movie WHERE mov_id IN ( SELECT Mov_Id FROM movie_cast WHERE Act_id IN 
(SELECT Act_id FROM actor WHERE Act_id IN (SELECT Act_id FROM movie_cast GROUP BY Act_id HAVING COUNT(Act_id)>1)));

SELECT Act_Name FROM actor JOIN movie_cast ON actor.act_id=movie_cast.act_id
JOIN movie ON movie_cast.mov_id=movie.mov_id WHERE mov_year NOT BETWEEN 2000 and 2015;
SELECT Mov_Title, MAX(rev_stars)
FROM movie
INNER JOIN rating USING(Mov_Id)
GROUP BY Mov_Title
HAVING MAX(rev_stars)>0
ORDER BY Mov_Title;
UPDATE rating r inner join movie m on r.Mov_Id = m.Mov_Id inner join director d on d.Dir_Id=m.Dir_Id SET Rev_Stars=5 where d.Dir_Name='Steven Spielberg';



