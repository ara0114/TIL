## EL(표현언어, Expression Language)

- JSP 객체의 출력을 단순화 하는 용도
- `${expr}`
- `${ }` 은 기본적으로 request 영역에서 먼저 찾는다.
- 값이 없는 경우 null값 출력x
- set-> get 하지않고 바로 읽어올 수 있음
- mvc2에서 효과적으로 사용가능

[1] JSP 내부객체에 대한 EL 객체

 \- **requestScope** : request 영역에 포함된 객체	
 \- **sessionScope**  : session 영역에 포함된 객체 
 \- **param**        	   : HTTP의 파라미터들 
 \- pageContext     : PageContext 객체 
 \- pageScope        : page 영역에 포함된 객체 
 \- applicationScope : application 영역에 포함된 객체 
 \- paramValues   : 하나의 파라미터 값들 
 \- header        	  : 헤더 정보들 
 \- headerValues  : 하나의 헤더 값들 
 \- cookie        : 쿠키들 
 \- initParam      : 컨텐츠의 초기화 파라미터들 

[2] EL 객체의 사용예 

 \- ${pageContext.request.requestURI} : request URI 

 \- ${sessionScope.profile} : session 영역에서 profile이라는 이름으로 저장된 객체 

 \- ${param.productId}  : productId라는 이름의 파라미터 값 

 \- ${paramValues.productId} : productId라는 이름의 파라미터 값들 

 \- ${pageContext.request.contextPath} : Context Path 추출  

​	=> 얘 요즘은 많이 안쓴다 . 스프링부트에서 /로 루트인식되어 경로 많이 줄어든다. 코드 간결.

---

EL에서 클래스 메소드 사용하려면 클래스 메소드를 static으로 정의해야함

클래스 파일을 작성했다면 TLD파일을 작성해야핳

TLD파일 : Tag Library Descriptor, 태그라이브러리에 대한 설정정보

```XML
<?xml version="1.0" encoding="UTF-8" ?> 
<taglib xmlns="http://java.sun.com/xml/ns/j2ee" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
   	xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee 
                 web-jsptaglibrary_2_0.xsd" 
  	version="2.0"> 
     
<description>EL에서 함수실행</description> 
<tlib-version>1.0</tlib-version> 
<uri>/ELFunctions</uri>
<function> <!-- EL에서 사용할 함수 정의 -->
	<description>Date 객체를 포맷팅하여 출력</description> 
	<name>dateFormat</name>  <!-- 태그명으로 사용할꺼다. EL에서 사용할 함수의 이름 -->
    <function-class>                   
    com.study.jstl.DateUtil  <!-- 이런 클래스 갖고있다. EL이 사용할 함수 기능을 제공할 클래스의 이름 -->
    </function-class> 
    <function-signature>    
    java.lang.String format( java.util.Date )<!-- 함수의 리턴타입,매개변수타입/클래스 타입인 경우 패키지명도 써야함-->
    </function-signature> 
</function>
```

## JSTL(사용자 정의 태그, JSP Standard Tag Library)

- EL을 사용
- 많이 사용되는 사용자 정의 태그를 모아 JSTL 규약 생성
- 스클립틀릿, 표현식 보다 훨씬 간결한 문법구조 지원
- EL은 라이브러리 필요없지만 JSTL은 라이브러리 필요
- JSTL은 5가지 태그지원

|   라이브러리   |                기능                 | 접두어 |                관련URI                 |
| :------------: | :---------------------------------: | :----: | :------------------------------------: |
| **코어**(Core) |     변수지원, 흐름제어, URL처리     |   c    |   http://java.sun.com/jsp/jstl/core    |
|    **함수**    |      콜렉션 처리, String 처리       |   fn   | http://java.sun.com/jsp/jstl/functions |
|      XML       |     xml 코어, 흐름제어, xml변환     |   x    |    http://java.sun.com/jsp/jstl/xml    |
|     국제화     | 지역 메시지 형식, 숫자 및 날짜 형식 |  fmt   |    http://java.sun.com/jsp/jstl/fmt    |
|  데이터베이스  |                 SQL                 |  sql   |    http://java.sun.com/jsp/jstl/sql    |

[1] Core Tag 

★★★★★흐름 제어

```
if			: 조건에 따라 내부 코드를 수행
choose		: 다중 조건을 처리할 때 사용
forEach		: Collection의 각 항목을 처리할 때 사용
forTokens	: 구분자로 분리된 각각의 토큰을 처리할 때 사용
```

★★★변수 지원  	

```
set			: jsp에서 사용될 변수를 설정 
remove		: 설정한 변수를 제거 
```

URL 처리

```
import		: URL을 사용하여 다른 자원의 결과를 삽입, include와 같음
redirect	: 지정한 경로로 이동
url			: URL을 재 작성
```

기타 태그 

```
catch		: 예외 처리에 사용
out			: jspWriter에 내용을 알맞게 처리한 후 출력
```

---

\> ex

```html
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- JSTL 사용 라이브러리 선언 --%>

<c:set var="num1" value="${20}"/> 	 <%-- set:변수선언 --%>

<c:remove var="num1" scope="page"/>  <%-- remove:설정변수제거, scope:여기에서만 사용가능 default값 (현재)페이지--%>

<c:set target="${map}" property="name" value="왕눈이"/>
<%-- target: set으로 만들어진 변수(타겟)찾아 키(property)가 name이고 값(value)을 왕눈이로 담겟다 --%>

<c:forEach var="i" begin="1" end="100" step="2">
<%-- for문, step: 2씩 띄워서...1,3,5,7,9,..default값은 1 --%>
```

\> 함수태그

```
substringAfter(str1,str2)  : str1에서 str2뒤에 있는거 추출
substringBefore(str1,str2) : str1에서 str2앞에 있는거 추출
trim : 앞뒤 공백 없앰(가운데 공백은 x)
indexOf(str1,str2) : str1에서 str2의 위치값
startsWith(str1,str2) : str1이 str2로 시작하는지
endsWith(str1,str2) : str1이 str2로 끝나는지(공백도 같이봄)
containsIgnoreCase : 대소문자상관없이 문자열 포함여부
escapeXml : 쓰면 태그인식가능
```

