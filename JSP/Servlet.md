# 서블릿

1.서블릿이란

- JSP가 나오기 전 만들어진 웹페이지 생성기술
- Java의 많은 장점들을 사용할 수 있지만 html, css, js등과 연동하기에 많은 단점
- 기업에서 사용하는 프레임워크(ex.스프링부트)의 기초 기술
- WAS에서 웹페이지를 동적으로 생성하여 결과를 전송해주는 __서버 측 프로그램__

<br>

2.서블릿의 라이프 사이클

: 서블릿 요청 -> init(최초 한번 호출) -> service, doGet, doPost(반복 호출) -> destroy(마지막 한번 호출)

```
init() : 서블릿이 처음으로 요청되어 객체가 생성될 때 호출되는 메소드 (최초 한번)
service() : 클라이언트 요청이 있을 때마다 호출되는 메소드 (반복)
destroy() : 서블릿 서비스의 종료 및 재시작 그리고 서블릿 코드가 수정될 때 호출되는 메소드 (마지막 한번)
doGet() : 클라이언트 요청시 form의 method가 get방식일때 호출되는 메소드
doPost() :  클라이언트 요청시 form의 method가 post방식일때 호출되는 메소드
```

<br>

3.서블릿 주요클래스

- `HttpServlet` : 서블릿을 만들기 위해 반드시 상속해야 할 필수 클래스.

  Servlet 인터페이스 > GenericServlet 추상클래스 > HttpServlet 상속구조

```
// 모두 상황 발생시 자동 호출되는 콜백 메소드
- void init() :  서블릿의 객체가 생성될 때 호출되는 메소드(한번)
- void destroy() :  서블릿의 객체가 메모리에서 사라질 때 호출되는 메소드(한번)
- void service(request,response) : 서블릿의 요청이 있을 때 호출되는 메소드(반복)
- void doGet(request,response) : 요청된 form의 메소드가 get일때 호출되는 메소드
- void doPost(request,response) : 요청된 form의 메소드가 post일때 호출되는 메소드
```

- `HttpServletRequest` : 클라이언트가 데이터를 입력하거나 클라이언트의 정보에 대한 요청 값을 가짐. 응답하면 사라짐

```
- String getParameter(name) : name에 할당된 값 반환, 지정된 파라미터 값 없으면 null값 반환(한개일때)
- String[] getParameterValues(name) : name의 모든 값을 String배열로 반환(여러개일때)
- Enumeration getParameterNames() : 요청에 사용된 모든 파라미터 이름 반환
- void setCharacterEncoding(env) : post방식으로 요청된 문자열의 character encoding설정
```

- `HttpServletResponse` : 클라이언트가 요청한 정보를 처리하고 응답을 위한 정보를 담고 있음.

```
- void setHeader(name,value) : 응답에 포함될 Header설정
- void setContentType(type) : 출력되는 페이지의 contentType설정
- String getCharacterEncoding() : 응답페이지의 문자 인코딩 Type반환
- void sendRedirect(url) : 지정된URL로 요청을 재전송
```

- `HttpSession` : 클라이언트가 세션정보를 저장하고 세션기능을 유지하기 위해 제공. 응답후에도 잠시 유지

```
- String getId() : 해당 세션의 세션ID 반환
- long getCreationTime() : 세션의 생성된 시간 반환
- long getLastAccessedTime() : 클라이언트 요청이 마지막으로 시도된 시간 반환
- void setMaxInactiveInterval(time) : 세션을 유지할 시간을 초단위로 설정
- int getMaxInactiveInterval() : setMaxInactiveInterval(time)로 지정된 값 반환. 기본값 30분으로 지정
- boolean isNew() : 클라이언트 세션ID를 할당하지 않은 경우 true값 반환
- void invalidate() : 해당 세션을 종료
```

 <br>

4.서블릿 요청방식

: 브라우저 페이지 간 통신할 수 있는 대표적 방법은 form에서 제공되는 get방식과 post방식이 있음

- get방식 : 검색이나 조건을 다른 페이지로 전송할 때 사용, 요청시 url에 노출되는 특징
- post방식 : 게시판에 글을 입력하거나 또는 회원가입을 하는 기능으로 다른 페이지로 전송할 때 사용,  url에 노출되지 않고 html 헤더 값에 같이 전송, 일반적으로 Insert, Update, Delete 쿼리를 실행할 때 사용