show tables;

/* 상영관 테이블*/
create table theater(
	idx int not null auto_increment primary key,
	price int(10) not null,
	seat int(5) not null,
	name varchar(10) not null,
	thema varchar(10) not null,
	work char(5) not null default 'NO',
	regDate datetime not null default now(),
	modifyDate datetime not null default now(),
	UNIQUE KEY unique_name (name)
);

drop table theater;

ALTER TABLE theater ADD UNIQUE KEY unique_name (name);

desc theater;

/* 영화 테이블(영화 목록)*/
create table movie(
	idx varchar(15) not null primary key,
	mainImg varchar(30) not null,
	images varchar(100),
	imgFName varchar(100),
	title varchar(100) not null,
	genre varchar(50) not null,
	playTime int not null,
	openDate date not null,
	nation varchar(10) not null,
	director varchar(50) not null,
	actor varchar(200) not null,
	content text,
	grade char(5) not null,
	totalView int(10) default 0,
	rating float default 0
);

drop table movie;

desc movie;

create table schedule(
	idx int not null primary key auto_increment,
	theaterIdx int not null,
	movieIdx varchar(15) not null,
	screenOrder int(5),
	playDate date
);

select count(*) as cnt from movie where openDate < '2023-05-17';
select openDate from movie;
select * from movie  where openDate < '2023-05-17' order by openDate desc limit 0, 10;
desc schedule;

-- 차집합
select * from theater where idx not in
(select theaterIdx from schedule where playDate between '2023-05-26' and '2023-06-07' group by theaterIdx);


select theaterIdx from schedule where playDate between '2023-05-26' and '2023-06-07' group by theaterIdx









