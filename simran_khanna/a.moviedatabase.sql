use moviedatabase1;
create table ACTOR(
act_id int primary key,
act_name varchar(50) not null,
act_gender char not null
);
insert into ACTOR 
values
('301','ANUSHKA','F'),
('302','PRABHAS','M'),
('303','PUNITH','M'),
('304','JERMY','M');
create table director1(
dir_id int primary key,
dir_name varchar(25) not null,
dir_phone varchar(10)
);

insert into director1
values
('60','RAJMOULI','8751611001'),
('61','HITCHCOCK','7766138911'),
('62','FARAN','9986776531'),
('63','STEVEN SPEILBERG','8989776530');

create table movies(
mov_id INT PRIMARY KEY,
mov_title VARCHAR(50) NOT NULL,
mov_year INT NOT NULL,
mov_lang varchar(50) not null,
dir_id int references director(dir_id)
);
insert into movies
values
('1001','BAHUBALI -2','2017','TELAGU', '60'),
('1002','BAHUBALI -1','2015','TELAGU', '60'),
('1003','AKASH','2008','KANNADA','61'),
('1004','WAR HORSE','2011','ENGLISH','63');
CREATE TABLE movie_cast(
act_id INT REFERENCES actor(act_id),
mov_id INT REFERENCES movie(mov_id),
role1 VARCHAR(30) NOT NULL
);
insert into movie_cast
values
('301','1002','HEROINE'),
('302','1001','HEROINE'),
('303','1003','HERO'),
('303','1002','GUEST'),
('304','1004','HERO');

CREATE TABLE rating(
mov_id INT REFERENCES movie(mov_id),
rev_stars DECIMAL (5,2)

);
insert into rating
values
('1001','4'),
('1002','2'),
('1003','5'),
('1004','4');
/*1..*/
select mov_title from movies






