/*MyHome Project2 DB쿼리*/

DROP table boardlist;
DROP TABLE membership;
DROP TABLE multiboard; 

SELECT * FROM membership;

/*테이블 생성*/
CREATE TABLE boardList(
	BoardName VARCHAR(30) NOT NULL PRIMARY KEY,
	BoardType varchar(30) NOT NULL,
	WriteGrade VARCHAR(10) NOT NULL,
	ReadGrade VARCHAR(10) NOT NULL
);

CREATE TABLE membership(
	Id VARCHAR(30) NOT NULL PRIMARY KEY,
	Pw VARCHAR(30) NOT NULL,
	Name VARCHAR(30) NOT NULL,
	Phone VARCHAR(30),
	Address VARCHAR(100),
	Email VARCHAR(50) NOT null,
	MemberGrade VARCHAR(10) DEFAULT 'normal',
	RegiDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE multiBoard(
	Num INT NOT NULL PRIMARY KEY auto_increment,
	Title VARCHAR(50) NOT NULL,
	Content TEXT(600) NOT NULL,
	PostDate DATETIME DEFAULT CURRENT_TIMESTAMP,
	Id VARCHAR(30) NOT NULL,
	BoardName VARCHAR(30) NOT NULL,
	VisitCount INT DEFAULT 0,
	AttachedFile TEXT(100),
	FOREIGN KEY(Id) references membership(id),
	FOREIGN KEY(BoardName) REFERENCES boardlist(BoardName)
);
ALTER TABLE multiboard ADD DATE DATETIME;

CREATE TABLE request_form(
	Num INT NOT NULL PRIMARY KEY auto_increment,
	NAME VARCHAR(50) NOT NULL,
	address VARCHAR(100),
	Disorder VARCHAR(50),
	aid VARCHAR(50),
	phone1 VARCHAR(30) NOT NULL,
	phone2 VARCHAR(30),
	email VARCHAR(50) NOT NULL,
	req1 VARCHAR(100) not NULL,
	req2 VARCHAR(100) NOT NULL,
	reqD VARCHAR(50) NOT NULL,
	reqK VARCHAR(5) NOT NULL,
	memo VARCHAR(100),
	reqname VARCHAR(10) NOT NULL
);

CREATE TABLE shop_products(
	num INT NOT null PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(50) NOT NULL,
	price INT NOT NULL,
	POINT INT,
	info VARCHAR(100),
	img VARCHAR(100)
);

CREATE TABLE shop_basket(
	idx INT NOT NULL PRIMARY KEY auto_increment,
	num INT NOT NULL,
	id VARCHAR(30) NOT NULL,
	quantity INT NOT NULL DEFAULT 1,
	total INT NOT NULL,
	FOREIGN KEY(Id) references membership(id),
	FOREIGN KEY(num) REFERENCES shop_products(num)
);
DROP TABLE shop_basket;

CREATE TABLE shop_ordering(
	Id VARCHAR(30) NOT NULL,
	num INT NOT NULL,
	quantity INT NOT NULL,
	total INT NOT NULL,
	orderdate DATETIME DEFAULT CURRENT_TIMESTAMP,
	oname VARCHAR(50) NOT NULL,
	oaddress VARCHAR(50) NOT NULL,
	ophone VARCHAR(50) NOT NULL,
	oemail VARCHAR(50) NOT NULL,
	sname VARCHAR(50) NOT NULL,
	saddress VARCHAR(50) NOT NULL,
	semail VARCHAR(50) NOT NULL,
	sphone VARCHAR(50) NOT NULL,
	pay VARCHAR(10) NOT NULL,
	FOREIGN KEY(num) REFERENCES shop_products(num),
	FOREIGN KEY(Id) references membership(id)
);
DROP TABLE shop_ordering;
SELECT * FROM shop_ordering;

/*더미데이터*/
INSERT INTO membership(id, pw, NAME, email, membergrade) VALUES('kosmo', '1234', '코스모', 'kosmo@gmail.com', 'normal');
INSERT INTO membership(id, pw, NAME, email) VALUES('nanna', '1234', '난나', 'kosmo@gmail.com');
UPDATE membership SET membergrade='manager' WHERE id='kosmo';


SELECT * from boardlist;
INSERT INTO boardlist VALUES('info', 'list', 'normal', 'normal');
INSERT INTO boardlist VALUES('free', 'list', 'normal', 'normal');
INSERT INTO boardlist VALUES('notice', 'list', 'manager','normal');
INSERT INTO boardlist VALUES('photo', 'photo','normal','normal');
INSERT INTO boardlist VALUES('staff', 'file', 'manager','manager');
INSERT INTO boardlist VALUES('guardian', 'file', 'normal','normal');
INSERT INTO boardlist VALUES('cal', 'cal', 'manager','normal');

/*쿼리테스트*/
select * from membership;
SELECT * FROM boardlist;
SELECT * FROM multiboard;

SELECT * FROM request_form;
DELETE FROM multiboard WHERE boardname='info';
delete FROM membership WHERE id='kosmo';

SELECT * from multiboard b INNER JOIN membership m ON b.Id=m.id;
SELECT * from boardlist bl inner join multiboard b on bl.BoardName=b.BoardName inner JOIN membership m ON b.Id=m.id WHERE b.boardname='info';

UPDATE multiboard SET visitcount=visitcount+1, CONTENT='업데이트'  WHERE num=16;

COMMIT;

SELECT * FROM shop_basket;
select * from multiboard mb inner join boardlist bl on mb.boardname=bl.boardname;

SELECT * from boardlist WHERE boardname='info';

update multiboard set title='업데이트', content='테스트', attachedfile=null WHERE num=16; 

select * FROM multiboard where boardName='cal';

INSERT INTO multiboard(title, content, id, boardname, date) VALUES('일정2', '일정1', 'kosmo', 'cal','2021-01-04' );

SELECT b.num, id, quantity, total, NAME, price, POINT info, img from shop_basket b inner join shop_products p on b.num=p.num where id='kosmo' LIMIT 1,5;