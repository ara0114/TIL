### 동기와 비동기에서의 callback

- 자바스크립트는 동기 처리를 함.(정해진 코드 순서대로 처리)
- 자바스크립트는 hoisting 처리를 함.(var, function 선언 부분을 맨앞으로 이동)
- Ajax에서는 비동기 처리를 함.(언제 코드가 실행될 지 예측할 수 없음)
- callback함수는 메소드의 매개변수로 전달되어 메소드 내부에서 이름없는 함수 또는 에로함수(() => {})로 표현, 메소드 내부에서 기능 처리중에 호출
- 콜백함수안에서 또 다른 콜백함수 연속적으로 호출시 가독성 ↓,  유지보수성↓ , 확장성 ↓



### callback 함수의 개선

- promise, async, await 사용으로 callback 문제점 해결



### Promise 🔗[참고자료MDN](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Promise)

- 비동기 작업이 맞이할 미래의 완료 또는 실패와 그 결과값을 나타내는 객체
- 함수에 콜백을 전달하는 대신, 콜백을 첨부하는 방식의 객체
- 비동기 연산 종료 후 결과값이나 실패 이유를 처리하기 위한 처리기를 연결할 수 있음
- 비동기 메소드에서 마치 동기 메소드처럼 값을 반환할 수 있음
  - 최종 결과를 반환하는 것이 아니고, 미래의 어떤 시점에 결과를 제공하겠다는 약속(프로미스)을 반환
- Promise는 다음중 하나의 상태를 가짐
  - 대기(pending) : 이행하지도 거부하지도 않은 초기상태
  - 이행(fulfilled) : 연산이 성공적으로 완료됌
  - 거부(rejected) : 연산이 실패함

- 대기중인 프로미스는 값과 함께 이행할 수도, 어떤 이유로 거부될 수도 있는데 이행이나 거부될 때 

  프로미스에 연결한 처리기는 그 프로미스의 then 메소드로 대기열에 오름

![image](https://user-images.githubusercontent.com/103404127/174093145-00fa0d5f-c1b4-4a2b-a5b9-df3816c10398.png)



- 생성 및 사용

  ```
  const promise = new Promise((resolve,reject) =>{});
  ```

  - promise를 생성하면 executor 콜백함수가 자동으로 실행
  - promise 생성자에서 executor 콜백함수는 또 다른 resolve(성공시), reject(에러시) 콜백함수를 받음
  - promise를 생성하여 비동기 처리 구현후 resolve(), reject() 콜백함수를 호출하여 그 결과를 전달
  - promise를 사용하는 곳에서 결과를 then, catch, finally 등으로 받을 수 있음



### async, await

- async 함수 선언은 AsyncFunction 객체를 반환하는 하나의 비동기 함수를 정의

  (함수 앞에 글자 쓰기만 하면됨 async function xx(....){....} ) 

- 암시적으로 Promise를 사용하여 결과를 반환

- 동기 함수를 사용하는 것 처럼 보여짐

- async함수에는 await식이 포함될 수 있음

- await은 async 함수의 실행을 일시중지하고 전달된 promise의 해결을 기다린 다음 async함수의 실행을 다시 시작하고 완료후 값을 반환

- await키워드는 async함수에서만 유효

- 좀더 간결한 코드를 만들기 위해 사용