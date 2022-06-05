# Ajax(Asynchronous JavaScript and XML)

## Ajax의 이해

- 비동기 자바스크립트와 XML기반 스크립트
  - 동기: 요청 후 응답올때 까지 기다림(지연..하얀화면)
  - 비동기: 요청 후 응답오지 않더라도 뭔가 하고있음. 응답올땐 action이나 event발생시켜 알려줌
- 2005년 google이 제안하고 만듦
- 동적이고 민첩한 Web page를 생성하기 위한 기술
- 사용 예: Google maps, Google search, Gmail, Youtube, Facebook

## Ajax의 주요 구성요소

- XMLHttpRequest : 웹서버와 통신 담당, 비동기통신을 하기위한 js객체

  사용자의 요청을 웹서버에 전송하고 웹서버로부터 받은 결과를 웹 브라우저에 전달,

  XMLHttpRequest외에도 Promise객체와 Async, Await등을 이용해 Ajax통신을 간편하게 할 수 있음

- DOM : 문서의 구조를 나타냄. 폼등의 정보나 화면 구성을 조작할 때 사용

- CSS : 글자색, 배경색, 위치, 투명도 등 UI와 관련된 부분을 담당
- JavaScript : 사용자가 마우스를 드래그하거나 버튼 클릭을 하면 `XMLHttpRequest`, `Promise`객체를 사용해서 웹서버에 요청 전송. 또한 XMLHttpRequest객체로부터 응답이 오면 DOM, CSS등을 사용해 화면을 조작

## Ajax 방식

- 웹브라우저가 아닌 **XMLHttpRequest객체가 웹서버와 통신** 함.
- **페이지 이동없이** 웹서버와 통신을 하여 결과를 화면에 출력.
- 웹서버의 **응답결과가 HTML이 아니라** XML 또는 단순TEXT(XML/TEXT/JSON)

![image](https://user-images.githubusercontent.com/103404127/172044018-ef5d50f1-6a6b-4427-9d9a-fcdb978d7cd1.png)

1. 웹페이지 이벤트 발생(페이지로드 및 버튼 클릭)
2. JavaScript가 XMLHttpRequest 객체 생성
3. XMLHttpRequest 객체는 웹서버에 요청
4. 서버가 요청처리
5. 서버가 웹페이지에 응답
6. JavaScript가 응답 읽음
7. 적절한 조치(페이지 업데이트 등)가 JavaScript에 의해 수행



