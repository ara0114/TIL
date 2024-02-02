# 함수

- 특정 기능들을 모듈화, 재사용
- 호출한 곳으로 반드시 하나의 값을 리턴해야함
- 식의 일부로 사용
- 작성 시 권한 필요
    - 자신의 스키마: CREATE PROCEDURE
    - 다른 사용자 스키마: CREATE ANY PROCEDURE

## 생성

```sql
CREATE OR REPLACE FUNCTION 함수명(매개변수1, 매개변수2, ... )
RETURN 데이터타입 -- 반환값의 데이터타입
IS
변수 데이터타입;
... -- 변수, 상수 등 선언
BEGIN
... 
/* SELECT 리턴값 INTO 변수 FROM DUAL WHERE 1 = 변수; */
... -- 실행부
RETURN 변수; -- 반환
END;
```

## 호출

```sql
함수명(값, 값, ...)

-- 예시
SELECT 함수명(값) FROM DUAL;
```

## 삭제

```sql
DROP FUNCTION 함수명;
```
