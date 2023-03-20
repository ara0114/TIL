**현재상태 확인**
<br>
<img src="https://user-images.githubusercontent.com/103404127/226261023-f96dd505-a5c0-4632-b655-731a071256e6.png">
<img src="https://user-images.githubusercontent.com/103404127/226261031-7ad69763-c6a2-45de-99ee-4bdbfa2034ef.png">
위와 같은 내용의 SQL을 실행하면 아래와 같은 상태를 확인할 수 있다.
<img src="https://user-images.githubusercontent.com/103404127/226261042-7ab459ea-2cd8-4e53-a861-1880f7c986c0.png">

## 신규 그룹(4번그룹)/멤버 추가

### 1. 신규 그룹 및 멤버 추가
<img src="https://user-images.githubusercontent.com/103404127/226261252-e41f3790-8c41-4dee-9496-b12b20a53c14.png">
신규 그룹(4번그룹)과 멤버 redo04_a.log, redo04_b.log 파일을 생성해 추가해준다.<br>
조회하면 4번그룹으로 2개의 멤버가 한번도 사용하지 않은 UNUSED상태로 조회됨을 확인할 수 있다.<br>

### 2. 강제 로그 스위치 발생
<img src="https://user-images.githubusercontent.com/103404127/226261461-317cafba-0c29-4eb5-9c94-da299a4c4d4e.png">
<img src="https://user-images.githubusercontent.com/103404127/226261469-bd570dde-9bd3-41f1-8c3c-403acbbcfe2e.png">

로그 스위치를 발생시키면 LGWR이 3번 그룹에서 4번그룹으로 기록파일을 바꿨음을 확인할 수 있다.
- 3번그룹 상태: CURRENT → ACTIVE
- 4번그룹 상태: UNUSED → CURRENT
<br>
또한 3번그룹상태는 ACTIVE로 로그파일에 있는 내용 중 DB Buffer Cache에서 데이터파일로 저장되지 못한 내용이 있음을 알 수 있다.<br>

### 3. 강제 체크포인트 발생
<img src="https://user-images.githubusercontent.com/103404127/226261649-d96132b4-3842-49a1-b911-dcfb5a95aacc.png">
<img src="https://user-images.githubusercontent.com/103404127/226261677-0447c01c-969a-4599-9659-fe90479985e0.png">

체크포인트를 발생시키면
DBWR이 로그파일에 있는 내용 중 DB Buffer Cache에서 데이터파일로 저장되지 못한 변경사항들을 내려쓰게 되고 이에 따라 ACTIVE였던 3번그룹이 INACTIVE상태로 변경되었음을 확인할 수 있다.<br>

## 신규 그룹(4번그룹)/멤버 삭제

### 1. 강제 로그 스위치 발생
<img src="https://user-images.githubusercontent.com/103404127/226262151-d3ca63a8-db52-4f3f-a994-30c0743ba188.png">
<img src="https://user-images.githubusercontent.com/103404127/226262163-f25b806b-a606-4fac-a297-62336db00128.png">

로그 스위치를 발생시키면 LGWR이 4번 그룹에서 1번그룹으로 기록파일을 바꿨음을 확인할 수 있다.
- 4번그룹 상태: CURRENT → ACTIVE
- 1번그룹 상태: INACTIVE → CURRENT
<br>
또한 4번그룹상태는 ACTIVE로 로그파일에 있는 내용 중 DB Buffer Cache에서 데이터파일로 저장되지 못한 내용이 있음을 알 수 있다.<br>

### 2. 강제 체크포인트 발생
<img src="https://user-images.githubusercontent.com/103404127/226262502-11143f74-0d91-4863-85fe-39b423fef9a7.png">
<img src="https://user-images.githubusercontent.com/103404127/226262514-84da5bbe-8d3c-463a-8af7-af399bf1c7b0.png">

체크포인트를 발생시키면
DBWR이 로그파일에 있는 내용 중 DB Buffer Cache에서 데이터파일로 저장되지 못한 변경사항들을 내려쓰게 되고 이에 따라 ACTIVE였던 4번그룹이 INACTIVE상태로 변경되었음을 확인할 수 있다. 해당 파일을 삭제하고 싶다면 이렇게 INACTIVE상태로 만들어줘야 한다.<br>

### 3. 멤버 삭제
<img src="https://user-images.githubusercontent.com/103404127/226262616-de80b6b4-67cf-4f37-9009-c82dc3c15c0b.png">

파일시스템일 경우
alter database drop logfile member ~ 명령은 단지 컨트롤 파일 안에 있는 멤버의 정보만 지울뿐 실제 파일은 지우지 못함.(ASM기반에서는 지울 수 있음.)<br>
해당 명령 실행후 파일을 확인하면 아직 파일이 남아있음을 확인할 수 있다.<br>
실제 파일을 지우기 위해서는 위에 명령 실행 후 DBA가 수동으로 해당 파일을 직접 지워야 한다.<br>

<img src="https://user-images.githubusercontent.com/103404127/226262874-3a8ee79c-3178-425f-995c-bc8c8ddef829.png">

수동으로 삭제 명령 실행 후, 파일을 확인하면 삭제됨을(찾을 수 없음) 확인할 수 있다.<br>
<img src="https://user-images.githubusercontent.com/103404127/226262908-9203df04-08ca-4e35-b4d1-e23cbc41a9d3.png">

또한 4번그룹에 삭제한 redo04_b.log는 사라지고 redo04_a.log만 남았음을 확인할 수 있음.<br>
<img src="https://user-images.githubusercontent.com/103404127/226262950-0ad9a6fe-c433-4bc1-b1da-b1d31631a0b9.png">

이렇게 그룹에 멤버가 1개일 경우, 해당 멤버를 삭제하려고 명령을 실행하면 
마지막 멤버는 삭제할 수 없다고 나온다. ⇒ 삭제 하기 위해서는 그룹을 지워야 한다.<br>

### 4. 그룹 삭제
<img src="https://user-images.githubusercontent.com/103404127/226263215-2877dc40-5ae3-47ea-b826-12962742cd01.png">
<img src="https://user-images.githubusercontent.com/103404127/226263225-b49ced91-a177-403c-b64b-0266e04374fb.png">

그룹 삭제 명령 실행 후 조회하면 리두로그파일에서는 정보가 사라지지만<br>
<img src="https://user-images.githubusercontent.com/103404127/226263301-95a479ea-20d9-454e-a76f-2248e6074141.png">

멤버 삭제 때 처럼 실제 파일은 지워지지 않았음을 볼 수 있다.<br>
<img src="https://user-images.githubusercontent.com/103404127/226263307-e965faef-dfd1-4d75-acbf-772008328b64.png">

실제 파일 삭제를 위해 수동으로 명령을 실행하여 삭제해준다.<br>
