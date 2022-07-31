use beom;

drop table if exists category, certification, designer, enroll, hairmenu, notice, reserve, review, style, user;

CREATE TABLE user ( #회원
       uid                  varchar(20) NOT NULL, -- 아이디
       upw                  varchar(20) NOT NULL, -- 패스워드
       uemail               varchar(50) NOT NULL, -- 이메일
       uname                varchar(20) NOT NULL, -- 이름
       uphone               varchar(20) NOT NULL, -- 전화번호
       grade                varchar(5) DEFAULT 'C' NOT NULL
                                   CHECK (grade IN ('A', 'C')), -- 등급(관리자A,고객C)
       PRIMARY KEY (uid),
       UNIQUE (uemail)
);

CREATE TABLE designer ( #디자이너
       did                  varchar(50) NOT NULL, -- 아이디
       dpw                  varchar(10) NOT NULL, -- 패스워드
       dname                varchar(20) NOT NULL, -- 이름
       birth                varchar(6) NOT NULL, -- 생년월일
       demail               varchar(50) NOT NULL, -- 이메일
       dphone               varchar(20) NOT NULL, -- 전화번호
       address1             varchar(60) NOT NULL, -- 주소
       address2             varchar(60) NOT NULL, -- 상세주소
       dzipcode             varchar(20) NOT NULL, -- 우편번호
       validation           boolean DEFAULT false NULL
                                   CHECK (validation IN (false, true)), -- 자격승인여부
       likecnt              int DEFAULT 0 NULL, -- 좋아요개수
       dfilename            varchar(60) NULL default 'default.jpg', -- 디자이너 파일명
       introduction         varchar(200) NULL, -- 자기소개
       hairshop				varchar(20) NOT NULL, -- 헤어샵
       PRIMARY KEY (did),
       UNIQUE (demail)
);

CREATE TABLE category ( #카테고리
       cateno               int NOT NULL auto_increment, -- 분류번호
       catename             varchar(20) NOT NULL, -- 분류명
       PRIMARY KEY (cateno)
);

CREATE TABLE certification ( #자격증
       did                  varchar(50) NOT NULL, -- 디자이너아이디
       licenseno            varchar(50) NULL, -- 자격증번호
       licensedate          varchar(20) NULL, -- 자격증발급년월일
       uniquecode1          varchar(50) NULL, -- 자격증내지번호
       uniquecode2          varchar(50) NULL, -- 자격증관리번호
       PRIMARY KEY (did), 
       FOREIGN KEY (did) REFERENCES designer(did) on delete cascade
);

CREATE TABLE notice ( #공지사항
       noticeno             int NOT NULL auto_increment, -- 공지번호
       uid                  varchar(20) NOT NULL, -- 작성자아이디
       ntitle               varchar(30) NOT NULL, -- 제목
       viewcnt              int DEFAULT 0 NULL, -- 조회수
       ndate                varchar(20) NOT NULL, -- 작성날짜
       ncontent             text NOT NULL, -- 내용
       PRIMARY KEY (noticeno), 
       FOREIGN KEY (uid) REFERENCES user(uid) on delete cascade
);

CREATE TABLE style ( #스타일
		imageno 	int NOT NULL AUTO_INCREMENT, -- 사진번호(정렬할때 사용)
		imagetype 	VARCHAR(30) NOT NULL,      -- 이미지 타입
		imagecode 	LONGBLOB NOT NULL,         -- 이미지 바이너리 코드저장 
		did 		VARCHAR(50) NOT NULL,            -- 디자이너아이디(업로드한 디자이너 구분)
		gender 		VARCHAR(10) DEFAULT 'FEMALE' NOT NULL   -- 성별(사진정렬시 여자 남자로 구분)
						CHECK(gender IN('FEMALE','MALE')),
		PRIMARY KEY (imageno),
		FOREIGN KEY (did) REFERENCES designer(did) on delete cascade
);

CREATE TABLE hairmenu ( #헤어메뉴
       menuno               int NOT NULL auto_increment, -- 메뉴번호
       price                int NOT NULL, -- 가격
       menu                 varchar(20) NOT NULL, -- 메뉴명
       did                  varchar(50) NOT NULL, -- 디자이너아이디
       cateno               int NOT NULL, -- 카테고리분류번호
       hgender 				VARCHAR(10) DEFAULT 'FEMALE' NOT NULL
								CHECK(hgender IN('FEMALE','MALE')), -- 성별
       PRIMARY KEY (menuno), 
       FOREIGN KEY (cateno) REFERENCES category(cateno), 
       FOREIGN KEY (did) REFERENCES designer(did) on delete cascade
);

CREATE TABLE review ( #리뷰
       rno                  int NOT NULL auto_increment, -- 리뷰번호
       rtitle               varchar(20) NOT NULL, -- 제목
       rcontent             varchar(200) NOT NULL, -- 내용
       rdate                varchar(20) NOT NULL, -- 작성날짜
       star                 int DEFAULT 5 NOT NULL, -- 별점
       rfilename            varchar(50) NULL, -- 리뷰 파일명
       uid                  varchar(20) NOT NULL, -- 회원 아이디
       did                  varchar(50) NOT NULL, -- 디자이너 아이디
       PRIMARY KEY (rno), 
       FOREIGN KEY (did) REFERENCES designer(did) on delete cascade, 
       FOREIGN KEY (uid) REFERENCES user(uid) on delete cascade
);

CREATE TABLE enroll ( #디자이너예약등록
       enrollno             int NOT NULL auto_increment, -- 예약등록번호
       enrolldate           varchar(20) NOT NULL, -- 등록날짜
       enrolltime           varchar(20) NOT NULL, -- 등록시간
       eprice				int NOT NULL, -- 메뉴가격
       emenu				varchar(20) NOT NULL, -- 메뉴명
       menuno               int NOT NULL, -- 메뉴번호
       did                  varchar(50) NOT NULL, -- 디자이너 아이디
       PRIMARY KEY (enrollno), 
       FOREIGN KEY (menuno) REFERENCES hairmenu(menuno), 
       FOREIGN KEY (did) REFERENCES designer(did) on delete cascade
);

CREATE TABLE reserve ( #고객예약신청
       reserveno            int NOT NULL auto_increment, -- 예약번호
       uid                  varchar(20) NOT NULL, -- 회원아이디
       message              varCHAR(100) NULL, -- 요청사항
       enrollno             int NOT NULL, -- 예약등록번호
       rconfig 				boolean default false CHECK(rconfig IN(false,true)),
       PRIMARY KEY (reserveno), 
       FOREIGN KEY (enrollno) REFERENCES enroll(enrollno), 
       FOREIGN KEY (uid) REFERENCES user(uid) on delete cascade
);


#---------------------------------------------------------------------------------------
SELECT * FROM user;
SELECT COUNT(uid) FROM user WHERE uid='user1'; -- 중복아이디검사
SELECT COUNT(uemail) FROM user WHERE ueamil='user1@email.com'; -- 중복이메일검사
SELECT COUNT(*) FROM user WHERE uid='user1' and upw='1234'; -- 로그인
SELECT grade, uname FROM user WHERE uid='admin'; -- 등급확인
SELECT uid FROM user WHERE uname='사용자1' and uemail='user1@email.com'; -- 아이디찾기
SELECT upw FROM user WHERE uid='user1' and uemail='user1@email.com'; -- 비밀번호찾기 
SELECT * FROM user WHERE uid='user1'; -- 정보조회

INSERT INTO user(uid,upw,uemail,uname,uphone,grade) VALUES('admin','1234','admin@email.com','관리자','010-1111-1111','A');
INSERT INTO user(uid,upw,uemail,uname,uphone,grade) VALUES('user1','1234','user1@email.com','사용자1','010-1234-1234','C');
INSERT INTO user(uid,upw,uemail,uname,uphone,grade) VALUES('user2','1234','user2@email.com','사용자2','010-3333-3333','C');
INSERT INTO user(uid,upw,uemail,uname,uphone,grade) VALUES('user3','1234','user3@email.com','사용자3','010-4444-4444','C');


UPDATE user SET uphone='012-1234-1234' WHERE uid='user1'; -- 정보수정

DELETE FROM user WHERE uid='user4';
#---------------------------------------------------------------------------------------
SELECT * FROM designer;
SELECT * FROM designer WHERE address1 like '%강남구%';

INSERT INTO designer(did,dpw,dname,birth,demail,dphone,address1,address2,dzipcode,introduction,hairshop)
VALUES('des1','1111','김지윤','000101','hair@email.com','010-0000-0000','서울시 강남구','123-1','12345','안녕하세요~','바니스헤어');
INSERT INTO designer(did,dpw,dname,birth,demail,dphone,address1,address2,dzipcode,introduction,hairshop)
VALUES('des2','1111','김다은','960101','hair2@email.com','010-9999-9999','서울시 종로구','1131-1','33333','안녕하세요! 22헤어 블리입니다','22헤어');
INSERT INTO designer(did,dpw,dname,birth,demail,dphone,address1,address2,dzipcode,introduction,hairshop)
VALUES('des3','1111','정은지','980101','hair3@email.com','010-7777-7777','서울시 동작구','4673-1','36456','안녕하세요!은지입니다','라라헤어');
INSERT INTO designer(did,dpw,dname,birth,demail,dphone,address1,address2,dzipcode,introduction,hairshop)
VALUES('des4','1111','이소미','950101','hair4@email.com','010-5555-7777','경기 성남시','442-1','66622','개인디자이너','-');
INSERT INTO designer(did,dpw,dname,birth,demail,dphone,address1,address2,dzipcode,introduction,hairshop)
VALUES('des5','1111','이유아','020101','hair5@email.com','010-1111-7777','강원도 춘천시','5576-1','22222','안녕하세요>_<','화이트미용실');
UPDATE designer SET validation=0 WHERE did='des5';
UPDATE designer SET demail='vanjea@naver.com' WHERE did='des1';
update designer set address1='경기 성남시' where did = 'des4';
DELETE FROM designer WHERE did='des3';
#---------------------------------------------------------------------------------------
SELECT * FROM category;
INSERT INTO category(catename) VALUES('컷');
INSERT INTO category(catename) VALUES('펌');
INSERT INTO category(catename) VALUES('염색');
INSERT INTO category(catename) VALUES('드라이');
INSERT INTO category(catename) VALUES('클리닉');
#---------------------------------------------------------------------------------------
SELECT * FROM certification;

SELECT * FROM certification WHERE licenseno is not null;
INSERT INTO certification(did,licenseno,licensedate,uniquecode1)
VALUES('des1','123456789A','20140101','1408234456');
INSERT INTO certification(did,uniquecode2)
VALUES('des2','234131245');
INSERT INTO certification(did,licenseno,licensedate,uniquecode1)
VALUES('des3','346673348A','20100101','1335408456');
INSERT INTO certification(did,uniquecode2)
VALUES('des4','544524123');
INSERT INTO certification(did,licenseno,licensedate,uniquecode1)
VALUES('des5','237944348A','20170822','1331453456');
#---------------------------------------------------------------------------------------
SELECT * FROM notice;
INSERT INTO notice(uid,ntitle,ndate,ncontent) VALUES('admin','공지사항',sysdate(),'공지사항입니다');
INSERT INTO notice(uid,ntitle,ndate,ncontent) VALUES('admin','사이트이용안내',sysdate(),'사이트이용안내입니다');
#---------------------------------------------------------------------------------------
SELECT * FROM style WHERE did='des1';
INSERT INTO style(imagetype,imagecode,did,gender) VALUES('jpg','12fgs34622344t','des1','FEMALE');
INSERT INTO style(imagetype,imagecode,did,gender) VALUES('jpg','0142%@%^1353df','des1','MALE');
INSERT INTO style(imagetype,imagecode,did,gender) VALUES('jpg','426573$622344t','des2','MALE');
#---------------------------------------------------------------------------------------
SELECT * FROM hairmenu where did='designer3';
# order by price;
INSERT INTO hairmenu(price,menu,did,cateno,hgender) VALUES(23000,'두피스켈링커트','des1',1,'MALE');
INSERT INTO hairmenu(price,menu,did,cateno,hgender) VALUES(15000,'남성커트','des1',1,'MALE');
INSERT INTO hairmenu(price,menu,did,cateno,hgender) VALUES(50000,'남성펌','des1',2,'MALE');
INSERT INTO hairmenu(price,menu,did,cateno,hgender) VALUES(30000,'남성새치커버','des1',3,'MALE');

INSERT INTO hairmenu(price,menu,did,cateno,hgender) VALUES(13000,'남성 컷','des2',1,'MALE');
INSERT INTO hairmenu(price,menu,did,cateno,hgender) VALUES(15000,'여성 컷','des2',1,'FEMALE');
INSERT INTO hairmenu(price,menu,did,cateno,hgender) VALUES(80000,'세팅펌','des2',2,'FEMALE');
INSERT INTO hairmenu(price,menu,did,cateno,hgender) VALUES(50000,'디지털펌','des2',2,'FEMALE');

#---------------------------------------------------------------------------------------
SELECT * FROM review;
INSERT INTO review(rtitle,rcontent,rdate,uid,did) VALUES('최고에요','마음에 듭니다.',sysdate(),'user1','des1');
INSERT INTO review(rtitle,rcontent,rdate,rfilename,uid,did) VALUES('최고에요','만족스러워요!.',sysdate(),'photo1.jpg','user1','des1');
INSERT INTO review(rtitle,rcontent,rdate,uid,did) VALUES('최고에요','자연스러워요',sysdate(),'user2','des1');
#---------------------------------------------------------------------------------------
SELECT * FROM enroll;# where did='designer3';

INSERT INTO enroll(did, menuno, enrolldate, enrolltime, eprice, emenu) VALUES('des1',1,'2022-07-31','17:00',23000,'두피스켈링컷');
INSERT INTO enroll(did, menuno, enrolldate, enrolltime, eprice, emenu) VALUES('des1',1,'2022-07-31','19:00',15000,'남성커트');
INSERT INTO enroll(did, menuno, enrolldate, enrolltime, eprice, emenu) VALUES('des1',2,'2022-07-31','21:00',23000,'남성펌');
INSERT INTO enroll(did, menuno, enrolldate, enrolltime, eprice, emenu) VALUES('des1',1,'2022-08-01','13:00',13000,'남성커트');
INSERT INTO enroll(did, menuno, enrolldate, enrolltime, eprice, emenu) VALUES('des1',1,'2022-08-01','19:00',80000,'세팅펌');
INSERT INTO enroll(did, menuno, enrolldate, enrolltime, eprice, emenu) VALUES('des1',2,'2022-08-01','19:00',50000,'디지털펌');

SELECT e.enrolldate, e.enrolltime, e.menuno, h.menuno, c.catename, h.menu, h.price,  h.hgender, e.did
FROM enroll e left join hairmenu h on e.menuno = h.menuno
left join category c on h.cateno = c.cateno where e.did = 'designer3' order by e.menuno asc;
#---------------------------------------------------------------------------------------
SELECT * FROM reserve;
INSERT INTO reserve(enrollno,uid,message) VALUES('1','user1','10분내로갑니다');
INSERT INTO reserve(enrollno,uid,message) VALUES('2','user1','머리가얇아요');
#---------------------------------------------------------------------------------------
SELECT c.did, d.dname, d.birth, c.licenseno, c.licensedate, c.uniquecode1
FROM designer d inner join certification c
on d.did = c.did and c.licenseno is not null;

SELECT d.dname, c.catename, h.menu, h.price
FROM designer d left join hairmenu h 
on d.did = h.did left join category c
on h.cateno = c.cateno;

SELECT d.dname, e.enrolldate, e.enrolltime, h.menu, h.price
FROM designer d left join enroll e
on d.did = e.did left join hairmenu h
on d.did = h.did;

