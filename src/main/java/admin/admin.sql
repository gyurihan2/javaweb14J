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
	idx int not null primary key,
	posterImg varchar(30) not null,
	images varchar(100),
	title varchar(100) not null,
	genre varchar(50) not null,
	playTime time not null,
	openDate date not null,
	director varchar(50) not null,
	actor varchar(200) not null,
	content text,
	totalView int(10) default 0,
	rating float default 0
);

drop table movie;


desc movie;















