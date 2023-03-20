## 일반 Tablespace 생성 및 조회

<img src="https://user-images.githubusercontent.com/103404127/226279612-db940a3e-b09f-4cbc-b8fc-48c234807518.png">
시스템 TABLESPACE와 일반 TABLESPACE는 영구 테이블스페이스로<br>
일반 TABLESPACE를 만들고 데이터파일을 조회하면 CONTENTS가 PERMANENT로 나옴을 확인할 수 있다.<br>
또한 데이터 파일을 조회하여 테이블 스페이스의 경로를 확인할 수 있다.<br>

## 각 Data File의 실제 사용량 확인

<img src="https://user-images.githubusercontent.com/103404127/226279807-36e42666-d763-4a23-8368-f62423a5cf26.png">

다음과 같은 문장으로 조회를 하면
<img src="https://user-images.githubusercontent.com/103404127/226279819-b8772a37-e666-48cf-9537-2acf97499605.png">

데이터 파일의 용량, 전체 블록, 사용 블록, 사용량을 확인할 수 있다.<br>
HAKSA는 아직 사용하지 않았으므로 처음 만들 때 지정한 크기 1MB중 사용량은 0%이다.<br>

## Tablespace 용량 관리

<img src="https://user-images.githubusercontent.com/103404127/226280292-ae175bfd-5e1f-4aec-b6d6-57288cf8efb7.png">
<img src="https://user-images.githubusercontent.com/103404127/226280301-0cf2f229-9434-4cdf-b932-e9f3b43dbaf6.png">

*DBA_DATA_FILES* 를 조회하여 현재 상태를 확인할 수 있다.<br>
용량관리를 위해<br>
HAKSA 테이블 스페이스에 iphak 테이블 만들고 가득 차게 해서 장애를 발생시키면<br>

<img src="https://user-images.githubusercontent.com/103404127/226280421-f3686b3a-4a2b-4722-a8a9-95d2cc8b1701.png">

위와 같이 “ORA-01653”(테이블스페이스의 공간이 부족해서 데이터가 들어갈 수 없을 때 발생하는 에러)가 발생하며,
해결방법은 **1. Data file을 하나 더 추가해주는 것** 과 
          **2. Data file을 크게 늘려주는 방법(자동/수동)** 이 있다.<br>
          
### 1. Tablespace에 Data file 추가

<img src="https://user-images.githubusercontent.com/103404127/226281213-259edef6-4dce-47fb-81d3-0a2989c77124.png">
<img src="https://user-images.githubusercontent.com/103404127/226281219-2cd7141a-5424-46ed-97fb-7b35e404d144.png">
<img src="https://user-images.githubusercontent.com/103404127/226281227-71ab0ae5-7850-48f2-968a-57f1a845f9c4.png">
          
위와 같이 HAKSA 테이블 스페이스에 데이터 파일을 추가해주고 
(CREATE가 아닌 *ALTER ~ ADD* 명령)
*DBA_DATA_FILES* 을 조회하면 방금 추가한 데이터 파일을 확인할 수 있다.<br>

### 2. Data file 크기 수동 증가

<img src="https://user-images.githubusercontent.com/103404127/226281518-f8e011ed-72da-47d9-8758-64e035db7ff1.png">

*ALTER ~ resize* 명령으로 데이터 파일 크기를 증가시킬 수 있고
<img src="https://user-images.githubusercontent.com/103404127/226281534-394d697c-cfa6-4abb-9411-f81261c0eba9.png">

*DBA_DATA_FILES* 을 조회했을 때
haksa01 데이터 파일 크기가 1MB에서 20MB로 증가했음을 확인할 수 있다.<br>

### 3. Data file 크기 자동 증가

<img src="https://user-images.githubusercontent.com/103404127/226281759-d20fa185-e6fd-444a-92da-96e191c03b68.png">

위처럼 autoextend on을 사용하여 자동으로 용량이 늘어나게 설정할 수 있고,
(32비트 오라클의 경우 파일 1개 최대 16GB까지, 64비트 오라클의 경우 32GB까지)<br>
<img src="https://user-images.githubusercontent.com/103404127/226281768-7a547dc7-7713-4298-abab-fe0af47c1cf0.png">
<img src="https://user-images.githubusercontent.com/103404127/226281776-a09a6780-0b3b-4328-89ea-5db65f026d6a.png">

*DBA_DATA_FILES* 을 조회하여
각 데이터 파일의 autoextend 유무를 확인해보면 방금 autoextned on을 설정한 haksa01은 YES이지만, 설정하지 않은 haksa02의 경우 NO로 확인된다.<br>
테이블에 데이터를 많이 삽입했을 때 처음처럼 ORA-01653에러가 발생하지 않고 정상 실행되며,<br>
*DBA_DATA_FILES* 을 조회하면 공간크기가 20에서 30.5로 자동 증가 했음을 확인할 수 있다.<br>
<img src="https://user-images.githubusercontent.com/103404127/226282030-204d5463-1473-4537-9c11-454909106cc3.png">

## Tablespace offline

- 사용자가 더 이상 해당 테이블 스페이스에 접근을 못하게 하는 것
- 해당 테이블스페이스만 shutdown시키는 것과 같음.
- 테이블스페이스를 오프라인 하면 그 파일들에는 새로운 정보가 저장되지 않음.
- 특정 데이터 파일의 위치를 이동하거나 특정 테이블 스페이스가 장애가 나서 복구해야 할 때 유용하게 사용.
- 테이블 스페이스 전체를 오프라인 할 수도 있지만 특정 데이터 파일만 오프라인 할 수도 있음.
- 3가지 방법이 있고 Normal mode, Temporary mode,  Immediate mode가 있음.
  - Normal: 테이블 스페이스에 아무런 문제가 없을 때 정상적으로 수행하는 방법(기본)
  - Temporary: 현재 오프라인 시키고자 하는 테이블스페이스의 데이터파일이 하나라도 이상이 생길 경우 사용
  - Immediate: archive log mode일 경우에만 사용. 데이터 파일에 장애가 나서 데이터를 내려쓰지 못하는 상황에서 테이블 스페이스 오프라인 해야 할 경우에 사용. 나중에 해당 테이블 스페이스를 온라인 할 때 복구하라고 메시지가 나옴.

<img src="https://user-images.githubusercontent.com/103404127/226282453-17e560bf-1cf9-4d1b-9c8a-b9ad6b17ecd5.png">
<img src="https://user-images.githubusercontent.com/103404127/226282466-d7df6c62-f175-4376-803f-d1c1f986f4eb.png">

위의 문장은 DB가 archive log mode일때만 사용할 수 있어서,
no archive log mode일 때 실행하면 다음과 같은 에러가 발생한다.<br>

<img src="https://user-images.githubusercontent.com/103404127/226282613-7f55c63f-e17f-4464-924d-ae64c85d247c.png">

no archive log mode일때는 offline drop으로 강제로 offline 시킬 수 있는데 드롭 후 online할 경우 복구가 필요한 상태로 변경된다.<br>

<img src="https://user-images.githubusercontent.com/103404127/226282793-7eff6e3b-4b70-4405-baba-2873e0e1da7a.png">
<img src="https://user-images.githubusercontent.com/103404127/226282798-5635bf0f-b589-4a29-8a0b-1f18dd6f8832.png">

어떤 DATAFILE이 offline인지는 위의 명령으로 조회해서 사용할 수 있다.<br>
OFFLINE과 ONLINE변경은 다음과 같이 수행할 수 있다.<br>
<img src="https://user-images.githubusercontent.com/103404127/226283035-d40798b5-552a-40df-875f-a89765a87acb.png">
<img src="https://user-images.githubusercontent.com/103404127/226283126-c401a2f4-935d-4ec5-936a-4a8342517bd6.png">

TBS1은 offline상태여서 checkpoint SCN이 다른 파일들과 다르다 <br>
→ 다시 online을 시켜도 SCN은 여전히 다른 상태<br>
이 경우에 백업을 받으면 복구에 문제 생길 수 있음.<br>
→ 수동으로 체크포인트 발생시키면 모두 동기화됨(동기화 후 백업 받으면 된다)<br>

<img src="https://user-images.githubusercontent.com/103404127/226283561-197d90ca-8db9-4387-ab35-0c154c1f5514.png">

강제로 체크포인트 발생시키면 RECOVER상태를 제외한 나머지는 SCN이 동기화가 된다.<br>
<img src="https://user-images.githubusercontent.com/103404127/226283837-f620204c-60ca-47d5-8c33-5e9aa63c4d4d.png">

HAKSA 테이블스페이스 중 haksa01 데이터파일이 offline상태이므로 HAKSA 테이블스페이스를 offline하려면 normal mode로는 불가능<br>
<img src="https://user-images.githubusercontent.com/103404127/226284017-a1fe003d-5937-4e8c-89dc-59946105dffb.png">

Temporary mode로 offline하면 정상 실행된다.<br>
<img src="https://user-images.githubusercontent.com/103404127/226284119-03006a60-cee8-4320-ae0d-18dee8d23298.png">
<br>
<img src="https://user-images.githubusercontent.com/103404127/226284144-26d6e323-4832-4f48-b89a-f3f9d9fde472.png">

RECOVER를 수행 후 online하면 복구는 되었지만 다른 테이블 스페이스와 SCN이 다르다.<br>
<img src="https://user-images.githubusercontent.com/103404127/226284331-5fc02e2b-4440-444d-ab50-92df4cfcff14.png">
<img src="https://user-images.githubusercontent.com/103404127/226284342-224d25f0-f5bb-425f-aeaa-d2b892e77109.png">
<img src="https://user-images.githubusercontent.com/103404127/226284356-c4bb40bb-d2e2-462f-86ac-4d415ab95d8b.png">

위처럼 offline후 online할 경우 반드시 체크포인트를 수행하여 SCN번호를 동기화 시켜준다.<br>

## Tablespace 삭제

<img src="https://user-images.githubusercontent.com/103404127/226285043-f57a3b0f-37fe-49b0-91ef-eed0305a451b.png">
<img src="https://user-images.githubusercontent.com/103404127/226285054-83bb50a3-f33b-4351-b6aa-f62c4305fc76.png">

Drop명령으로 테이블 스페이스를 삭제할 수 있는데 <br>
테이블 스페이스 안에 테이블이 하나라도 있으면 그냥 지워지지 않고<br>
*INCLUDING CONTENTS* 옵션을 사용해야 한다.<br>
<img src="https://user-images.githubusercontent.com/103404127/226285070-17f4ec85-f564-45b2-81e6-c76f8b8d3151.png">
<img src="https://user-images.githubusercontent.com/103404127/226285090-1179c711-73a3-4554-9bd4-e25c87cae960.png">

옵션을 사용한 문장은 정상적으로 실행되고<br>
*DBA_DATA_FILES* 를 조회할 경우 해당 테이블 스페이스가 삭제되어 보이지 않음을 확인할 수 있다.<br> 
