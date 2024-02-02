# 예외

- 실행블록에서 예외 발생하면 제어가 예외블록으로 이동하여 예외를 처리

```sql
DECLARE
...
BEGIN
...
EXCEPTION
	WHEN exception THEN
		statements;
	WHEN OTHERS THEN
		statements;
...
END;
```

## 유형

### 내부정의 예외

- SQLCODE함수
- SQLERRM함수

### 사전정의 예외

- STANDARD 패키지에 정의되어있는 예외

### 사용자정의 예외

- `예외명 EXCEPTION` 로 선언
- `PRAGMA EXCEPTION_INIT(예외명, 에러코드)` 로 예외와 에러코드 연결가능
- 사전정의 예외는 재정의하지않는편이 바람직함.

## 예외 발생

- `RAISE [예외명]`
    - RAISE문을 사용하여 사전정의 예외와 사용자정의 예외를 발생시킬 수 있음.
    - 예외를 기술하지 않을경우 마지막으로 발생한 예외 다시 발생시킴
- `RAISE_APPLICATION_ERROR(에러코드, 에러메세지, 에러스택에 추가T/F)`
    - RAISE_APPLICATION_ERROR 프로시저를 사용하여 지정한 에러코드와 에러메세지로 예외 발생시킬 수 있음.
    - keeperrorstack 파라미터(에러스택에 추가) 는 기본적으로 false. true로 설정시 에러스택에 에러 추가
