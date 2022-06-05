# XMLHttpRequest 객체

- 대부분의 브라우저가 지원

- reload없이 서버에서 보내는 데이터를 웹페이지의 한부분으로 수정

  

## 함수

- `open()` : 요청 초기화 / `send()` : 웹서버에 요청 전송

  - open(GET/POST, 요청URL, true/false)

    - GET/POST

    ```
    1.GET방식
     - POST방식보다 간단하고 빠른 방식
     - 요청URL뒤에 파라미터 보냄
    2.POST방식
     - 서버의 내용을 변경하고자 할 때 사용. 서버로 보내는 데이터가 많을 때 사용
     - setRequestHeader()에 Content-type명시
    ```

    - true(비동기)/false

    ```
    비동기 방식(true) : 요청 후 응답이 도착하는 동안 기다리지 않고 다음 작업 진행, Ajax에서 사용
    동기 방식 : 요청 후 서버의 응답이 있을때까지 기다렸다가 응답 이후 다음 작업 실행, 자바스크립트에서 사용, 응답 도착하기 전까지 빈(흰)화면 보여줌
    ```

    

## 속성

- `onreadystatechange` : 응답 도착하면 특정 자바스크립트 함수를 호출해서 결과에 알맞은 작업을 하는데 그때 사용할 함수를 지정, 이 속성값을 통해 **웹서버와의 통신상태 확인할 수 있음**, 호출코드 명시하지 않으며 **readyState가 변경될때마다 자동호출** .
- `readyState` : XMLHttpRequest 객체의 요청에 대한 상태를 숫자로 표시, 변화가 있을때 마다 XMLHttpRequest 객체의 onreadystatechange속성에 설정된 callback함수 호출, 5가지 요청에 대한 상태를 전달받음.

```
상태값(0~4)
- 0(UNINITIALIZED) : "객체만 생성", 초기화 되지 않은 상태(open 호출 안된 상태)
- 1(LOADING) : "연결이 시작" 되었다는 의미, open은 호출되고 send는 호출되지 않은 상태
- 2(LOADED) : "요청의 시작", send 호출되었지만 status와 헤더는 도착하지 않은 상태
- 3(INTERACTIVE) : "데이터의 일부를 받은 상태", 서버가 요청처리를 거의 끝낸 상태
- 4(COMPLETED) : "데이터를 전부 받은 상태, 응답완료", 서버의 응답을 받아 사용할 준비완료
```

- `status` : XMLHttpRequest 객체는 웹서버가 전달한 http상태코드를 status에 저장, 서버로부터 도착한 응답의 상태값

```
상태값
- 200(OK) : 요청 정상 처리
- 403(Forbidden) : 접근 거부
- 404(Not Found) : 페이지 없음
- 500(Internal Server Error) : 서버 오류 발생
```

- `responseText`/`responseXml` : 응답의 결과값(텍스트/XML DOM)을 참조하기 위해서 사용 - JSON은 나중에 생겨서 라이브러리 이용함

```
- responseText : 응답 String으로 받음
- responseXml : 응답 XML data로 받음
```



## 생성

- 오래된 IE5/IE6 브라우저를 제외하고 거의 모든 브라우저 XMLHttpRequest 내장하고 있음

```javascript
let xhttp;
if(window.XMLHttpRequest){
    xhttp = new XMLHttpRequest();
}else{
    //code for IE6, IE5
    xhttp = new ActiveXObject("Microsoft.XMLHTTP");
}
```



