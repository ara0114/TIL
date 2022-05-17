# Function

1. function

- 어떤 기능 처리 후 결과를 리턴

- 모든 함수는 return value 또는 return undefined(생략가능)가 정의되어 있음

- 하나의 함수는 한가지 일을 위해 작성

- 함수의 이름은 동작을 나타내는 것이 좋음

- 함수는 object로 간주 => 변수에 할당, 파라미터 전달, 리턴이 가능

- 함수선언과 함수표현

  ```
  함수 선언: js엔진은 함수 선언문을 맨 위로 올려줌, 함수 선언문보다 먼저 함수를 호출할 수 있음(hoisted)
  함수 표현: 함수를 변수에 할당하여 할당된 변수를 호출함으로써 함수를 실행할 수 있음,
  		  변수에 할당하기 전에는 함수를 호출할 수 없음(hoisting X)

  # default parameters
  function test(message, ms='dm'){
  	console.log(`${message} ${ms}`);
  }

  test('test'); // test dm 출력

  # rest parameters
  function testA(...args){ // 배열형태로 전달..다른 파라미터와 함께 쓸 경우 가장 마지막에 와야함
  	...
  }

  # {}안에 긴 로직코드가 구현되면 가독성 떨어짐
  # 조건이 맞지 않을 때 빨리 리턴하여 함수 종료하고 조건이 맞을때만 로직 구현
  ```

- Function Expression

  ```javascript
  // 변수에 함수 할당
  const print = function(){...} //anonymous function

  // callback function ... 함수를 파라미터로 전달해서 상황에 따라 호출
  function cb(p, fun1, fun2){
      if(p) fun1();
      else fun2();
  }
  const fun1 = function(){...}//anonymous function
  const fun2 = function name(){...}//named function
  ```

- Arrow Function 에서 {} 사용하면 리턴을 사용해야함

- 함수 선언과 동시에 호출

  ```javasc
  (function test(){...})();
  ```

2. 내장함수

   [1] confirm: 사용자가 확인이나 취소 버튼을 클릭할 경우 true/false 리턴

   [2] escape/unescape: 숫자, 영문자를 제외한 한글 등을 16진수 unicode형태로 인코딩(변환)하여 서버로 전송(변환하지 않으면 한글깨짐)

   [3] isFinite: 정상적인 숫자가 입력되면 true, 그렇지 않으면 false리턴하여 숫자만 입력받을수 있도록 함

   [4] isNaN: 입력된 값이 문자이면 true, 숫자이면 false리턴

   [5] 문자열함수

   ```javascript
   charAt(index): index의 문자
   indexOf(문자): 문자가 처음 나타난 위치의 index
   lastIndexOf(문자): 문자가 마지막으로 나타난 위치의 index
   length: 문자열 길이
   ```

   [6] split: 지정한 문자를 기준으로 문자열 분할

3. Math함수

- Math.round(): 정수로 형변환
- Math.pow(10,1): 10^1 거듭제곱

4. 클로저

- 함수안에 선언된 변수는 지역변수이므로 함수 외부에서 사용할 수 없지만 클로저는 이 규칙을 위반할 수 있음
- 함수 내에서 함수를 정의하고 사용하면 클로저라고 할 수 있음
- 정의한 함수를 리턴하고 사용은 바깥에서 함
- 메모리 계속 잡고 있으므로 효율↓
- 적당히 사용하거나 사용하지 않아야.. 지역변수 유지해야 할 때 주의해서 사용

5. 중첩함수와 익명의 자기호출함수(재귀함수)

- 중첩함수는 부모함수의 변수에 접근가능

- 재귀함수(자기호출함수): 함수 내부에서 자기 자신을 호출하는 함수

  ```javascript
  (function(){
      ...
      return function(){...};
  })();
  ```

6. 타이머 함수

- 특정한 시간에 특정한 함수를 실행할 수 있게 하는 함수

  [1] setTimeout(함수, 초) : 특정한 시간 후에 함수를 한번 실행

  [2] setInterval(함수, 초) : 특정한 시간마다 함수를 실행

  [3] clearTimeout(), clearInterval() : 타이머가 더이상 필요 없을 때는 타이머를 멈춤
