# Node.js

 자바스크립트 실행환경(런타임), 자바스크립트 해석엔진

node.js로 서버를 만드는 이유: Non-blocking I/O가 좋아서



## 특징

Non-blocking I/O: 요청이 많거나 오래걸리는 요청 있어도 멈추거나 요청 대기시간 X

=> 채팅/SNS서비스에 자주 사용

코드가 매우 짧고 쉬움 => 빠른 개발 가능



## 시작하기

설치 후 확인

- node -v : 설치한 버전 확인가능

명령어

- npm init: package.json 파일을 만들기위해 사용하는 명령어

  을 하면 node_modules폴더 생성됨

- npm install express : express 라이브러리 설치. 설치 후 package.json의 dependencies에서 설치한 express버전 확인가능

*package.json: 설치한 라이브러리 목록을 자동으로 기록해주는 파일

*node_modules: 라이브러리에 필요한 자료를 담는 공간



서버를 띄우기 위한 기본셋팅(express 라이브러리)

- .listen(서버띄울포트번호, 띄운후 실행할 코드)

```javascript
const express = require('express');//설치한 라이브러리 첨부해주세요
const app = express();//라이브러리로 객체를 만들어주세요

app.listen(서버띄울포트번호, 띄운후 실행할 코드);//서버를 열음
```

- npm install -g nodemon: 서버 재실행 자동화하는 라이브러리(g: global. 다른 폴더에서도 쓸수 있도록 설치)

  - 보안 오류나면 관리자권한으로 powershell실행 후, 아래 명령어로 실행규칙변경

    ```
    1. executionpolicy 입력 하고 Restriceted 나오면
    2. set-executionpolicy unrestricted 입력 y
    ```

- npm install body-parser: post 요청으로 서버에 데이터 전송하고 싶을때. 보낸 데이터를 쉽게 처리하기위해 설치, 설치 후  server.js 상단에 아래 내용추가

  ```javascript
  const bodyParser = require('body-parser');
  app.use(bodyParser.urlencoded({extended : true}));
  ```

get 요청을 처리

- .get('경로', 실행할 코드)
- .sendFile(파일보낼경로)

```javascript
app.get('경로', function(요청내용,응답할방법){
    응답.send('메세지');
})

app.get('/', function(요청,응답){
   응답.sendFile(__dirname + '/파일명') //__dirname은 현재 파일의 경로
})
```

post 요청을 처리

- .post('경로', 콜백함수)

```javascript
app.post('/add', function(요청,응답){
    응답.send('전송완료')
    console.log(요청.body) //요청form에 적힌 데이터 수신가능
    console.log(요청.body.title) //요청form에 title이라는 이름을 가진 데이터 수신가능 
})
```

