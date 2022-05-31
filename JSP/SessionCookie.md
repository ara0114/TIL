# Session / Cookie

## 1. Session

- 사용자 브라우저와 서버간의 논리적인 연결

- **서버**가 자신에 접속한 클라이언트의 정보를 갖고 있는 상태

- **상태가 없는 프로토콜**을 이용하면서 상태에 대한 보존을 위해 세션 사용
  - 인터넷은 HTTP프로토콜 사용. HTTP프로토콜을 상태가 없는 프로토콜이라 함.
- 사용자 브라우저와 서버 간의 상태에 대한 보존없이 *매 순간 순간 새로운 연결*을 하고, 요청에 대한 _응답을 서버가 전송하고 나면 모든 연결이 끊어짐_
- 특정한 클라이언트가 서버로 요청을 보낼때 _그 클라이언트의 정보도 포함되어 전송_ , 서버는 그 클라이언트 정보를 가지고 있다가 또 다른 요청이 왔을때 이미 가지고 있던 정보를 비교하여 동일한 브라우저인지를 판단.

<br>

## 2. Cookie

- 세션과 달리 서버에 클라이언트 정보를 담아두지 않고 **클라이언트 자신**들에게 그 정보를 저장

- **접속자의 컴퓨터**에 저장하는 **텍스트파일**로 된 정보

- 4KB까지 저장 가능(작은용량)

- javax.servlet.http.Cookie클래스 이용

  내부객체 아니므로 new로 객체 생성해줘야 함.

<br>

\>writeCookie.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Cookie cookie = null;
	cookie = new Cookie("name","User1");
	cookie.setMaxAge(30);//30초
	response.addCookie(cookie);//요청지(client)에 name이라는 user객체가 저장됌

	cookie = new Cookie("kuk","90");//쿠키 생성자 변수타입 문자열
	cookie.setMaxAge(30);
	response.addCookie(cookie);

	cookie = new Cookie("eng","90");
	cookie.setMaxAge(30);
	response.addCookie(cookie);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/menu/top.jsp"/>
<div class="container">
<div class="well well-lg">
<br>
<p>성적을 쿠키로 저장했습니다.</p>
<p><a href="./readCookie.jsp">쿠키로 저장된 성적 읽어오기</a></p>
</div>
</div>
</body>
</html>
```

\>readCookie.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Cookie[] cookies = request.getCookies(); //내가 저장한 모든 쿠키(name,kuk,eng) 읽어옴
	Cookie cookie = null;

	String name = null;
	int kuk = 0;
	int eng = 0;

	for(int i=0;i<cookies.length;i++){
		cookie = cookies[i];//쿠키 하나씩 가져오기
		if(cookie.getName().equals("name")){//이름으로 저장하기때문에 이름비교
			name = cookie.getValue();//name에 저장된 value값 가져오기
		}else if(cookie.getName().equals("kuk")){
			kuk = Integer.parseInt(cookie.getValue());//kuk에 저장된 value값 받아옴. 문자열이기때문에 정수변환
		}else if(cookie.getName().equals("eng")){
			eng = Integer.parseInt(cookie.getValue());
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/menu/top.jsp"/>
<div class="container">
<div class="well well-lg">
<br>
<%
	if (name != null) { // Cookie 변수가 있다면
		out.println("성명 : " + name + "<br>");
		out.println("국어 : " + kuk + "<br>");
		out.println("영어 : " + eng + "<br>");
		out.println("총점 : " + (kuk + eng) + "<br>");
		out.println("평균 : " + (kuk + eng) / 2 + "<br>");
		out.println("30초 후 쿠키는 인식이 되지 않습니다." + "<br>");

	} else {
		out.println("쿠키를 읽어 들일수 없습니다." + "<br>");//30초후엔 쿠키가 사라지므로 이게 출력됌
	}
%>
</div>
</div>
</body>
</html>
```
