show tables;

create table reservation(
	idx int not null primary key auto_increment,
	scheduleIdx int not null,
	memberMid varchar(20) not null,
	seatInfo varchar(300) not null,
	seatCnt int(5) not null,
	reserDate datetime not null default now()
);

desc reservation;


select a.*, c.name as theaterName from movie as a,
(select * from schedule where playDate = '2023-06-01' group by theaterIdx) as b ,
(select * from theater) as c 
where a.idx=b.movieIdx and c.idx=b.theaterIdx;


select a.*,b.seat, b.price from schedule as a,
(select idx,seat,price from theater where name= '1 상영관') as b,
(select idx from movie where title='인어공주') as c
where a.playDate='2023-05-25' and a.theaterIdx = b.idx and a.movieIdx=c.idx;

select count(*) from reservation where scheduleIdx = 462;


select a.* , count(*) as res, b.price from reservation as a ,
(select * from theater)  as b 
where scheduleIdx = 462 and b.name='1 상영관';

select * from theater where name='1 상영관';




