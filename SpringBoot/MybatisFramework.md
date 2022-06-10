# Mybatis 프레임워크

## 특징

- 한두줄의 자바코드로 DB연동을 처리 => 코드 길이 줄어듬
- SQL명령어를 자바코드에서 분리해 XML파일에 따로 관리

- 이식성 좋음, 어떤 프로그래밍 언어로도 구현 가능
- 오픈소스, 무료

## Component Flow

- Mybatis Framework가 Business Layer(Persistance Layer + Service Layer)와 DB Layer 사이에서 양쪽을 연결하고 있음
- 하단 mapper.xml파일을 이용하여 쿼리문을 별도로 작성

![image](https://user-images.githubusercontent.com/103404127/173071717-9262cf73-b129-4aec-9467-fc9c902f36f5.png)

## 구성요소

[1] Configuration파일(SqlMapConfig.xml) => **설정** xml

- Mybatis 메인 환경설정
- DB설정 및  mapper설정 등
- DB설정은 별도의 properties 파일로 분리할 수 있음
- mapper는 SQL 쿼리를 xml문서로 분리한 것

[2] Mapper

- 두가지 종류의 매퍼를 정의할 수 있음
  - SQL을 xml파일로 생성
  - SQL을 메소드에 어노테이션으로 정의한 인터페이스로 생성

[3] Mapped Statements

- SQL을 DB에 실행할 쿼리를 의미
- 매핑구문은 어노테이션 정의 방법과 XML정의 방식 두가지가 있음

[4] Mybatis Java API

- SqlSession은 Mapper xml에 등록된 SQL쿼리를 실행
- SqlSession 객체는 SQL쿼리를 실행하기 위한 여러가지 메소드를 제공
  - selectOne(), selectList(), insert(), update(), delete()...

---

## Mapper XML 파일구조

- Mybatis프레임워크에서 가장 중요한 파일
- SQL문장을 가지고 있음
- Mapper XML 또는 \<mapper>루트 엘리먼트를 가지는 XML파일
- DTD선언이 등장하고 그 밑에 \<mapper> 루트 엘리먼트가 선언 

- \<mapper>엘리먼트는 namespace라는 속성을 가짐

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="bbs"> 
                 :
</mapper>
```

1. select

```
<select id="read" parameterType="int" resultType="Map">
	...               
</select>
```

- id 속성

  - 필수속성, 전체 Mapper파일내에서 유일한 아이디 등록
  - \<mapper namespace="">에서 namespace값이 다르면 같은 id도 다른 id로 인식됌

  ```
  <mapper namespace="bbs"> 
      <select id=”selectPerson” >...</select>
  </mapper>
   <mapper namespace="member"> 
      <select id=”selectPerson” >...</select>
  </mapper>
  ```

- parameterType 속성
  - 외부로부터 데이터 받아올때 사용하는 속성,
  - 받아오는 데이터의 타입 명시
- resultType 속성
  - 주로 select 구문, DBMS로부터 결과를 받아올때 사용
  - 결과값 매핑할 자바 객체 타입 명시
  - **select** 구문에서 **생략할수 없는 속성**

2. insert, update, delete

- 데이터의 삽입, 수정, 삭제를 위한 구문
- insert의 selectKey는 기본키 필드의 자동생성 지원
- \<selectKey>를 사용하면 생성된 키를 쉽게 가져올 수 있음. 내가 가져온(만든)값 바로 써야할때

3. resultMap 속성

- 결과를 매핑할때 하나의 자바 객체로 매핑이 안되는 경우 사용(ex. join)
- 테이블 컬럼명과 매피할 자바객체의 필드명이 다를때도 사용

```
<resultMap id="selectResult" type="board">
     <result property="num" column = 'seq'>
     <result property="title" column = 'subject'>
     <result property="content" column = 'content'>
     <result property="redate" column = 'redate'>
</resultMap>
<select id=”selectBoard” parameterType=”int” resultMap=”selectResult”>
    SELECT * FROM board WHERE num = #{num}
</select>
```

4. CDATA Section 사용

- SQL구문에 `<` 를 사용하면 에러남. (파서가 xml처리시 `<`를 태그시작으로 처리하기때문)
- CDATA Section으로 사용하면 에러X, 파서가 처리하지 않는 영역(단순 문자 데이터로 인식)

```
<select id=”selectBoard” parameterType=”int” resultType=”board”>
    SELECT *
    FROM board
   <![CDATA[
    WHERE num <= #{num}
    ]]>
</select>
```

5. 동적SQL

- if

```
<if test="조건"></if>
```

- choose, when, otherwise

```
choose를 사용해야 when, otherwise 사용할 수 있음
when은 if/else if와 같은 의미 여러개 사용가능, otherwise는 else와 같은 의미 한개 사용가능

<choose>
	<when test="col=='wname'">
			...
	</when>
	<when test="col=='title'">
			...
	</when>
	<when test="col=='content'">
			...
	</when>
	<when test="col=='title_content'">
			...
	</when>
	<ohterwise>
			...
	</otherwise>
</choose>
```

- where

```
단순히 where을 추가
and나 or로 시작한다면 지워버림

<where>
   <if test=”state != null”>
      state = #{state}        --- #1
   </if>
   <if test=”title != null”>
      AND title like #{title} --- #2
   </if>
   <if test=”author != null and author.name != null”>
       AND author_name like #{author.name} --- #3
   </if>
</where>

#1 안되고 #2 되면 #2에서 AND 자동으로 지워버짐, #3 도 마찬가지
```

- set

```
칼럼을 동적으로 포함시키기 위해 사용
동적으로 SET키워드를 붙히고 필요없는 콤마 제거

update Author
  <set>
     <if test="username != null">username=#{username},</if>
     <if test="password != null">password=#{password},</if>
     <if test="email != null">email=#{email},</if>
     <if test="bio != null">bio=#{bio}</if>
  </set>
  where id=#{id}
```

- foreach

  - collection에 대해 반복처리. 종종 in조건을 사용

  | 구분       | 설명                                                       |
  | ---------- | ---------------------------------------------------------- |
  | collection | 전달받은 인자값                                            |
  | item       | 전달받은 인자값을 다른 이름으로 대체                       |
  | open       | 해당 구문이 시작할때                                       |
  | close      | 해당 구문이 끝날때                                         |
  | index      | 항목의 인덱스 값을 꺼낼때 사용할 변수 이름을 지정          |
  | separator  | 구분자, 한번 이상 반복할때 반복되는 사이에 해당문을 넣어줌 |

```
<select id="selectPostIn" resultType="domain.blog.Post">
	...
    <foreach item="item" index="index" collection="list"
        open="(" separator="," close=")">
                #{item}
    </foreach>
</select>
```

