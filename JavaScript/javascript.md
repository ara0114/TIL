# JavaScript

-프론트 => 브라우저에서 해석된다. (자바의 JVM느낌)

-HTML과 ServerScript(백엔드) 사이에서 이벤트 처리를 주로 담당

-비동기 통신

1. 자바스크립트 실행

   (1) 실행방법

   - 기본: 페이지가 준비되기 전 js가 실행될 수 있음. js파일이 크다면 페이지가 준비되기까지 시간 오래 걸릴 수 있음

     `<script src="test.js"></script>`

   - async 와 defer: html parsing과 js다운로드 병렬로 진행

     - async: js가 먼저 다운로드 될 경우 페이지가 준비되지 않은 채 js가 실행될 수 있음

       `<script async src="test.js"></script>`

     - defer: 둘다 다운로드 되었을 경우 js 실행, 안정적인 방법, js여러개일 경우 선언된 순서대로 실행

       `<script defer src="test.js"></script>`

2. 변수의 선언

   - 할당되는 데이터에 따라 동적으로 타입이 할당.

   - 변수 선언시 데이터의 타입을 선언하지 않음.

   - 처음부분에 `use strict`를 써주면 변수선언이나 타입변경을 좀더 엄격(안전)하게 만들어 줌.

   - `var`, ` let`을 이용하여 선언.(let을 권장함)

   - `const`를 이용하여 선언하면 할당된 값이 변경되지 못함.

   - 데이터 타입: JS의 데이터 타입은 하나의 변수에 여러 데이터형을 저장할 수 있음.

     - primitive: 더이상 작은 단위로 나눠지지 않는 타입, single item

       ```
       number: 정수, 실수, 8진수, 16진수 등 숫자를 저장할 수 있는 복합적인 데이터 타입
       string: "", ''을 이용해 문자열 표현, ``으로도 가능하며 표현식도 넣을 수 있음
       boolean: true/false를 값으로 가짐. 0,null,undefined,NaN은 false, 그 외는 true로 해석됨
       null: 데이터의 형식이 알려지지 않았거다 데이터가 없음을 나타냄
       undefined: 변수 선언 후 데이터를 할당하지 않은 경우 갖는 값
       symbol: 고유한 식별자가 필요할때 사용, 출력할때는 description속성을 사용해 string으로 변환해야함
       ```

     - object: single item을 묶어서 한 단위나 box로 관리할 수 있음
     - function: 작업을 수행하거나 값을 계산하는 등 함수. 자바스크립트의 함수는 객체

     - 타입변환
       - 양수/0 =Infinity(무한대), 음수/0 = -Infinity, NaN/숫자= NaN(not a number)
       - '+' 연산 : 문자열+숫자 = 문자열(**mySql과 다름**)
     - 타입비교
       - == : 타입변환을 사용한 약한 비교
       - === : 타입변환을 하지 않는 엄격한 비교
