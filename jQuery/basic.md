# 기본 명령어

(1) __text(), text(...), text(function)__

- 내부 태그 가져오지 않고 문장만 가져옴(태그까지 가져오려면 html)

```javascript
let str = $('p').first().text();
```

- text(function(index, text)): index는 0부터 시작

```javascript
$('p').text('<b>Some</b> new text');//태그해석x, 문장 그대로 출력(변경)
$('ul li').text(function(index){//li가 다 바뀐다 생각, index는 0부터 시작
        return "item number " + (index+1);
});
```



(2) __html(), html(...), html(function)__

- 문장과 태그 적용

```javascript
$('p').click(function(){
       let htmlString = $(this).html();
       //this: 클릭한 p. 의 html문장을 htmlString에 저장
       $(this).text(htmlString);
       //위에서 얻어온 html을 text형태로 담아넣기(태그를 함께 보여준다.해석x)
});
$('div').html("<span class='red'>Hello <b>Again</b></span>");
//div태그에 html문장 넣기
$('div.demo-container').html("<p>All new content. <em>You bet!</em></p>");
$('div.demo-container').html(function(){
        let emphasis = "<em>" + $('p').length + " paragraphs</em>";
    	//$('p').length: p태그의 갯수
        return "<p>All new content for " + emphasis + "</p>";
});
```



(3) HTML 삽입

__prepend(...)__ / __append(...)__

- 태그 안의 맨앞/맨뒤에 HTML을 삽입함

```javascript
$('p').first().prepend("<b>Hello </b>");//첫번째 p태그를 찾아 그 앞에 
$('p').last().append("<strong>Hello</strong>");//마지막 p태그를 찾아 그 뒤에
```

__before(...)__ / __after(...)__

- 태그 앞/뒤에 HTML을 삽입함



(4) HTML이동

__prependTo(...)__ / __appendTo(...)__

- 요소를 삽입할 곳의 자식요소 앞/뒤에 추가

```javascript
$( "span" ).prependTo( "#foo" );// 'span' 를  #foo요소 안의 앞으로 이동
$( "span" ).appendTo( "#foo2" );// 'span' 를  #foo2요소 안의 뒤로 이동
```

__insertBefore(...)__ / __insertAfter(...)__

- 요소를 삽입할 곳의 앞/뒤에 추가

```javascript
$('p').first().insertBefore('#foo'); //p가 #foo요소 앞으로 이동
$('p').last().insertAfter('#foo2'); //p가 #foo2요소 뒤로 이동
```



(5) 다른태그로 묶기

- __wrap('tag')__ :  각 요소를 태그로 각각 감싼다.
- __wrapAll('tag')__ : 요소 전체를 태그로 한번에 감싼다.
- __wrapInner('tag')__ : 자식 요소 각각을 태그로 각각 감싼다.

```javascript
$('p').slice(0,3).wrap('<div></div>');//index(0,1,2)번째 p태그 쪼개고 div적용해 각각 wrap씌우기
									  //=> <div><p></p><div><div><p></p><div><div><p></p><div>
$('p').slice(3,6).wrapAll('<div></div>');//index(3,4,5)번째 p태그 쪼개고 한번에 wrap, div적용
    								     //=> <div><p></p><p></p><p></p><div>
$('p').slice(6,10).wrapInner('<b></b>');//index(6,7,8)번째 p태그 쪼개고 각각 wrap, p태그 안에 b태그 적용
    									//=> <p><b></b><p><p><b></b><p><p><b></b><p>
```



(6) 태그 변경 / 제거

- __replaceWith()__ : 태그 변경
- __remove()__ :  태그 제거

```javascript
$(this).replaceWith("<div>"+$(this).text()+"</div>");
//this 요소를 "<div>" + $( this ).text() + "</div>" 로 변경

$('div.rem').remove();//div의 rem Class를  제거
```



(7) 속성값 변경과 취득

- __attr(..., ...)__ : 지정한 속성 값 변경
- __attr(...)__ : 지정한 속성 값 가져옴
- __removeAttr(...)__ : 지정한 속성 값 제거

```javascript
$('a').first()
.attr('href',"http://daum.net")//속성의 값 변경
.text($('a').attr('href'));//속성의 값을 텍스트로 가져옴

$('a').last().removeAttr('target');//속성 값 제거
```



(8) class 속성 추가 / 제거

- __addClass(...)__ : class 속성 추가
- __removeClass(...)__ : class 속성 제거

```javascript
$('p').addClass('selected');
$('p').first().removeClass('selected');
```

