use jcp;

create table tb_board(
	b_idx bigint auto_increment primary key,
    b_userid varchar(20) not null,
    b_title varchar(100) not null,
    b_content text not null,
    b_regdate datetime default now(),
    b_hit int default 0,
    b_like int default 0,
    b_img varchar(100)
);


select * from tb_board;


create table tb_reply(

	re_idx bigint auto_increment primary key,
    re_userid varchar(20) not null,
    re_content varchar(1000) not null,
    re_regdate datetime default now(),
    re_boardidx bigint not null
);

select * from tb_reply;

select count(re_idx) as replycnt from tb_reply where re_boardidx=5

