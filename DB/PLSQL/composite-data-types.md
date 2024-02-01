# 복합타입

## 레코드

- 레코드 타입, %TYPE속성, %ROWTYPE속성으로 선언가능
- TYPE 타입명 IS RECORD (변수명 변수타입, 변수명 변수타입, …);

## 컬렉션

- 컬렉션 타입과 컬렉션 변수의 %TYPE속성으로 선언
- Associative Arrays, VARRAYs, Nested Tables

### Associative Arrays

- 해시테이블과 유사.(키와 값으로 구성)
- 작은 크기의 조회 테이블 용도로 사용
- TYPE 타입명 IS TABLE OF 데이터타입 [NOT NULL] INDEX BY 인덱스타입
- 인덱스 타입은 PLS_INTEGER와 문자타입 사용가능
- 초기화 불필요/생성자 X

### VARRAYs

- 배열과 유사
- 선언 시 컬렉션 최대 크기 지정
- 순차적으로 조회하는 용도로 사용
- TYPE 타입명 IS VARRAY(사이즈) OF 데이터타입 [NOT NULL]
- 생성자로 초기화해야 사용가능. value 기술하지 않으면 빈 컬렉션으로 초기화
    - 컬렉션타입 (값, 값, …)
- 인덱스타입은 정수

### Nested Tables

- VARRAY와 유사
- 최대 크기 지정X, 중간 엘리먼트 삭제가능
- 최대 크기가 미정이고 순차조회하지 않는 일부를 갱신하거나 삭제하는 용도로 사용
- TYPE 타입명 IS TABLE OF 데이터타입 [NOT NULL]
- 인덱스타입은 정수
