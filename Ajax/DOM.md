# HTML DOM(Document Object Model)

## DOM이란

**🔗 [참고사이트-MDN Web Docs](https://developer.mozilla.org/ko/docs/Web/API/Document_Object_Model/Introduction) **

- 웹페이지를 스크립트 또는 프로그래밍언어들에서 사용될 수 있게 연결시켜주는 역할 담당
- 웹페이지 객체 지향 표현.
- 구조화된 nodes와 property, method를 갖고있는 objects로 문서를 표현
- 동일한 문서를 표현/저장/조작 하는 방법을 제공
- 자바스크립트와 같은 스크립팅 언어로 DOM을 수정할 수 있음
- 웹페이지는 일종의 문서. 이 문서는 웹 브라우저를 통해 해석 됌
- W3C에서 표준 제작
- Ajax를 사용하여 서버로부터 응답 결과를 전송받아 브라우저의 HTML상에 출력할때 DOM모델 이용
- 동적으로 HTML생성할때 필요
- Object들을 Tree처럼 생성

![image](https://user-images.githubusercontent.com/103404127/172041965-7a57df9f-eb1a-41e5-9020-a7ba3ffc5459.png)



## DOM활용

- 요소 = node = tag = element

[1] Finding HTML Elements

| Method                                | Description               |
| :------------------------------------ | :------------------------ |
| document.getElementById(id)           | id로 요소 찾기            |
| document.getElementsByTagName(name)   | 태그 name으로 요소 찾기   |
| document.getElementsByClassName(name) | 클래스 name으로 요소 찾기 |

- Element => 하나의 리턴값

- Elements => 모든태그 다 읽어라 => 리턴형은 배열

- id타입은 js, class타입은 css에서 주로 검색

[2] Changing HTML Elements

| Method                                 | Description         |
| -------------------------------------- | ------------------- |
| element.innerHTML = new html content   | 요소의 html 변경    |
| element.attribute = new value          | 요소의 속성 값 변경 |
| element.setAttribute(attribute, value) | 요소의 속성 값 변경 |
| element.style.property = new style     | 요소의 스타일 변경  |

[3] Adding and Deleting Elements

| Method                          | Description        |
| ------------------------------- | ------------------ |
| document.createElement(element) | 요소 생성          |
| document.removeChild(element)   | 요소 제거          |
| document.appendChild(element)   | 요소 추가          |
| document.replaceChild(element)  | 요소 변경          |
| document.write(text)            | text를 페이지 출력 |

[4] Adding Events Handlers

| Method                                                | Description                             |
| ----------------------------------------------------- | --------------------------------------- |
| document.getElementById(id).onclick = function(){...} | 요소 클릭시 실행되는 이벤트 핸들러 추가 |

---

<br>\> 파일 선택 태그 추가하기

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        let i = 0;
        function add(){
            let parentdiv = document.getElementById('textHolder');
            let divel = document.createElement('div');
            divel.appendChild(document.createTextNode(`파일 선택 ${++i} `));
            let inputel = document.createElement('input');
            inputel.type = 'file';      
            divel.appendChild(inputel);//divel의 child로 inputel을 추가하여 하나로 만들고
            parentdiv.appendChild(divel);//parent에 divel을 넣어준다.
        }
        function del(){
            let parentdiv = document.getElementById('textHolder');
            if(i > 0){//div태그가 있을때만 삭제하겠다.
                parentdiv.removeChild(parentdiv.lastChild);//lastChild는 마지막 태그
                --i;
            }
        }
    </script>
</head>
<body>
    <button name="btnAdd" onclick="add()">파일 선택 추가</button>
    <button name="btnAdd" onclick="del()">파일 선택 제거</button>
    <br>
    <div id="textHolder">
    </div>
</body>
</html>
```

<br>\> 드롭다운 리스트 상자에 아이템을 추가,삭제,변경

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        // 대분류
        const addressList = ["서울","인천","경기도","강원도"];
        
        // 중분류
        const gugunListSeoul = ["노원구", "강남구", "구로구", "마포구"];
        const gugunListIncheon = ["남동구", "부평구", "서구", "계양구"];
        const gugunListKy = ["부천시", "시흥시", "안양시", "수원시"];

        window.onload = function(){//페이지가 로딩될때
            //대분류의 내용
            let sido = document.getElementById('sidoSelect');
            for(let i=0;i<addressList.length;i++){
                let optionel = document.createElement('option');//옵션태그생성
                optionel.value = addressList[i];//옵션요소의 속성에 addressList를 넣음
                //<option value='서울'></option>
                optionel.appendChild(document.createTextNode(addressList[i]));//옵션태그에 텍스트값 넣어줌
                //<option value='서울'>서울</option>
                sido.appendChild(optionel);
            }
            //중분류 & 버튼 숨겨놓기(대분류 선택하면 나올 수 있도록 초기화)
            let gugun = document.getElementById('gugunSelect');
            let btnArea = document.getElementById('btnArea');
            gugun.style.display = 'none';
            btnArea.style.display = 'none';
        }

        function changeSidoSelect(){
            let sido = document.getElementById('sidoSelect');
            let idx = sido.options.selectedIndex;//옵션중 내가 선택한 것의 인덱스
            let area = document.getElementById('area');
            area.value = '';

            gugunSelectFill(idx);
        }

        function gugunSelectFill(idx){
            let data = null;//중분류 배열 들어갈 예정임
            let gugun = document.getElementById('gugunSelect');
            let btnArea = document.getElementById('btnArea');
            
            if(idx == 0){
                gugun.style.display = 'none';
                btnArea.style.display = 'none';
                return ; //실행종료(밑에꺼 다 실행 x)
            }
            if(idx == 1){data = gugunListSeoul;}
            if(idx == 2){data = gugunListIncheon;}
            if(idx == 3){data = gugunListKy;}
            if(idx == 4){
                gugun.style.display = 'none';
                btnArea.style.display = 'none';
                alert('현재는 지원하지 않습니다.');
                return ;//실행종료(밑에꺼 실행 x)
            }

            //gugun.innerHTML = '';
            gugun.innerHTML = '<option value="">중분류를 선택하세요</option>';

            for(let i=0;i<data.length;i++){
                let optionel = document.createElement('option');
                optionel.value = data[i];
                //<option value='남동구'></option>
                optionel.appendChild(document.createTextNode(data[i]));
                //<option value='남동구'>남동구</option>
                gugun.appendChild(optionel);
            }
            gugun.style.display = '';
            btnArea.style.display = '';//보여주는작업(↔ none)
        }

        function getArea(){
            let area = document.getElementById('area');
            let sido = document.getElementById('sidoSelect');
            let gugun = document.getElementById('gugunSelect');

            area.value = `${sido.value} ${gugun.value}`;
        }
    </script>
</head>
<body>
    <div id="sido">
        <select id="sidoSelect" onchange="changeSidoSelect()">
            <option value="">대분류를 선택하세요.</option>
        </select>
        <select id="gugunSelect">
            <option value="">중분류를 선택하세요.</option>
        </select>
        <label>
            <button id="btnArea" name="btnArea" onclick="getArea()">선택</button>
            <input type="text" id="area" size="40">
        </label>
    </div>
</body>
</html>
```

---

*etc.*

div 태그의 값을 가져오는 방법

- document.all : document 태그 안의 태그 id 또는 name 속성을 모두 찾음(비표준)
- innerText : 태그의 Text 값에 접근(비표준)

