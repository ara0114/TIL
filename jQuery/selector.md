# Selector

: Selector를 이용하여 DOM Element를 검색

기본문법: `jQuery("")`,  `$("")`



(1) tag selector

`$("태그")` : HTML tag 제어

(2) id selector

`$("#id")` : id 속성을 가진 tag 제어

(3) class selector

`$(".class")` : class 속성을 가진 tag 제어

(4) 자손 selector

`$("태그1 태그2")` : 태그 안의 모든 자식 태그(태그1 밑의 모든 태그2)

(5) 유니버셜 selector

`$("*")` :  전체 태그

(6) 그룹 selector

`$("셀럭터1, 셀렉터2")` : 복수의 셀렉터

(7) 자식 selector

`$("부모태그 > 자식태그")` : 특정 태그 바로 밑의 자식 태그 

(8) 다음(인접) selector

`$("(이전)태그 + (다음)태그")` : 입력한 태그의 인접한 다음 태그

---

(9) :first-child selector

`$("태그:first-child")` :  동일 태그 안의 첫번째 태그

(10) Next Siblings selector

`$("prev ~ siblings")` : prev 요소 다음에 오는 모든 sibings 요소를 선택

(11) :not() selector

`$(":not(selector)")` : 주어진 selector에 매치되지 않은 모든 요소를 선택

(12) :empty selector

`$("태그:empty")` : 자식태그 혹은 text nodes를 포함하지 않는 태그

(13) :nth-child(index/even/odd/equation) selector

`$("태그:nth-child")` : 특정 태그 안에서 지정한 번호의 태그

(14) :last-child selector

`$("태그:last-child")` : 자식 태그 중 마지막 자식 

(15) :only-child selector

`$("태그:only-child")` : 부모의 자식이 하나인 태그

---

(16) Attribute selector

`$("[속성]")` :  특정 속성을 가진 태그

`$("태그[속성='값']")` : 특정 속성의 값이 지정한 값인 태그

`$("태그[속성!='값']")` : 특정 속성의 값이 지정한 값이 아닌 태그

`$("태그[속성|='값']")` : 값이 같거나 해당 문자열로 시작하여 하이픈(-)이 오는 지정된 속성이 있는 요소

`$("태그[속성^='값']")` : 특정 속성이 지정한 값으로 시작되는 태그

`$("태그[속성$='값']")` : 특정 속성이 지정한 값으로 끝나는 태그

`$("태그[속성*='값']")` : 특정 속성이 지정한 값을 포함하고 있는 모든 태그

`$("태그[속성~='값']")` : 공백으로 구분된 주어진 단어를 포함하는 값으로 지정된 속성이 있는 요소

```javascript
//(1) [attribute]: 특정 속성을 가진 태그
$(function () {
    //속성이 id인것 찾아서 적용
    $('[id]').css('color','red');
});

//(2) [attribute='value']
//    	'=' 같은 값,
//    	'!=' 다른 값,
//    	'|=' 문자열과 같거나 해당 문자열로 시작해서 하이픈(-)이오는 지정된 속성이 있는 요소
$(function () {
    $("a[hreflang='en']").css('border','3px dotted green');
    //a 태그의 hreflang값이 'en'인것을 찾아 적용
    $("a[hreflang!='en']").css('border','3px dotted green');
    //a 태그의 hreflang값이 'en'이 아닌것을 찾아 적용
    $("a[hreflang|='en']").css('border','3px dotted green');
    //a 태그의 hreflang값이 'en'이거나 'en-'인것을 찾아 적용
});

//(3) [attribute^='value']:특정 속성이 지정한 값으로 시작되는 태그
//(4) [attribute$='value']:특정 속성이 지정한 값으로 끝나는 태그
//(5) [attribute*='value']:특정 속성이 지정한 값을 포함하고 있는 태그
//(6) [attribute~='value']:공백으로 구분된 주어진 단어를 포함하는 값으로 지정된 속성이 있는 요소
$(function () {
    //속성 title값이 f로 시작하는거
    $("[title^='f']").css('color','red');
    //input속성 name값이 letter로 끝나는것에 value값을 지정해 넣어줌
    $("input[name$='letter']").val('a letter');
    //input속성 name값에 man을 포함하는것에 value값 지정해 넣기
    $("input[name*='man']").val('has man in it!');
    //input속성 name값에 공백으로 구분된 man을 포함하는 것에 value값 지정해 넣기
    $("input[name~='man']").val('mr.man is in it!');
});
```



