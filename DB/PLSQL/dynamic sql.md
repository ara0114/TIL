# 동적쿼리

- 실행 시 문장이 만들어져 실행되는 쿼리
- 동적쿼리가 필요한 경우
    - 컴파일 시 SQL문 확정할 수 없을 경우
        - 실행시점에 따라 WHERE절 조건이 달라질때
    - PL/SQL블록에서 DDL문을 실행해야할 경우
        - PL/SQL 의 블록에서는 DDL문 실행불가
    - PL/SQL 블록에서 ALTER SYSTEM/SESSION 명령어를 실행해야할 경우
- 사용시 유의사항
    - 동적쿼리는 유효한 PL/SQL 블록이어야함.
    - 쿼리문장은 세미콜론으로 끝나야함
    - 동적 쿼리 블록은 global object에만 접근가능해야 함
    - 예외는 동적 PL/SQL 블록 외부에서 처리되어야 함

## 실행

### EXECUTE IMMEDIATE

```sql
-- 단일값 리턴받거나 DML구문 실행

EXECUTE IMMEDIATE 동적쿼리;
EXECUTE IMMEDIATE 동적쿼리 [USING [IN|OUT|IN OUT] 바인드변수, ...]; 
EXECUTE IMMEDIATE 동적쿼리 [INTO {변수, ...}][USING [IN|OUT|IN OUT] 바인드변수, ...]; -- 단일행 반환
EXECUTE IMMEDIATE 동적쿼리 [BULK COLLECT INTO {변수, 레코드 등...}][USING [IN|OUT|IN OUT] 바인드변수, ...]; -- 여러행 반환할 경우
```

### OPEN-FOR, FETCH and CLOSE

```sql
-- 한개 이상 로우를 결과집합으로 반환하는 SELECT문을 커서로 리턴 받을때 

OPEN 커서명 
FOR 동적쿼리
[USING [IN|OUT|IN OUT] 바인드변수, ...];
FETCH 커서명 INTO 변수, 레코드, ...;
CLOSE 커서명;
```
