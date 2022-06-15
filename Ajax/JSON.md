# JSON(JavaScript Object Notation)

- 자바 스크립트 객체 표기법(문자열)
- 데이터 저장과 교환에서 사용
- xml에 비해 매우 적은 네트워크 트래픽, xml을 대체할 수 있는 데이터 표현 기술
- 서버와 데이터를 주고 받을 때 및 데이터 직렬화시 사용
- key - value 한쌍으로 표현
- 가벼운 텍스트 기반 구조 
- 프로그램 언어와 플랫폼에 독립적

[1] JSON Object와 Array구문

- JSON DATA는 `name : value` 한쌍으로 표현

- JSON DATA는 `,` 로 구분해서 표현
- JSON Object는 `{,}` 를 사용
- JSON Array는 `[,]` 를 사용 

```
"employees":[
	{"firstName" : "John", "lastName" : "Doe"},
	{"firstName" : "Anna", "lastName" : "Smith"},
	{"firstName" : "Peter", "lastName" : "Jones"}
]
```

[2] 직렬화 및 역직렬화

- 서버와 클라이언트(브라우저)가 연결하여 데이터를 주고받을때 사용

- 직렬화(Object => JSON)  `stringify(obj)`

  ```
  클라이언트에서 서버로 객체를 전송할 때 JSON의 문자열로 변환해서 보냄.
  객체안의 메소드는 JSON문자열로 만들어지지 않는다.
  
  stringify(value:any, replacer? : (this:any, key:string, value:any) => any, space? : ...) : string;
  
  어떤타입이든 string으로 변환
  replacer?는 callback함수. 옵션으로 좀 더 세밀한 문자열로 통제하고 싶을 때 사용
  ```

- 역직렬화(JSON => Object `parse(json)`

  ```
  클라이언트가 서버로부터 JSON의 문자열 데이터를 받아 객체로 변환해서 사용.
  
  parse(text:string, reviver? : (this:any, key:string, value:any) => any) : any;
  
  json문자열을 어떤 타입의 객체로 변환
  reviver?는 callback함수. 옵션으로 좀 더 세밀한 객체로 조정하고 싶을 때 사용
  ```

  