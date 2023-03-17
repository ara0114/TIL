# lock 확인 및 해제

## 1. TEST 테이블 생성 후 lock 발생
<img src="https://user-images.githubusercontent.com/103404127/225814060-1a89e6ca-83e7-4edd-a38f-0fb96f0aed26.png">
SESSION2 - LOCK이 걸려 실행되지 않음을 볼 수 있다.

## 2. lock이 걸린 테이블 조회
```sql
SELECT DO.OBJECT_NAME, DO.OWNER, DO.OBJECT_TYPE, DO.OWNER,
       VO.XIDUSN, VO.SESSION_ID, VO.LOCKED_MODE
FROM V$LOCKED_OBJECT VO, DBA_OBJECTS DO
WHERE VO.OBJECT_ID = DO.OBJECT_ID;
```
<img src="https://user-images.githubusercontent.com/103404127/225814534-af7b9a9f-47ad-4c0d-a369-06605250dfa5.png">

## 3. lock 발생 사용자와 SQL, OBJECT 조회
```sql
SELECT DISTINCT X.SESSION_ID, A.SERIAL#, D.OBJECT_NAME, A.MACHINE, A.TERMINAL,
       A.PROGRAM, B.ADDRESS, B.PIECE, B.SQL_TEXT
FROM V$LOCKED_OBJECT X, V$SESSION A, V$SQLTEXT B, DBA_OBJECTS D
WHERE X.SESSION_ID = A.SID AND X.OBJECT_ID = D.OBJECT_ID
AND A.SQL_ADDRESS = B.ADDRESS
ORDER BY B.ADDRESS, B.PIECE;
```
<img src="https://user-images.githubusercontent.com/103404127/225814761-2c5985a3-e63c-4918-b334-d11f50ff984a.png">
lock이 발생한 세션의 ID와 SERIAL넘버, 발생한 SQL문을 확인할 수 있다.

## 4. TEST 테이블에 lock이 걸렸는지 확인
```sql
SELECT A.SID, A.SERIAL#, B.TYPE, C.OBJECT_NAME
FROM V$SESSION A, V$LOCK B, DBA_OBJECTS C
WHERE A.SID = B.SID AND B.ID1 = C.OBJECT_ID
AND B.TYPE = 'TM' AND C.OBJECT_NAME IN('TEST');
```
<img src="https://user-images.githubusercontent.com/103404127/225814931-94c6a2fb-b2b4-4306-9835-63844c624b4c.png">
lock 세션의 SID, SERIAL넘버를 확인하고 TM 락이 걸려있음을 확인할 수 있다.

## 5. lock 세션 죽이기
```sql
-- [ALTER SYSTEM KILL SESSION 'SESSION_ID, SERIAL#']
ALTER SYSTEM KILL SESSION '390, 33376';
ALTER SYSTEM KILL SESSION '445, 38386';
```
<img src="https://user-images.githubusercontent.com/103404127/225815087-e00ba8ff-a49e-48db-a9f8-bf1819130def.png">
죽인 후, TEST 테이블에 lock이 걸렸는지 확인하면 위와 같이 나오며<br>
실행이 되지 않던 SESSION2에서 아래와 같이 오류 메세지가 나온다. 
<img src="https://user-images.githubusercontent.com/103404127/225815158-8ae3ef6a-97f3-40ff-a854-f5e110c6bced.png">

**해당 세션 KILL하는 SQL만들기**
```sql
SELECT DISTINCT X.SESSION_ID, A.SERIAL#, D.OBJECT_NAME, A.MACHINE, A.TERMINAL,
       A.PROGRAM, A.LOGON_TIME, 'ALTER SYSTEM KILL SESSION'''||A.SID||', '||A.SERIAL#||''';'
FROM GV$LOCKED_OBJECT X, GV$SESSION A, DBA_OBJECTS D
WHERE  X.SESSION_ID = A.SID AND X.OBJECT_ID = D.OBJECT_ID
ORDER BY LOGON_TIME;
```
<img src="https://user-images.githubusercontent.com/103404127/225815301-f0a1df00-d93a-4cd0-bb99-07741ddcfd4f.png">
마지막 칼럼에 만들어진 SQL문을 활용하여 세션을 죽일 수 있다.
