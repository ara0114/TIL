# 패키지

- 여러 항목을 모아 하나로 묶어놓은 객체
- 장점
    - 모듈화
    - 관리의 용이성
    - 캡슐화
    - 성능

## 구조

### SPEC(선언부)

```sql
CREATE OR REPLACE PACKAGE 패키지명 IS

	FUNCTION 함수명(매개변수, ...)
	RETURN 변수;
	...

	PROCEDURE 프로시저명(매개변수, ...)
	...

END 패키지명;
```

### BODY(본문)

```sql
CREATE OR REPLACE PACKAGE BODY 패키지명 IS

	FUNCTION 함수명(매개변수, ...)
	RETURN 변수
	IS
	...
	BEGIN
	...
		RETURN 변수;
	END 함수명;
	...

	PROCEDURE 프로시저명(매개변수, ...)
	IS
	...
	BEGIN
	...
	END 프로시저명;
	...

END 패키지명;
```

## 실행

```sql
EXEC 패키지명.프로시저명(매개변수, ...);

SELECT 패키지명.함수명(매개변수, ...) FROM DUAL;
```

## 삭제

```sql
-- 패키지 삭제(SPEC, BODY모두)
DROP PACKAGE 패키지명;
-- 패키지 본문 삭제(BODY)
DROP PACKAGE BODY 패키지명;
```
