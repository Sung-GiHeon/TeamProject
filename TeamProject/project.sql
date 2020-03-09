SHOW tables;

SELECT * FROM user_tbl;
DESC user_tbl;

ALTER table re_support_tbl add updatedate TIMESTAMP default now();

DELETE table user_tbl WHERE post = '47718';

DROP table user_tbl;

CREATE table user_tbl(
	userNum int PRIMARY KEY auto_increment,
	name VARCHAR(30) NOT NULL,
	email VARCHAR(30) NOT NULL UNIQUE,
	password int NOT NULL,
	post VARCHAR(30) NOT NULL,
	addr VARCHAR(30) NOT NULL,
	addr_detail VARCHAR(30) NOT NULL,
	phoneNum int NOT NULL,
	regdate TIMESTAMP default now(),
	withdraw VARCHAR(1) default 'n'
);

INSERT INTO accidentboard_tbl SELECT title,writer,content,region,userNum,userHidden FROM accidentboard_tbl;

DESC qnaboard_tbl;
DELETE FROM re_qna_tbl;
SELECT * FROM re_support_tbl;
SELECT * FROM re_qna_tbl;
SELECT * FROM user_tbl;
SELECT * FROM ban_ip;
