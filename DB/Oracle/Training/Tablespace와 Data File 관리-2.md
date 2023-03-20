## Undo Tablespace

**현재상태 확인**
<br>
<img src="https://user-images.githubusercontent.com/103404127/226367506-f8ebe6e9-9bc0-4743-9572-513efd5db3d7.png">
<br>UNDO 파라미터는 위와 같이 조회된다. UNDOTBS1을 UNDO Tablespace로 사용하고 있다.<br>

### Undo Tablespace 생성

<img src="https://user-images.githubusercontent.com/103404127/226367830-835cebce-eb99-459f-add5-75d36b983d8b.png">
<img src="https://user-images.githubusercontent.com/103404127/226367841-26b693ef-2a4c-4d0f-93b2-3399319b12ab.png">

새로운 UNDO테이블 스페이스를 만들고 DBA_DATA_FILES를 조회하면 위와 같이 확인할 수 있다.<br>

### Undo Tablespace 변경

```sql
ALTER SYSTEM SET UNDO_TABLESPACE=변경할TBSname;
```

<img src="https://user-images.githubusercontent.com/103404127/226368533-02248d8d-6298-4dde-95c0-8e89196b0784.png">

Alter명령으로 사용하는 TBS를 바꾸고 UNDO파라미터를 조회하면<br>
undo_tablespace가 UNDOTBS1에서 UNDO01로 바뀌었음을 확인할 수 있다.<br>

          
### Undo 관련 주요 파라미터 조회/변경/취소

<img src="https://user-images.githubusercontent.com/103404127/226368793-de651b11-73d4-4f54-8132-8332094d6ea4.png">

DBA_TABLESPACE를 조회하여 현재 테이블스페이스의 RETENTION을 확인할 수 있다. NOT APPLY는 적용대상이 아니고, 현재 UNDOTBS1과 UNDO01은 기본값인 NOGUARANTEE로 설정되어 있다.<br>

```sql
ALTER TABLESPACE 변경할TBSname RETENTION [GUARANTEE | NOGUARANTEE];
```

<img src="https://user-images.githubusercontent.com/103404127/226369062-0802d6b9-eb75-4541-9003-009556b29c1c.png">
          
Alter 명령으로 GUARANTEE를 변경 적용하고 다시 취소(NOGUARANTEE)할 수 있다.<br>

### Undo Tablespace 삭제

<img src="https://user-images.githubusercontent.com/103404127/226369271-694ea14b-ec2f-46b2-9c76-e66b1cd5ab30.png">

Drop 명령으로 사용하지 않는 undo tablespace를 삭제할 수 있다.<br>
사용중인 undo segmnet를 포함하고 있다면 삭제할 수 없고,<br>
사용중이 아닌데 사용중이라 뜨며 삭제가 안될 경우 undo segment를 강제로 offline후 삭제<br>
( _offline_rollback_segment 파라미터 사용)<br>

## Temporary Tablespace

**현재상태 확인**
<br>
<img src="https://user-images.githubusercontent.com/103404127/226369818-f016f58f-0d45-4f0c-a39e-5319bc3c7c91.png">

DBA_DATA_FILES가 아닌 *DBA_TEMP_FILES* 를 조회하여 Temporary Tablespace를 확인할 수 있다<br>

### 신규 Temporary Tablespace 생성

<img src="https://user-images.githubusercontent.com/103404127/226370201-3114044e-4783-49ce-8d63-d7a77728a7a3.png">
<img src="https://user-images.githubusercontent.com/103404127/226370218-4e0c99f4-18c6-4eeb-ade8-a14497d80c16.png">

CREATE 할 때, 일반이나 UNDO처럼 DATAFILE이 아닌 *TEMPFILE* 을 지정하여 생성하고,<br> 
*DBA_TEMP_FILES* 를 조회하여 생성한 TEMP2 Temporary Tablespace를 확인할 수 있다.<br>

### Default Temporary Tablespace 조회/변경

<img src="https://user-images.githubusercontent.com/103404127/226370570-cbe60846-73fe-45e2-b647-d8058b1bc5d0.png">

```sql
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE 변경할TBSname;
```

위의 Alter문을 사용하여 설정값을 변경할 수 있고,<br>
*DATABASE_PROPERTIES* 를 조회하면 설정된 Default Temporary Tablespace를 확인할 수 있다.<br>

### Temporary Tablespace 크기 변경

<img src="https://user-images.githubusercontent.com/103404127/226370945-8d126581-e9f8-4aad-b80e-c6dae185be3a.png">

크기 변경시에도 생성이나 조회처럼 TEMPFILE을 사용하고(DATAFILE아님) resize하여 크기를 변경할 수 있다. 용량이 부족할 경우 정렬작업이나 exprot/import작업시 에러가 발생할 수 있음.<br>
<img src="https://user-images.githubusercontent.com/103404127/226371170-041fa619-7822-40ad-8214-0d5b7350cf35.png">

*DBA_TEMP_FILES* 를 조회하여 TEMP2의 크기가 10M에서 100M로 변경되었음을 확인할 수 있다.<br>

### Temporary Tablespace 삭제

<img src="https://user-images.githubusercontent.com/103404127/226371434-00ce3f53-d50d-4f98-8ee9-db5a3bd99629.png">

Drop 명령으로 Temporary tablespace를 삭제할 수 있는데<br>
이때, default temporary tabalespace는 삭제가 안된다. <br>
<img src="https://user-images.githubusercontent.com/103404127/226371554-09b54a4d-df72-4b4b-9265-c368054a9373.png">

삭제를 위해 TEMP3로 default temporary tablespace를 변경하고
다시 Drop명령을 실행하면 TEMP2를 삭제할 수 있다.<br>

### Temporary Tablespace Group 생성/조회/추가(변경)

<img src="https://user-images.githubusercontent.com/103404127/226371794-e4a2009c-01af-4d52-bb96-d7d139092ed4.png">
<img src="https://user-images.githubusercontent.com/103404127/226371876-f73ef869-e6ba-4aa5-9a4b-29755a4536a4.png">

Temporary tablespace를 생성할 때 GROUP을 지정해주고<br>
DBA_TABLESPACE_GROUPS를 조회하면 테이블 스페이스와 할당되어 있는 그룹을 조회할 수 있다.<br>
<img src="https://user-images.githubusercontent.com/103404127/226372082-d3e583d6-7014-4166-a747-fceb3cc5f625.png">

또한 이미 만들어져 있는 테이블 스페이스를 ALTER로 그룹에 추가할 수도 있다.<br>
<br>
그 외 명령들
- 만들어진 그룹을 사용자에게 할당

<img src="https://user-images.githubusercontent.com/103404127/226372540-aa032dc2-f308-467f-86df-f89ac97623c0.png">

- 디폴트로 지정
<img src="https://user-images.githubusercontent.com/103404127/226372556-45bf213e-2316-4dd3-bb8f-71b1c3709d97.png">

- 그룹탈퇴
<img src="https://user-images.githubusercontent.com/103404127/226372581-423fcec0-7057-4468-93f9-1b49b8a74298.png">

