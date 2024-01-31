# Oracle - PostgreSQL 차이
|Oracle|PostgreSQL|
|:---:|:---:|
|SYSDATE|NOW()|
|DUAL|DUAL없이 SELECT 1|
|ROWNUM|LIMIT|
|DECODE|CASE|
|NVL|COALESCE|
|""은 NULL|""은 공백문자열|
|시퀀스명.NEXTVAL|NEXTVAL('시퀀스명')|
|CAST|::변환할 데이터타입|
|CONNECT BY|WITH RECURSIVE|
|CLOB|TEXT|
|MERGE INTO|쿼리문분리|
