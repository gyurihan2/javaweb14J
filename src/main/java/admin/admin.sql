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
	playDate date,
	startTime time
);

select count(*) as cnt from movie where openDate < '2023-05-17';
select openDate from movie;
select * from movie  where openDate < '2023-05-17' order by openDate desc limit 0, 10;
desc schedule;

select name from theater as a, (select theaterIdx from schedule where playDate like '2023-05%' group by theaterIdx) as b where a.idx = b.theaterIdx;

-- 영화관리 페이지(admin) 달력에 표시할 해당 일에 운영중인 상영관 표시
select theaterIdx,playDate from schedule where playDate like '2023-05%' group by theaterIdx,playDate order by playDate;
select name,b.playDate from theater as a, (select theaterIdx,playDate from schedule where playDate like '2023-05%' group by theaterIdx,playDate) as b where a.idx = b.theaterIdx order by b.playDate,a.name;

select name,b.playDate,b.movieIdx from theater as a, (select theaterIdx,playDate,movieIdx from schedule where playDate like '2023-05%' group by theaterIdx,playDate) as b where a.idx = b.theaterIdx order by b.playDate,a.name;

-- 스케줄 일자 클릭시 해당 일의 상영중인(All) 리스트 확인
select a.idx, a.name, c.title, c.mainImg, c.totalView, c.rating, c.playTime from theater as a, 
(select * from schedule as c where playDate = '2023-06-01' group by theaterIdx) as b,
(select * from movie) as c
where a.idx = b.theaterIdx and b.movieIdx = c.idx order by b.playDate,a.name;

select title from movie;

-- 스케줄 상영관 클릭 시 해당 일의 정보 출력 
select a.idx, a.name, b.startTime,c.title, c.mainImg, c.totalView, c.rating, c.playTime, concat(b.playDate,' ',b.startTime) as ymdTime from theater as a, 
(select * from schedule as c where playDate = '2023-06-01') as b,
(select * from movie) as c
where a.idx = b.theaterIdx and b.movieIdx = c.idx  and a.name='1 상영관' order by b.startTime;

-- 메인페이지에 표시할 영화 목록(오늘 날짜에 일정이 등록된 영화 목록)
select * from schedule where playDate ='2023-05-25'
select movieIdx from schedule where playDate ='2023-05-25' group by movieidx;
select * from movie as a ,(select movieIdx from schedule where playDate ='2023-05-30' group by movieidx) as b where a.idx = b.movieIdx;

-- 차집합
select * from theater where idx not in
(select theaterIdx from schedule where playDate between '2023-05-26' and '2023-06-07' group by theaterIdx);


select theaterIdx from schedule where playDate between '2023-05-26' and '2023-06-07' group by theaterIdx









