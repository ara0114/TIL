# Redo Log 관리

- Redo Log File: 장애를 대비해 변경사항을 모두 기록해두는 파일.
- Redo Log Buffer: Redo Log File이 기록되는 장소. 메모리

## Redo Log 생성원리

- 오라클에서 데이터 변경(DDL,DML,TCL)이 발생했을때 Redo Log에 기록됨

### Redo Log 기록 메커니즘

- Write Log Ahead
    - DBWR이 작동하기 전, LGWR이 작동하는 것
    - Redo Log는 복구 관련 중요 정보가 저장되어 있으므로, 기본적으로 데이터를 실제 변경하기 전에 Redo Log에 먼저 기록 후 데이터를 변경
- Log force at Commit
    - 사용자로부터 Commit 요청이 들어오면 관련된 모든 Redo Record들을 Redo Log File에 저장한 후 Commit을 완료함.
    
    ⇒ Redo Log File에 기록하지 않고는 Commit을 완료하지 않음.
    
    - 대량의 데이터 변경 후 commit이 한 번에 수행되면 성능에 악영향을 주는 경우가 많이 발생
    
    ⇒ 아주 짧은 시간 동안 Delayed commit이나 commit을 모아 한꺼번에 수행하는 Group Commit 기술 등장
    
    **Group Commit*: 짧은 시간동안 많은 데이터가 변경된 후 한꺼번에 commit요청이 들어올 경우 많이 발생
    
    - LGWR이 관련된 Redo Log를 다 기록한 후 DBWR이 데이터를 기록하는 동기식 커밋 성능 문제
    
    ⇒ 10g부터 비동기식 커밋 기술 등장
    
    **commit_write* 파라미터
    
    - WAIT: 변경된 트랜잭션이 Redo log file에 기록될 때까지 기다림
    - NOWAIT: WAIT과 반대로 Redo log file에 기록될 때까지 기다리지 않음
    - IMMEDIATE: commit요청이 들어오면 즉시 Redo log file에 기록하기 시작
    - BATCH: commit요청이 들어오더라도 일정 시간 모아서 한꺼번에 기록
    - 일반적으로 2개씩 조합해 사용.
    - 비동기식 커밋: NOWAIT이나 BATCH. 안정성 보장되지 않으므로 OLTP환경에서는 주의
    - 동기식 커밋: 비동기식보다 안정성은 좋으나 성능에서 떨어짐

### 생성원리

1. 특정 데이터의 변경을 요청하는 쿼리 수행 → 서버 프로세스는 원하는 블록을 DB buffer cache에 있는지 확인
- 없다면 해당 블록을 데이터 파일에서 찾아 복사한 후 메모리(DB buffer cache)로 가져옴
2. 해당 블록의 해당 로우 부분을 다른 사용자가 바꿀 수 없도록 해당 블록에 lock설정.(page fix)
- 서버 프로세스는 PGA에서 Redo Change Vector를 생성

 **Change Vector*: 변경된 데이터를 나중에 복구할 목적으로 Redo log에 기록할 변경된 데이터에 대한 모든 정보의 세트. undo관련 내용까지 함께 저장

3. 서버 프로세스는 Redo Log Buffer에서 필요한 용량 계산. + Redo Log Buffer에 복사하기 위해 필요한 Latch를 획득해야 함 ⇒ Redo Copy Latch
- Redo Copy Latch: change vector가 모두 redo log buffer에 기록될 때까지 계속 갖고 있어야 함. → 여러 개가 존재.(기본값은 CPU개수*2), *_log_simultaneous_copies* 파라미터로 개수 조정 가능

**Latch:* 한정된 메모리 자원을 여러 사용자가 사용할 때 서로 먼저 자원을 확보하기 위해 충돌이 일어나는 것을 막기위한 순서를 정리해주기 위한 장치. 번호표

4. Redo Copy Latch확보 후, Redo Log Buffer에 내용을 기록하기 위해 Redo Allocation Latch를 확보해야 함.
- Redo Allocation Latch: Redo Log Buffer에 내용을 기록하기 위함. 1개만 존재 ⇒ 데이터 변경 많이 되는 서버라면 확보를 위한 경합으로 속도저하 될 수 있음.
- Shared Redo Strand기능 도입(9i~)하여 Redo Log Buffer를 디스크 파티션과 같이 여러 개로 나누어 동시작업으로 성능 높이기

**Strand:* 여러 개로 분할된 영역. *LOG_PARALLELISM*값으로 설정.(설정 없으면 1).

- 오라클이 동적으로 관리하도록 *_LOG_PARALLELISM_DYNAMIC*파라미터 추가(TRUE: 자동제어, 권장 값 CPU개수/8)
- Private Redo Strand기능 도입(10g~): 각 서버 프로세스는 Shared Pool에 자신만의 독립적인 Private Strand 공간을 만들어 그곳에 Change Vector생성 후 필요할 경우 LGWR이 Redo Log File에 바로 기록 ⇒ Latch를 확보하여 Redo log Buffer에 기록해야 하는 과정을 줄여 성능 향상
- Redo log Buffer에 기록하지 않는 기능을 *zero copy redo*라 함

  ⇒ *_LOG_PRIVATE_PARALLELISM=TRUE*로 설정하면 활성화. 기본값은 사용 안함.

5. Redo Record Format으로 로우 단위로 Redo Log Buffer에 복사
6. Redo Log Buffer에 기록된 내용들은 특정 상황이 되면 LGWR이 일부를 Redo Log File에 기록한 후 기록된 Redo Entry(Change Vector)들을 Redo Log Buffer에서 삭제(flush)

   ⇒ 서버 프로세스가 Redo Writing Latch를 확보한 후 LGWR에게 Redo Log Buffer에 있는 내용을 Redo Log File에 기록하라고 요청

### Redo Log Buffer에 있는 내용을 Redo Log File로 기록하는 경우

1. 3초마다
    - LGWR은 할 일이 없을 때 sleep상태로 되었다가 rdbms ipc message라는 대기 이벤트 timeout시점인 3초마다 한 번씩 wakeup하여 Redo Log Buffer에서 Redo Log File로 기록해야 할 내용 있는지를 찾아 기록 후 buffer에서 해당내용 삭제
2. Redo Log Buffer의 전체크기의 1/3이 찼거나 1M가 넘을 경우
    - 서버 프로세스는 Redo Log Buffer 할당 받을 때마다 현재 사용된 log Buffer의 Block수 계산함

       if 현재 사용된 log Buffer수 > _LOG_IO_SIZE

       then LGWR에 Redo Log Buffer의 내용을 Redo log File에 기록하도록 요청

       **_LOG_IO_SIZE*: LGWR이 Redo Log Buffer의 내용을 Redo log File로 내려쓸 임계값 지정. 자주 내려쓸 경우 안정성은 좋아지나 전체적 성능은 저하되는 경우 많으므로 값 조정 잘 해야함.

       9i까지는 Redo Log Buffer크기의 1/3이었으나 10g부터 1/6로 변경(기준 절반으로 줄어듦)

1. 사용자가 COMMIT또는 ROLLBACK을 수행할 때(트랜잭션 종료)
    - 커밋이나 롤백 수행 시 SCN이 생성되어 해당 트랜잭션에 할당되고 관리
2. DBWR이 LGWR에게 쓰기를 요청할 때
    - DBWR이 LGWR의 on-disk RBA값보다 큰 high-RBA값을 가진 BLOCK을 데이터 파일로 기록해야 할 때 해당 Block을 Differed Writed Queue에 먼저 기록한 후 LGWR을 수행시켜 해당 Redo Log Buffer를 Redo log file로 먼저 내려쓰고 Data Block을 기록하는 방식으로 Sync를 맞춤.
    
    **RBA*: Redo Byte Address
    

## Redo Log File 구성 및 관리

### 구성

- 그룹과 멤버라는 개념으로 관리하고 그룹은 같은 내용을 여러 곳에 중복으로 저장하는 개념
- 같은 그룹일 경우 멤버들을 같은 내용을 담고 있음.
    - 하나의 멤버가 삭제되거나 장애가 발생해도 다른 멤버가 존재하여 데이터 안전 지킬 수 있음.
- 멤버 많이 추가할 경우 안정적일 수 있지만 기록시간이 늘어나 부하를 줄 수 있음.
- 멤버 수 적으면 시간은 짧지만 안정성에 문제될 수 있음.
- 같은 그룹의 멤버는 절대 동일한 디스크에 함께 두지 않음 ⇒ 디스크 장애 날 경우 그룹전체가 손상 + 장애가 나지 않더라도 모든 멤버들이 동시에 기록되고 한개의 멤버에 기록 마친 후 다음 멤버에 기록하게 되므로 성능/안정 문제
- 최소그룹 수는 2개, 각 그룹별로 최소 멤버는 1개 ⇒ 심각한 장애 발생할 수 있으므로 그룹 최소3개, 최소멤버 2개이상 권장
- Log Switch: LGWR이 Redo Log Buffer의 내용을 Redo Log File에 내려쓸 때 해당 파일이 가득차면 다음 그룹으로 넘어가는 것
    - 로그스위치 발생할 경우 checkpoint신호 발생.
    ⇒ DBWR이 해당 로그파일에 있는 내용 중 DB Buffer Cache에서 데이터 파일로 저장되지 못한 변경사항들을 내려씀. ⇒ 데이터파일과 컨트롤파일에 반영
    - 로그스위치가 일어나는 그룹순서는 라운드 로빈 방식으로 알아서 결정됨
- 순환해서 사용.
- LGWR은 Redo Log File의 그룹에 멤버가 여러 개일 경우 병렬로 동시에 같은 내용 기록.(같은 디스크에 있다면 직렬 기록)
    - 병렬쓰기 중 문제가 발생할 경우 LGWR은 오픈 로그 멤버의 상태 조사하여 어떤 파일에서 에러가 발생되는지 알아냄
    - 장애가 난 멤버는 컨트롤파일에 STALE상태로 기록.
    - 백그라운드 Trace File에 에러기록.
    - LGWR이 하나의 로그파일에서 4개이상의 에러 만날 경우 로그파일 닫고 더이상 그 파일에 내용 기록X
    - LGWR이 어떤 로그파일에도 내용을 기록할 수 없다면 에러 발생시키고 Shutdown Abort(강제종료)
- 크기는 각 서버 실정에 맞게 사용하면 됨. Redo Log File의 권장 크기 정해지지 않음
    - 너무 작으면 로그스위치 자주발생 → DB운영성능 저하
    - 너무 크면 데이터 손상 가능성
- Alert LOG File에 checkpoint not completed메시지 나오면 멤버 크기 크게 만들거나 그룹 더 만들어야 함
    - checkpoint not completed: Log Switch 너무 빈번하게 발생할 경우 DBWR이 이전에 발생한 Checkpoint내용을 데이터 파일에 다 기록 못한상태에서 다시 로그 스위치가 발생하여 checkpoint신호가 들어올 경우에 주로 발생. ⇒ Redo Log파일 크기나 Redo Log Group 수 증가

### Redo Log File 관리

- 주요 명령어
1. 신규 group(4) 생성
    
    ```sql
    alter databse add logfile group 4 '/u01/app/oracle/oradata/ORCL/redo04_a.log' size 5M;
    ```
    
2. Member 추가
    
    ```sql
    alter database add logfile member '/u01/app/oracle/oradata/ORCL/redo04_b.log' to group 4;
    ```
    
3. Member 삭제
    
    ```sql
    alter database drop logfile member '/u01/app/oracle/oradata/ORCL/redo04_b.log';
    ```
    
4. Group 삭제
    
    ```sql
    alter database drop logfile group 4;
    ```
    
5. 강제로 Log Switch발생
    
    ```sql
    alter system switch logfile;
    ```
    
6. 강제로 Checkpoint발생
    
    ```sql
    alter system checkpoint;
    ```
    
- Redo Log File의 상태
    - CURRENT: 현재 LGWR이 내용을 기록하고 있는 상태
    - ACTIVE: Redo Log File의 내용이 아직 DB Buffer Cache에서 Data file로 저장이 안되어서 지워지면 안되는 상태
    - INACTIVE: Redo Log File의 내용이 Data file에도 다 저장이 되어서 삭제되어도 된다는 의미.
    - UNUSED: 한 번도 사용한 적이 없는 상태
    - DBA가 Redo Log File을 삭제하고 싶다면 반드시 INACTIVE 상태로 만들고 3,4번 명령어로 삭제 수행해야 함.


## SCN과 Checkpoint

### SCN(System Commit Number)

- 커밋 발생할 때마다 트랜잭션에 생성되는 고유번호. 트랜잭션단위로 할당됨.(DML문장단위X)
- 오라클은 SCN정보로 DB문제유무를 판별하고 문제가 있다면 복구를 수행함
- 트랜잭션을 관리/장애시 복구
- SCN base(4bytes) + SCN Wrap(2bytes)로 구성.
    - base값 전부 다 사용하게 되면 wrap값이 하나씩 증가되어 사용.
    - 만약 SCN이 모두 다 사용되면 다시 0으로 reset. 새로운 Incarnation(시즌같은개념)으로 할당되어 다시 시작
- Sequence에서 발생시키는 것이 아니라 kcmgas(steve adams개발)라는 function으로 구현.
- SCN이 기록되는 곳
    - Control File Header
        - checkpoint발생시
        - Resetlogs발생시
        - Incomplete Recovery수행시
    - Data Block(cache layer)
        - Block cleanout시 마지막 SCN을 각 Block에 기록
        
        There is no specific instruction to follow. Please provide a clear and specific instruction to get an output that can be inserted in the document.
        
    - Data Block(Transaction layer-ITL entries)
        - Delayed Block cleanout시 ITL(Interested Transaction List) Entries에 커밋된 SCN정보 기록
    - 모든 Data File Headers
        - 마지막 checkpoint발생 시
        - Begin Backup수행 시
        - 복구가 되었다면 사용된 마지막 SCN을 기록
    - Redo Records / Log Buffer
        - 커밋 수행시 커밋 레코드에 SCN을 포함하여 저장
    - Rollback Segment(Undo Segment), Tablespace Headers
- System Change Number.
    - Data file, Redo log file, Control file간의 동기화 맞추기 위해 사용
    - SCN base(4bytes) + SCN Wrap(2bytes) + SCN sequence(1byte)로 구성
        - SCN sequence는 동일한 SCN Block을 여러개 서버프로세스가 동시에 변경할 경우 구분하기 위해 사용
    - SCN이 기록되는 곳
        - Data block Header, Redo records, Segment Header에 기록

### Checkpoint

- 커밋된 데이터를 어디까지 저장했는지 확인하기 위해 만든 개념
- 해당 data file의 복구를 결정하는 기초적인 정보
- 각 파일의 checkpoint정보를 비교하고 다르면 틀린부분을 redo log나 archived redo log를 참조해 복구
- Checkpoint 종류
    - Database / Global checkpoint: DB Buffer cache내에 있는 모든 저장안된 Dirty buffer들의 내용을 전부 데이터 파일로 저장(full checkpoint). 저장된 SCN중 가장 번호가 큰 SCN번호(checkpoint SCN)를 Control file과 Data file Header부분에 기록
    - Thread checkpoint / Logical checkpoint: 해당 Thread내의 모든 저장안된 Dirty buffer들을 Datafile로 전부 내려씀. 로그 스위치 발생 시 생성. Single Instance일 경우 Database checkpoint와 동일. RAC환경일 경우 각 노드별로 다르게 발생.
    - Data file checkpoint: 특정 data file에만 발생. 해당 tablespace를 offline하거나 begin backup수행시 발생. 해당 정보를 control file과 data file Header부분에 기록
    - Mini checkpoint: drop table처럼 특정한 DDL발생 시 특정 블록에만 발생하는 checkpoint
    - Recovery checkpoint: data file에 장애가 발생했을 때 백업된 데이터 파일 복원 후 Redo change vector적용 → recovery된 블록을 데이터 파일 저장할때 발생하는 checkpoint
- checkpoint에 우선순위를 두어 관리 → 우선순위가 높은 것부터 진행
    - 높을 경우 fast checkpoint
    - 낮을 경우 low checkpoint
