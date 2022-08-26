## ER Diagram 쉽게 만들기(MySQL)

MySQL워크벤치-Database-Reverse Engineer

![image](https://user-images.githubusercontent.com/103404127/184905925-91fce660-6c3b-482d-b54e-05569d0236ad.png)

커넥션옵션설정 및 DBMS 연결후 원하는 스키마 선택

![image](https://user-images.githubusercontent.com/103404127/184906573-4e7cab92-1a79-426d-97fd-e6c500b2d664.png)

다음 단계들 모두 NEXT진행하면 ERDiagram을 쉽게 생성할 수 있음





## 테이블 정의서 쉽게 만들기(MySQL)

아래의 쿼리 입력

```mysql
SELECT
   t1.table_name, t1.table_comment, column_name, data_type, column_type, column_key, is_nullable, column_default, extra, column_comment
FROM
   (SELECT
       table_name, table_comment
    FROM
       information_schema.TABLES WHERE table_schema='스키마명') t1,
   (SELECT
       table_name, column_name, data_type, column_type, column_key, is_nullable, column_default, extra, column_comment, ordinal_position
    FROM
       information_schema.COLUMNS WHERE table_schema='스키마명') t2
WHERE
    t1.table_name = t2.table_name
ORDER BY
    t1.table_name, ordinal_position;
```



