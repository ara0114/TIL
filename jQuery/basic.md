# 기본 명령어

(1) text(), text(...), text(function)

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



(2) html(), html(...), html(function)

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

prepend(...) / append(...)

- 태그 안의 맨앞/맨뒤에 HTML을 삽입함

```javascript
$('p').first().prepend("<b>Hello </b>");//첫번째 p태그를 찾아 그 앞에 
$('p').last().append("<strong>Hello</strong>");//마지막 p태그를 찾아 그 뒤에
```

before(...) / after(...)

- 태그 앞/뒤에 HTML을 삽입함

(4) HTML이동

prependTo(...) / appendTo(...)

- 요소를 삽입할 곳의 자식요소 앞/뒤에 추가

```javascript
$( "span" ).prependTo( "#foo" );// 'span' 를  #foo요소 안의 앞으로 이동
$( "span" ).appendTo( "#foo2" );// 'span' 를  #foo2요소 안의 뒤로 이동
```

insertBefore(...) / insertAfter(...)

- 요소를 삽입할 곳의 앞/뒤에 추가

```javascript
$('p').first().insertBefore('#foo'); //p가 #foo요소 앞으로 이동
$('p').last().insertAfter('#foo2'); //p가 #foo2요소 뒤로 이동
```

