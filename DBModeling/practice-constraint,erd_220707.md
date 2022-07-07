## 제약조건(PK,FK)실습 - 공지사항



부서   사무실  제목          내용        등록일

\--------------------------------------------------------------------------------------------

전산부  101호  업무 전산화 안건  5월 22일 회의  2007-05-20

기획부  201호  업무 발전 방향    5월 23일 회의  2007-05-20

생산부  301호  생산량 증가 계획  5월 24일 회의  2007-05-22

기술부  407호  생산자재 A/S건   5월 25일 회의  2007-05-23

전산부  101호  여름 휴가 건     5월 22일 회의  2007-05-20

기획부  201호  추석 상여금 안내  5월 23일 회의  2007-05-20

생산부  301호  생산부 잔업 안내  5월 24일 회의  2007-05-22

기술부  407호  새로운 장비 도입  5월 25일 회의  2007-05-23

\---------------------------------------------------------------------------------------------

**Q.**위의 데이터를 표현하기위해 테이블을 2개로 분리후(정규화)

JOIN을 하여 위의 데이터가 출력되도록 쿼리를 작성하세요.

※ '부서', '사무실' 컬럼은 중복됨으로 공지 테이블에서 분리할 필요가 있습니다.

<br>

 **> 작성쿼리**

```mysql
CREATE TABLE dept(
    deptname 	   VARCHAR(10)  NOT NULL, -- 부서명
    room       	   VARCHAR(10) NOT NULL, -- 사무실번호
    PRIMARY KEY (deptname) 
);

CREATE TABLE deptnotice(
	noticeno   int auto_increment, -- 번호			
    title 	   VARCHAR(30)  NOT NULL, -- 제목
    content    VARCHAR(30) NOT NULL, -- 내용
    wdate	   date	NOT NULL, -- 등록일
    deptname   VARCHAR(10)  NOT NULL, -- 부서명
    PRIMARY KEY (noticeno) , 
    FOREIGN KEY (deptname)  REFERENCES dept(deptname)
);

insert into dept(deptname,room) values ('전산부','101호');
insert into dept(deptname,room) values ('기획부','201호');
insert into dept(deptname,room) values ('생산부','301호');
insert into dept(deptname,room) values ('기술부','407호');

select * from dept;
select * from deptnotice;

insert into deptnotice(title,content,wdate,deptname)
values ('업무 전산화 안건','5월22일 회의','2007-05-20','전산부');
insert into deptnotice(title,content,wdate,deptname)
values ('업무 발전 방향','5월23일 회의','2007-05-20','기획부');
insert into deptnotice(title,content,wdate,deptname)
values ('생산량 증가 계획','5월24일 회의','2007-05-22','생산부');
insert into deptnotice(title,content,wdate,deptname)
values ('생산자재A/S건','5월25일 회의','2007-05-23','기술부');
insert into deptnotice(title,content,wdate,deptname)
values ('여름 휴가 건','5월25일 회의','2007-05-23','전산부');
insert into deptnotice(title,content,wdate,deptname)
values ('추석 상여금 안내','5월23일 회의','2007-05-20','기획부');
insert into deptnotice(title,content,wdate,deptname)
values ('생산부 잔업 안내','5월24일 회의','2007-05-22','생산부');
insert into deptnotice(title,content,wdate,deptname)
values ('새로운장비도입','5월25일 회의','2007-05-23','기술부');

select d.deptname, d.room, n.title, n.content, n.wdate
from dept d inner join deptnotice n
on d.deptname = n.deptname
order by n.noticeno;
```

<br>

## E-R다이어그램 실습

**[실습문제]**

교육센터에서는 여러과정을 가르치는데, 각 과정은 코드, 이름 및 수강료를 갖고 있다, 과정들은 1개월, 3개월, 6개월 기간은 다양하다.

왕눈이, 아로미는 우리의 훌륭한 강사들이다. 우리는 각강사의 이름과 , 전화번호를 필요로 한다. 학생들은 시간에 따라 여러개의 과정을 이수할 수 있는데 많은 학생들은 이렇게 하고 있다.

우리는 각 학생들의 이름과 전화번호를 알고 싶다

**[작성답안 및 풀이]**

![image](https://user-images.githubusercontent.com/103404127/177793430-2d2b4249-76d8-4aab-8045-5d9574b3bf5e.png)

![image](https://user-images.githubusercontent.com/103404127/177793639-083ef841-99aa-4b56-98bd-ad44ff700855.png)