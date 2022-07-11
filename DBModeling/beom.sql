use beom;

drop table if exists category, certification, designer, enroll, hairmenu, notice, reserve, review, style, user;

CREATE TABLE user (
       uid                  varchar(20) NOT NULL, 
       upw                  varchar(20) NOT NULL, 
       uemail               varchar(50) NOT NULL,
       uname                varchar(20) NOT NULL,
       uphone               varchar(20) NOT NULL,
       grade                varchar(5) DEFAULT 'C' NOT NULL
                                   CHECK (grade IN ('A', 'C')),
       PRIMARY KEY (uid),
       UNIQUE (uemail)
);

CREATE TABLE designer (
       did                  varchar(50) NOT NULL,
       dpw                  varchar(10) NOT NULL,
       dname                varchar(20) NOT NULL,
       birth                varchar(6) NOT NULL,
       demail               varchar(50) NOT NULL,
       dphone               varchar(20) NOT NULL,
       address1             varchar(60) NOT NULL,
       address2             varchar(60) NOT NULL,
       dzipcode             varchar(20) NOT NULL,
       validation           boolean DEFAULT false NULL
                                   CHECK (validation IN (false, true)),
       likecnt              int DEFAULT 0 NULL,
       dfilename            varchar(60) NULL,
       PRIMARY KEY (did),
       UNIQUE (demail)
);

CREATE TABLE category (
       cateno               int NOT NULL auto_increment,
       catename             varchar(20) NOT NULL,
       PRIMARY KEY (cateno)
);

CREATE TABLE certification (
       did                  varchar(50) NOT NULL,
       licensetype          varchar(20) NOT NULL,
       licenseno            varchar(50) NULL,
       licensedate          varchar(20) NULL,
       uniquecode1          varchar(50) NULL,
       uniquecode2          varchar(50) NULL,
       PRIMARY KEY (did), 
       FOREIGN KEY (did) REFERENCES designer(did)
);

CREATE TABLE notice (
       noticeno             int NOT NULL auto_increment,
       uid                  varchar(20) NOT NULL,
       ntitle               varchar(30) NOT NULL,
       viewcnt              int DEFAULT 0 NULL,
       ndate                varchar(20) NOT NULL,
       ncontent             text NOT NULL,
       PRIMARY KEY (noticeno), 
       FOREIGN KEY (uid) REFERENCES user(uid)
);

CREATE TABLE style (
		imageno 	int NOT NULL AUTO_INCREMENT, -- 정렬할때 사용
		imagetype 	VARCHAR(30) NOT NULL,      -- 이미지 타입
		imagecode 	LONGBLOB NOT NULL,         -- 이미지 바이너리 코드저장 
		did 		VARCHAR(50) NOT NULL,            -- 업로드한 디자이너 구분
		gender 		VARCHAR(10) DEFAULT '여자' NOT NULL      -- 사진정렬시 여자 남자로 구분
						CHECK(gender IN('여자','남자')),
		PRIMARY KEY (imageno),
		FOREIGN KEY (did) REFERENCES designer(did)
);

CREATE TABLE hairmenu (
       menuno               int NOT NULL auto_increment,
       price                int NOT NULL,
       menu                 varchar(20) NOT NULL,
       did                  varchar(50) NOT NULL,
       cateno               int NOT NULL,
       PRIMARY KEY (menuno), 
       FOREIGN KEY (cateno) REFERENCES category(cateno), 
       FOREIGN KEY (did) REFERENCES designer(did)
);

CREATE TABLE review (
       rno                  int NOT NULL auto_increment,
       rtitle               varchar(20) NOT NULL,
       rcontent             text NOT NULL,
       rdate                varchar(20) NOT NULL,
       star                 int DEFAULT 5 NULL,
       rfilename            varchar(50) NULL,
       uid                  varchar(20) NOT NULL,
       did                  varchar(50) NOT NULL,
       PRIMARY KEY (rno), 
       FOREIGN KEY (did) REFERENCES designer(did), 
       FOREIGN KEY (uid) REFERENCES user(uid)
);

CREATE TABLE enroll (
       enrollno             int NOT NULL auto_increment,
       enrolldate           varchar(20) NOT NULL,
       enrolltime           varchar(20) NOT NULL,
       menuno               int NOT NULL,
       did                  varchar(50) NOT NULL,
       PRIMARY KEY (enrollno), 
       FOREIGN KEY (menuno) REFERENCES hairmenu(menuno), 
       FOREIGN KEY (did) REFERENCES designer(did)
);

CREATE TABLE reserve (
       reserveno            int NOT NULL auto_increment,
       uid                  varchar(20) NOT NULL,
       message              varCHAR(100) NULL,
       enrollno             int NOT NULL,
       PRIMARY KEY (reserveno), 
       FOREIGN KEY (enrollno) REFERENCES enroll(enrollno), 
       FOREIGN KEY (uid) REFERENCES user(uid)
);


#---------------------------------------------------------------------------------------
SELECT * FROM user;
SELECT COUNT(uid) FROM user WHERE uid='user2'; -- 중복아이디검사
SELECT COUNT(uemail) FROM user WHERE uid='user2';

INSERT INTO user(uid,upw,uemail,uname,uphone,grade) VALUES('admin','1234','admin@email.com','관리자','010-1111-1111','A');
INSERT INTO user(uid,upw,uemail,uname,uphone,grade) VALUES('user1','1234','user1@email.com','사용자1','010-1234-1234','C');
INSERT INTO user(uid,upw,uemail,uname,uphone,grade) VALUES('user2','1234','user2@email.com','사용자2','010-3333-3333','C');
INSERT INTO user(uid,upw,uemail,uname,uphone,grade) VALUES('user3','1234','user3@email.com','사용자3','010-4444-4444','C');
INSERT INTO user(uid,upw,uemail,uname,uphone,grade) VALUES('user4','1234','user4@email.com','사용자4','010-5555-5555','C');

UPDATE user SET uphone='010-1234-5678' WHERE uid='user1';

DELETE FROM user WHERE uid='user4';
#---------------------------------------------------------------------------------------
SELECT * FROM designer;
SELECT * FROM designer WHERE address1 like '%강남구%';

INSERT INTO designer(did,dpw,dname,birth,demail,dphone,address1,address2,dzipcode)
VALUES('de1','1111','디자이너1','000101','hair@email.com','010-0000-0000','서울시 강남구','123-1','12345');
INSERT INTO designer(did,dpw,dname,birth,demail,dphone,address1,address2,dzipcode)
VALUES('de2','1111','디자이너2','960101','hair2@email.com','010-9999-9999','서울시 종로구','1131-1','33333');
INSERT INTO designer(did,dpw,dname,birth,demail,dphone,address1,address2,dzipcode)
VALUES('de3','1111','디자이너3','980101','hair3@email.com','010-7777-7777','서울시 동작구','4673-1','36456');

UPDATE designer SET validation=true WHERE did='de1';

DELETE FROM designer WHERE did='de3';
#---------------------------------------------------------------------------------------
SELECT * FROM category;
INSERT INTO category(catename) VALUES('컷');
INSERT INTO category(catename) VALUES('펌');
INSERT INTO category(catename) VALUES('클리닉');
#---------------------------------------------------------------------------------------
SELECT * FROM certification;
SELECT * FROM certification WHERE licensetype like '수첩형%';

INSERT INTO certification(did,licensetype,licenseno,licensedate,uniquecode1)
VALUES('de1','수첩형 자격증','123456789A','20140101','1408234456');
INSERT INTO certification(did,licensetype,uniquecode2)
VALUES('de2','상장형 자격증','234131245');
INSERT INTO certification(did,licensetype,licenseno,licensedate,uniquecode1)
VALUES('de3','수첩형 자격증','346673348A','20100101','1335408456');
#---------------------------------------------------------------------------------------
SELECT * FROM notice;
INSERT INTO notice(uid,ntitle,ndate,ncontent) VALUES('admin','공지사항',sysdate(),'공지사항입니다');
INSERT INTO notice(uid,ntitle,ndate,ncontent) VALUES('admin','사이트이용안내',sysdate(),'사이트이용안내입니다');
#---------------------------------------------------------------------------------------
SELECT * FROM style WHERE did='de1';
INSERT INTO style(imagetype,imagecode,did,gender) VALUES('jpg','12fgs34622344t','de1','여자');
INSERT INTO style(imagetype,imagecode,did,gender) VALUES('jpg','0142%@%^1353df','de1','남자');
INSERT INTO style(imagetype,imagecode,did,gender) VALUES('jpg','426573$622344t','de2','남자');
#---------------------------------------------------------------------------------------
SELECT * FROM hairmenu order by price;
INSERT INTO hairmenu(price,menu,did,cateno) VALUES(13000,'남성 컷','de1',1);
INSERT INTO hairmenu(price,menu,did,cateno) VALUES(15000,'여성 컷','de1',1);
INSERT INTO hairmenu(price,menu,did,cateno) VALUES(80000,'세팅펌','de1',2);
INSERT INTO hairmenu(price,menu,did,cateno) VALUES(50000,'디지털펌','de1',2);
#---------------------------------------------------------------------------------------
SELECT * FROM review;
INSERT INTO review(rtitle,rcontent,rdate,uid,did) VALUES('최고에요','마음에 듭니다.',sysdate(),'user1','de1');
INSERT INTO review(rtitle,rcontent,rdate,rfilename,uid,did) VALUES('최고에요','만족스러워요!.',sysdate(),'photo1.jpg','user1','de1');
INSERT INTO review(rtitle,rcontent,rdate,uid,did) VALUES('최고에요','자연스러워요',sysdate(),'user2','de1');
#---------------------------------------------------------------------------------------
SELECT * FROM enroll;
INSERT INTO enroll(enrolldate,enrolltime,menuno,did) VALUES('2022-07-10','17:00','1','de1');
INSERT INTO enroll(enrolldate,enrolltime,menuno,did) VALUES('2022-07-10','19:00','3','de1');
#---------------------------------------------------------------------------------------
SELECT * FROM reserve;
INSERT INTO reserve(enrollno,uid,message) VALUES('1','user1','10분내로갑니다');
INSERT INTO reserve(enrollno,uid,message) VALUES('2','user1','머리가얇아요');
#---------------------------------------------------------------------------------------
SELECT c.did, d.dname, d.birth, c.licensetype, c.licenseno, c.licensedate, c.uniquecode1
FROM designer d inner join certification c
on d.did = c.did and c.licensetype like '수첩형%';

SELECT d.dname, c.catename, h.menu, h.price
FROM designer d left join hairmenu h 
on d.did = h.did left join category c
on h.cateno = c.cateno;

SELECT d.dname, e.enrolldate, e.enrolltime, h.menu, h.price
FROM designer d left join enroll e
on d.did = e.did left join hairmenu h
on d.did = h.did;

