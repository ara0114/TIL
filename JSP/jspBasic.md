# JSP 기초문법

- WEB 환경에서 JAVA를 이용한 DBMS 접근을 처리
- Java Logic 처리를 구현
- JAVA를 기반으로 하는 문법
- JSP 고유의 태그가 존재
- JSP의 출력 결과를 HTML과 CSS로 편집해 출력



1.스크립틀릿

`<% ...java코드... %>`

: body 아니고 아무곳이나 써도 됌



2.선언문

`<%! ...java 메소드/멤버변수... %>`

: 특별한 경우만 사용. 권장하지 않음. 쓰지말자 => beans 사용



3.표현식

`<%=변수 %>`

: 세미콜론 사용x, 하나만 출력가능

cf) out.println => 브라우저 출력



4.주석

`<%-- --%>` , `<% //한줄주석 %>` , `<% /* 여러줄 주석 */ %>` 



5.지시자

`<%@ ... %>`

: 클라이언트의 요청에 JSP 페이지가 실행될 때 필요한 정보를 JSP 컨테이너에 알리는 역할,

 3가지 종류 있음(page, include, taglib)



 [1] page 지시자

- jsp페이지에서 지원되는 속성들을 정의

- jsp페이지에서 jsp컨테이너에게 해당 페이지를 어떻게 처리할 것인가에 대한 페이지 정보 알려줌

  - info: 페이지 설명, jsp페이지 제목을 붙이는 것과 같음
  - language: jsp페이지의 스크립트 언어지정, 기본값은 java
  - contentType : jsp 출력형식 지정, 문자셋 지정

  ```jsp
  <%@ page contentType="text/html; charset=utf-8" %>
  <% /* jsp처리결과가 html이므로 MIME Type을 text/html, 문자코드 utf-8 선언
  	MIME Type: 브라우저가 출력하는 데이터의 종류를 나타낸 코드값 */ %>
  ```

  - import : 패키지 import, 중복사용 가능

  ```jsp
  <%@ page import="java.util.*" %>
  <%@ page import="java.text.DecimalFormat" %>
  ```

  - pageEncoding: jsp페이지의 문자셋 형식지정

    

[2] include 지시자

- 여러 jsp페이지에서 공통으로 포함하는 내용이 있을때 매번 입력하지 않고, 파일에 저장후 jsp파일에 포함해서 실행

- 처리 결과가 아닌 파일의 소스가 하나의 파일에 합쳐진 다음 실행

  (액션태그 include는 처리결과를 합함)

- page지시자 동일하게 써줘야함



6.액션태그

- 종류: include, forward, useBean, setProperty, getProperty 등

  - useBean, setProperty, getProperty: 자바빈즈와 통신을 위해 구현한 액션태그

  ```jsp
  <jsp:useBean id="dao" class="bbs.BbsDAO"/>
  <%-- dao 객체 생성--%>
  
  <jsp:setProperty name="dto" property="*"/>
  <%-- request.getParameter(XX)와 dto.setXX(XX) 한번에 --%>
  ```

  - forward: 다른 페이지로 이동할 때 사용, request 객체 유지하다가 최종응답 후 사라짐

  ```jsp
  <jsp:forward page="forwardTag1_2.jsp"></jsp:forward>
  ```

  - include: 다른 페이지를 현재 페이지에 포함시킬수 있는 기능, 지시자와 다르게 처리결과를 포함.

  ```jsp
  <jsp:include page="/menu/top.jsp" flush="false"/>
  
  <%-- flush 속성: 포함될 페이지로 이동할 때 현재 페이지가 지금까지 출력 버퍼에 저장한 결과를 어떻게 처리할 것인가를 결정.
      flush='true'라면 포함할 페이지의 내용을 삽입하기 전 현재 페이지가 지금까지 버퍼에 저장한 내용을 출력 --%>
  ```

  