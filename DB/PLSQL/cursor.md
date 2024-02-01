# 커서

- SQL 처리 반환값을 저장하는 메모리공간에 대한 포인터
- 결과 집합 처리하는데 사용

## 종류

### Implicit Cursor(묵시적커서)

- 속성
    - %FOUND: 해당 SQL문에 의해 반환된 행의 수가 1개 이상일 경우 true
    - %NOTFOUND: 해당 SQL문에 의해 반환된 행이 없을 경우 true
    - %ISOPEN: 항상 false. 커서가 열려 있는지 여부 검색
    - %ROWCOUNT: 해당 SQL문에 의해 반환된 행의 수. 가장 최근 수행된 SQL문에 의해 영향을 받은 행의 갯수(정수)

### Explicit Cursor(명시적커서)

- 속성
    - %FOUND: Fetch한 데이터가 행을 반환하면 true
    - %NOTFOUND: Fetch한 데이터가 행을 반환하지 않으면 true
    - %ISOPEN: 커서가 open상태이면 true
    - %ROWCOUNT: 현재까지 반환된 모든 행의 수
- 사용
    
    ```sql
    DECLARE
    	CURSOR 커서명 IS SELECT구문;
    BEGIN
    	OPEN 커서명;
    	FETCH 커서명 INTO 로컬변수;
    	CLOSE 커서명;
    END;
    ```
    
    - DECLARE: 커서 정의
    - OPEN: 커서 선언 시 작성한 SQL문 실행.
    - FETCH
        - 실행된 결과 행 정보를 한줄씩 가져와 변수에 저장. 필요한 작업을 수행
        - LOOP와 함께 사용하기도함.
        - 한줄 FETCH가 끝나면 다음행으로 이동
        - 현재 데이터행을 OUTPUT변수에 반환
        - 커서의 SELECT문 컬럼수, 변수타입과 OUTPUT 변수의 수,타입이 동일해야함
    - CLOSE: 커서 종료.
- CURSOR FOR LOOP
    - FOR LOOP이 자동으로 커서 OPEN, FETCH, CLOSE
    - ROWTYPE에 해당하는 변수 따로 DECLARE 필요없음
    
    ```sql
    FOR 레코드명 IN 커서명 LOOP
    	SQL문;
    END LOOP;
    ```
