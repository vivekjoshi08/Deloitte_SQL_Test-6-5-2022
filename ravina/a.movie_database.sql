use test_movie;
create table actor(
act_id int primary key,
act_name varchar(50) not null,
act_gender varchar(1) not null
);

create table director(
dir_id int primary key,
dir_name varchar(50) not null,
dir_phone varchar(10) not null
);

create table movies(
mov_id int primary key,
mov_title varchar(50) not null,
mov_year int not null,
mov_lang varchar(50) not null,
dir_id int references director(dir_id)
);

create table movie_cast(
	act_id int references  actor(act_id),
    mov_id int references movies(mov_id),
    role1 varchar(50) not null
    );
    
create table rating(
mov_id int references movies(mov_id),
rev_stars int not null
);


insert into actor values (301,'ANUSHKA','F'),
						 (302,'PRABHAS','M'),
                         (303,'PUNITH','M'),
                         (304,'JERMY','M');

insert into director values (60,'RAJAMOULI','8751611001'),
							 (61,'HITCHCOCK','7766138911'),
							 (62,'FARAN','9986776531'),
							 (63,'STEVEN SPIELBERG','8989776530');
                             
insert into movies values (1001,'BAHUBALI-2',2017,'TELAGU',60),
						   (1002,'BAHUBALI-1',2015,'TELAGU',60),
                           (1003,'AKASH',2008,'KANNADA',61),
                           (1004,'WAR HORSE',2001,'ENGLISH',63);
                           
insert into movie_cast values (301,1002,'HEROINE'),
                              (301,1001,'HEROINE'),
                              (303,1003,'HERO'),
                              (303,1002,'GUEST'),
                              (304,1004,'HERO');
                              
insert into rating values (1001,4),
                          (1002,2),
                          (1003,5),
                          (1004,4);
                          
#--------------QUERIES---------

#1
select mov_title from movies where dir_id in
	(select dir_id from director where dir_name='HITCHCOCK');
    
#2
select mov_title from movies where mov_id in 
(select mov_id from movie_cast group by act_id having count(act_id)>=2);
    
#3
select act_name from actor a join movie_cast mc on a.act_id=mc.act_id
join movies m on m.mov_id=mc.mov_id where mov_year<2000 and mov_year>2015;

#4
select mov_title, rev_stars from movies m join rating r on m.mov_id=r.mov_id
where rev_stars>=1 order by mov_title;

#5
update rating
set rev_stars=5 where mov_id in
(select mov_id from movies m join director d 
on m.dir_id=d.dir_id where dir_name='STEVEN SPIELBERG');

select * from rating;


