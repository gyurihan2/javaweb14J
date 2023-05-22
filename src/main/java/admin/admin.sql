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