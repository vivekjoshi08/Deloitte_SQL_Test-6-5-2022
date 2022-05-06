use movies;
create table ACTOR(
	act_id int primary key,
    act_name varchar(25) not null,
    act_gender varchar(1) not null
);
create table DIRECTOR(
	dir_id int primary key,
    dir_name varchar(25) not null,
    dir_phone varchar(15) not null 
);
create table MOVIES(
	mov_id int primary key,
    mov_title varchar(50) not null,
    mov_year int not null,
    mov_lang varchar(20) not null,
    dir_id int references DIRECTOR(dir_id)
);
create table MOVIE_CAST(
	act_id int references ACTOR(act_id),
    mov_id int references MOVIES(mov_id),
    role1 varchar(20)
);
create table RATING(
	mov_id int references MOVIES(mov_id),
    rev_stars int 
);
insert into ACTOR(act_id,act_name,act_gender) values (301,'Anushka','F'), (302,'Prabhas','M'), (303,'Punith','M'), (304,'Jermy','M');
insert into DIRECTOR(dir_id,dir_name,dir_phone) values (60,'Rajamouli',8751611001),(61,'Hitchcock',7766138911),(62,'Faran',9986776531),(63,'Steven Spielberg',8989776530);
insert into MOVIES(mov_id,mov_title,mov_year,mov_lang,dir_id) values (1001,'Bahubali-2',2017,'Telagu',60),(1002,'Bahubali-1',2015,'Telagu',60),(1003,'Akash',2008,'Kanada',61),(1004,'War Horse',2011,'English',63);
insert into MOVIE_CAST(act_id,mov_id,role1) values (301,1002,'Heroine'),(301,1001,'Heroine'),(303,1003,'Hero'),(303,1002,'Guest'),(304,1004,'Hero');
insert into RATING(mov_id,rev_stars) values (1001,4),(1002,2),(1003,5),(1004,4);

#query1
select mov_title from MOVIES m left join DIRECTOR d on m.dir_id=d.dir_id where dir_name = 'Hitchcock';
#query2
select mov_title from MOVIES M inner join MOVIE_CAST c on m.mov_id=c.mov_id group by c.act_id having count(c.act_id)>1;
#query3
select a.act_id,act_name,act_gender from ACTOR a
inner join MOVIE_CAST mc on a.act_id = mc.act_id
inner join MOVIES m on mc.mov_id = m.mov_id
where mov_year<2000 or mov_year>2015;
#query4
select mov_title,rev_stars from RATING r inner join MOVIES m on r.mov_id = m.mov_id where rev_stars > 1 order by mov_title;
#query5
update RATING set rev_stars=5 where mov_id in (select mov_id from MOVIES m inner join DIRECTOR d on m.dir_id=d.dir_id where dir_name = 'Steven Spielberg');