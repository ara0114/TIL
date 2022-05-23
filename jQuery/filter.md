# 필터

(1) first()

- 해당하는 것 중 첫번째 요소
- 인수가 없는 함수

(2) even() / odd()

- 해당하는 것 중 짝수, 홀수 요소
- 0부터 번호 지정

```javascript
$('ul li').even().addClass('highlight2');//0,2,...번째 li에 클래스 추가
$('ul li').odd().addClass('highlight');//1,3,...번째 li에 클래스 추가
```

(3) eq(idx), eq(idxFromEnd)

- 해당하는 것 중 지정된 인덱스 요소
- idx: 시작하는 위치에서의 순서(0부터 시작)

- idxFromEnd: 마지막 요소부터 거꾸로 계산(negative)

(4) slice(start,[,end])

- 해당하는 것 중 지정된 인덱스 요소
- start ~ end까지 혹은 start ~ 끝까지의 요소 집함
- 0부터 시작

```javascript
$('body').find('div')//body태그를 찾아서 거기서 div를 찾아
    .eq(2).addClass('blue');//3번째에 blue 클래스 추가

$('body').find('div').slice(0,2)//0에서 2인덱스(2는 불포함)까지 찾아와
    .css('background-color','yellow');

$('body').find('div').slice(3)//3인덱스부터 끝까지 찾아와
    .css('background-color','orange');
```



(5) header/contain/has/parent

- :header() : h1~h6까지의 heading 태그
- :contain(text) : 특정 text를 포함하고 있는 태그

- :has(tag) : 특정 tag를 포함하고 있는 태그
- :parent : 하나 이상의 자식노드(요소 또는 텍스트)가 있는 모든 요소를 선택