# Event처리

## Event

[1] Anchor태그에서 click 이벤트 받기

\> click.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../style.css">
    <script>
        function sendit(){
            //let str = document.regiform.url.value;//name속성으로 찾기
            let str = document.getElementById('url').value;//id속성으로 찾기
            console.log(str);
            //사용자가 입력할 수 있는 태그들은 value로, 입력못하는 div같은 동적인거는 innerHTML로

            if(str == ''){//str이 비어있다면
                alert('주소를 입력하세요');
                //document.regiform.url.focus();
                document.getElementById('url').focus();
            }else{//비어있지않다면
                if(!str.startsWith('https://')){//str의 시작이 https://가 아니라면
                    str = 'https://'+str;//str앞에 https://를 추가
                    alert('https:// 주소 추가 후 이동합니다.');
                }
                location.href = str; //str주소로 이동
            }
        }
        function reply_click(){//button 클릭시 주소가 자동으로 입력창에 할당
            if(event.srcElement.id == 1){//button id가 1일때(daum버튼 눌렀을때)
                document.getElementById('url').value = 'https://www.daum.net';                
            }else if(event.srcElement.id == 2){//button id가 2일때(기상청버튼 눌렀을때)
                document.getElementById('url').value = 'https://www.weather.go.kr';
            }else if(event.srcElement.id == 3){//button id가 3일때(교보문고버튼 눌렀을때)
                document.getElementById('url').value = 'https://www.kyobobook.co.kr';
            }
        }
    </script>
</head>
<body>
    <form name="regiform">
        <input type="text" id="url" name="url" size="50">
        <!--id로 찾을때는 getElementById, name으로 찾을때는 .으로 접근-->
        <a href="javascript:sendit()">주소이동</a>
        <!--a태그 원래 이벤트 처리용이 아니므로 sendit()으로 쓰지 못하고 javascript:sendit()으로 -->
        <button type="button" onclick="sendit()">주소이동</button>
        <!--버튼은 javascript붙이지 않고 sendit()만 써도 됌 -->
        <button type="button" id="1" onclick="reply_click()">[DAUM]</button>
        <button type="button" id="2" onclick="reply_click()">[기상청]</button>
        <button type="button" id="3" onclick="reply_click()">[교보문고]</button>
    </form>
</body>
</html>
```

\> click.html을 다르게

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../style.css">
    <script>
        function setUrl(no){
            document.regiform.url.value = no;
            /*if(no == 1){
                document.regiform.url.value = 'https://www.daum.net';
            }else if(no == 2){
                document.regiform.url.value = 'https://www.weather.go.kr';
            }else if(no == 3){
                document.regiform.url.value = 'https://www.kyobobook.co.kr';
            }*/
        }
        function sendit(){
           //let str = document.regiform.url.value;
           let str = document.getElementById('url').value;
           if(str.indexOf('https://') != 0){
               str = `https://${str}`;
           }
           console.log(str);

           if(str == ''){
               alert('주소를 입력하세요');
               //document.regiform.url.focus();
               document.getElementById('url').focus();
           }else {
               location.href = str;
           }
        }
    </script>
</head>
<body>
    <form name="regiform">
        <input type="text" id="url" name="url" size="50">
        <a href="javascript:sendit()">주소이동</a>
        <button type="button" onclick="sendit()">주소이동</button>
        <button type="button" onclick="setUrl('https://www.daum.net')">[DAUM]</button>
        <button type="button" onclick="setUrl('https://www.weather.go.kr/w/index.do')">[기상청]</button>
        <button type="button" onclick="setUrl('https://www.kyobobook.co.kr')">[교보문고]</button>
       <!--
        <button type="button" onclick="setUrl(1)">[DAUM]</button>
        <button type="button" onclick="setUrl(2)">[기상청]</button>
        <button type="button" onclick="setUrl(3)">[교보문고]</button>
       -->

    </form>
</body>
</html>
```

<br>

[2] 입력값을 검사하는 기본 자바 스크립트

- button태그는 항상 자바스크립트 함수와 같이 사용됌
- onClick='check(this.form)' : this.form은 폼태그
- submit버튼의 사용
  - reset: 태그의 기본값으로 돌아감
  - submit: 서버로 폼의 내용을 전송함
  - onsubmit: submit 버튼이 작동되면 자동으로 호출됌
- image도 submit 기능 버튼으로 사용할 수 있음

\> input.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../style.css">
    <script>
        function check(f){
            if(f.wname.value == '' || f.wname.value.length == 0){
                alert('이름을 입력하세요');
                f.wname.focus();
                //return false;//onsubmit일때만 리턴사용
            }else if(f.subject.value == '' || f.subject.value.length == 0){
                alert('제목을 입력하세요');
                f.subject.focus();
                //return false;
            }else if(f.wcontent.value == '' || f.wcontent.value.length == 0){
                alert('내용을 입력하세요');
                f.wcontent.focus();
                //return false;
            }else{//모두 입력되어있다면
                alert('데이터 정상 입력, 계속 진행합니다.');
                f.submit(); //-- submit 기능이 없는 버튼(버튼타입이 submit이 아닐때)일때 추가하여 실행
                //return true; //-- 안써도 기본값으로 들어감
            }
        }
    </script>
</head>
<body>
    <form method="post" action="" name="myform" onsubmit="return check(this)">
        <!--버튼타입 submit일때 form태그에 onsubmit 추가 -->
        <h2>방명록</h2>
        이름 : <input type="text" name="wname"><br>
        제목 : <input type="text" name="subject" size="50"><br>
        내용 : <textarea name="wcontent" cols="54" rows="8"></textarea><br>
        <!-- <button type="button" onclick="check(this.form)">저장</button> -->
        <!-- <button>저장</button> -->
        <!-- 버튼타입 명시하지 않으면 기본은 submit -->
        <!-- <input type="image" src="disks.jpg"></input> -->
        <!-- image타입도 submit타입처럼 취급-->
    </form>
    <form method="post" action="" name="myform">
        <h2>방명록</h2>
        이름 : <input type="text" name="wname"><br>
        제목 : <input type="text" name="subject" size="50"><br>
        내용 : <textarea name="wcontent" cols="54" rows="8"></textarea><br>
        <a href="javascript:check(myform)">
            <img src="disks.jpg" border="0">
        </a>
    </form>
</body>
</html>
```

---

\> 실습: input 태그에서 행의 수와 열의 수를 입력받아 테이블 생성.

숫자만 입력가능, 문자열 입력시 에러메세지 출력

입력가능 값의 범위는 3~10, 범위벗어나면 에러메세지 출력, 함수안에서 다른 함수 호출가능

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../style.css">
    <script>
        function check(f){
            let row = f.row.value;
            let col = f.col.value;
            //console.log(`row:${row}, col:${col}`);
            if(isFinite(row) == false){
                alert('숫자를 입력하세요');
                f.row.value= '';
                f.row.focus();
                return false;
            }else if(row<3 || row>10){
                alert('3~10사이의 수만 입력하세요');
                f.row.value= '';
                f.row.focus();
                return false;
            }else if(isFinite(col) == false){
                alert('숫자를 입력하세요');
                f.col.value= '';
                f.col.focus();
                return false;
            }else if(col<3 || col>10){
                alert('3~10사이의 수만 입력하세요');
                f.col.value= '';
                f.col.focus();
                return false;
            }else{
                //makeTable();
                //makeTable(f);
                makeTable(row,col);
                return false;
            }
            /*if(isFinite(row) && isFinite(col)){
                if((row>=3 && row<=10) && (col>=3 && col<=10)){
                    makeTable(row,col);
                }else{
                    alert('입력값의 범위는 3~10입니다.');
                    return false;
                }
            }else{
                alert('숫자만 입력하세요');
                return false;
            }*/
        }
        function makeTable(row,col){
            //document.myform.row.value //--makeTable()일때
            //f.row.value //--makeTable(f)일때
            console.log(`row:${row}, col:${col}`);
            let html = '<table><tr>';
            for(let j=0; j<col; j++){
                html += `<th>${j+1}</th>`;
            }
            html += '</tr>';

            for(let i=0; i<row; i++){
                html += '<tr>';
                    for(let j=0; j<col; j++){
                        html += '<td>&nbsp</td>';
                    }
                html += '</tr>';
            }
            html += '</table>';

            let panel = document.getElementById('panel').innerHTML = html;
        }
    </script>
</head>
<body>
    <form name="myform" onsubmit="return check(this)">
        행의 수: <input type="text" name="row" id="row" value="5" size="20"><br>
        열의 수: <input type="text" name="col" id="col" value="5" size="20"><br>
        <button>테이블 생성</button>
    </form>
    <div id="panel"></div>
</body>
</html>
```

---

## onload event

onload event - 페이지로딩시 자동실행 함수 선언, body태그 실행후 실행

[1] `split()`로 입력된 값 분리하여 출력

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../style.css">
    <script>
        function searchW(){
            let str = '기획자/설계자/개발자/디자이너';
            let strout = '';
            let strSplit = str.split('/');// '/'로 나누어 배열에 넣기
            console.log(`추출된 문자열 갯수: ${strSplit.length}`);
            for(let i=0;i<strSplit.length;i++){
                strout += `💚${strSplit[i]}`;
            }
            let panel = document.getElementById('panel');
            panel.innerHTML = strout;
        }
    </script>
</head>
<body onload="searchW()">
    <div id="panel"></div>
</body>
</html>
```

[2] 파일의 확장자 검사하기

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../style.css">
    <script>
        window.onload = function(){
            let word1 = document.getElementById('word1');
            let result1 = document.getElementById('result1');
            word1.innerHTML = 'test.jsp';
            let str = word1.innerHTML;

            if(str.lastIndexOf('.jsp')>=0){
                result1.innerHTML = '전송할 수 없는 형식입니다.';
            }
        }
    </script>
</head>
<body>
    <h1>자바스크립트 확장자 검사</h1><br><br>
    <div id="panel">
        <span id="word1"></span>  :
        <span id="result1"></span><br>
    </div>
</body>
</html>
```

## Select ~ option event

[1] select ~ option

- onchange: 선택할때마다

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../style.css">
    <script>
        function ansquChange(f){
            let frm = document.frmData;
            let str = f.title.value + f.ansqu.options[f.ansqu.selectedIndex].text;//누적
            //options:옵션 여러개,
            
            f.title.value = str;
            f.title.focus();

            frm.ansqu.value = f.ansqu.options[f.ansqu.selectedIndex].value;
            //마지막값--서버로전송되는값
        }
        function partChange(f){
            let frm = document.frmData;
            let str = f.title.value + f.pt.options[f.pt.selectedIndex].text;

            f.title.value = str;
            f.title.focus();

            frm.pt.value = f.pt.options[f.pt.selectedIndex].value;
            //서버로 전송되는 값
        }
    </script>
</head>
<body>
    <form name="frmSelect">
        <select name="ansqu" onchange="ansquChange(this.form)">
            <option value="">[종류선택]</option>
            <option value="A001">[질문]</option>
            <option value="A002">[답변]</option>
            <option value="A003">[참고]</option>
            <option value="A004">[공지]</option>
            <option value="A005">[추천]</option>
            <option value="A006">[선택안함]</option>
        </select>
        <select name="pt" onchange="partChange(this.form)">
            <option value="">[분야선택]</option>
            <option value="P001">[JAVA]</option>
            <option value="P002">[JSP]</option>
            <option value="P003">[Spring]</option>
            <option value="P004">[JavaScript]</option>
            <option value="P005">[MySQL]</option>
            <option value="P006">[선택안함]</option>
        </select>
        <input type="text" name="title" size="85" class="title" maxlength="100">
    </form>
    <hr>
    <form name="frmData">
        분야 선택 전송값 : <input type="text" name="ansqu" size="50"><br>
        언어 선택 전송값 : <input type="text" name="pt" size="50">
    </form>
</body>
</html>
```

## etc

[1] `substring()` 

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../style.css">
    <script src="../utility.js"></script>
</head>
<body>
    <script>
        let str = '123ABC 가나다/가나다';
        pl(`${str}`);
        pl(`${str.substring(0,3)}`);//123
        pl(`${str.substring(3,6)}`);//ABC
        pl(str.substring(7));//가나다/가나다
        p(str.lastIndexOf('가나다'));//11
    </script>
</body>
</html>
```

[2] 문자열에서 공백 제거하기

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../style.css">
    <script>
        function trimSpace(f){
            let str = f.txtData.value;
            console.log(str);

            for(let i=0; i<str.length; i++){
                if(str.charAt(i) == ' '){
                    str = str.substring(0,i) + str.substring(i+1);
                    i = i-1;//맨앞에 한칸이상의 공백이 있을 때 처리하기 위해서
                }
            }
            f.txtData2.value = str;
        }
    </script>
</head>
<body>
    <form name="myform">
        원본 문자열: <input type="text" name="txtData" size="60" maxlength="60">
        <a href="javascript:trimSpace(myform)"><b>문자열 공백지우기</b></a>
        <br><br>
        공백 제거 문자열: <input type="text" name="txtData2" size="60" maxlength="60">
    </form>
</body>
</html>
```

