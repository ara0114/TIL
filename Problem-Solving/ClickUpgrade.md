

## 1. Anchor 태그에서 click 이벤트를 받는 소스를 upgrade하기

- 주소이동 버튼 추가하여 주소이동 기능 구현
- 'https://' 문자열이 없으면 주소이동 안되므로 없을시 자동으로 주소 추가
- 버튼3개([DAUM],[기상청],[교보문고])를 준비해서 클릭시 주소를 자동으로 입력창에 할당 

🔸 event/click.html

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

            if(str == ''){//str이 비어있다면
                alert('주소를 입력하세요');
                //document.regiform.url.focus();//name속성으로 접근
                document.getElementById('url').focus();//id속성으로 접근
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
        <!-- id로 찾을때는 getElementById, name으로 찾을때는 .으로 접근-->
        <a href="javascript:sendit()">주소이동</a>
        <!-- a태그 원래 이벤트 처리용이 아니므로 sendit()으로 쓰지 못하고 javascript:sendit()으로 -->
        <button type="button" onclick="sendit()">주소이동</button>
        <!-- 버튼은 javascript붙이지 않고 sendit()만 써도 됌 -->
        <button type="button" id="1" onclick="reply_click()">[DAUM]</button>
        <button type="button" id="2" onclick="reply_click()">[기상청]</button>
        <button type="button" id="3" onclick="reply_click()">[교보문고]</button>
    </form>
</body>
</html>
```

📝문제해결

```
1.주소이동하기
- 주소값이 있는지 확인하고 있다면 location.href를 이용하여 주소이동

2.'https://' 문자열이 없으면 주소이동 안되므로 없을시 자동으로 주소 추가
- 주소값이 있을때 문자열의 시작부분 확인: str.startsWith('https://') -> true/false
- false라면 str앞에 'https://'추가

3. 버튼3개([DAUM],[기상청],[교보문고])를 준비해서 클릭시 주소를 자동으로 입력창에 할당
- 함수를 하나로 만들기위해 onclick의 함수는 하나로 하고 button마다 id부여
- 조건문으로 event의 요소 id확인하여 해당하는 주소를 입력창에 할당
```

📝메모

```
1.a 태그는 원래 이벤트 처리용이 아니므로 이벤트 넣을 시 앞에 'javascript:'를 필수로 넣어줘야 함.
2.id는 'getElementById'로, name은 '.' 으로 접근.
3.startsWith이 아닌 indexOf를 이용해 인덱스가 0이 아닐때를 확인하면 문자열의 처음인지 확인 할 수 있음.
  => 아래 sendit()에서 확인
4.버튼 함수 구현할 때 처음에 id없이 onclick="reply_click(id값)" 이런식으로 넣고
  reply_click(id값) 함수를 작성했을때 작동이 안되었음
  => 이유: 변수 str에 document.getElementById('url')를 넣고 조건문 처리에서 
  		  document.getElementById('url').value 가 아닌 str.value로 작성하여 원하는 값을 넣지 못함.
  		  변수에 넣으면 값을 가져올수는 있지만 원하는 값은 전달되지않는다.
  		  참조값
  => 이거 때문에 검색하면서 조금 복잡하게 작성했었는데 아래처럼 작성할 수도 있음
```



🔸 다르게 작성하기

◼javascript부분

```javascript
function sendit(){
	let str = document.getElementById('url').value;
	if(str.indexOf('https://') != 0){
		str = `https://${str}`;
    }
	/*... click.html과 동일*/
}
function setUrl(no){
    if(no == 1){
		document.regiform.url.value = 'https://www.daum.net';
	}else if(no == 2){
		document.regiform.url.value = 'https://www.weather.go.kr';
	}else if(no == 3){
		document.regiform.url.value = 'https://www.kyobobook.co.kr';
	}
}
```

◼html부분

```html
<body>
    <form name="regiform">
        <!--... click.html과 동일-->
        <button type="button" onclick="setUrl(1)">[DAUM]</button>
        <button type="button" onclick="setUrl(2)">[기상청]</button>
        <button type="button" onclick="setUrl(3)">[교보문고]</button>
    </form>
</body>
```



🔸 다르게 작성하기2

◼javascript부분

```javascript
function setUrl(no){
    document.regiform.url.value = no;
}
```


◼html부분


```html
<body>
    <form name="regiform">
		<!--...동일-->
        <button type="button" onclick="setUrl('https://www.daum.net')">[DAUM]</button>
        <button type="button" onclick="setUrl('https://www.weather.go.kr')">[기상청]</button>
        <button type="button" onclick="setUrl('https://www.kyobobook.co.kr')">[교보문고]</button>
    </form>
</body>
```

