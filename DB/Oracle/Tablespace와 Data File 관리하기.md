# Tablespace와 Data File

- 오라클은 메모리에 논리적인 Tablespace 공간을 만들어 작업하고 디스크에 물리적인 Data File을 만들어 저장

## SYSTEM Tablespace

- SYS계정 소유이며, 데이터 딕셔너리들이 저장됨 ⇒ 이 정보를 참고해 운영되므로 손상될 경우 오라클 서버 시작X
- 데이터 딕셔너리
    1. 오라클에서 사용하는 거의 모든 메타 정보나 운영 관련된 중요 정보를 저장하고 있는 아주 중요한 테이블이나 뷰
        
        - 데이터베이스 논리적 구조, 물리적 구조 정보
        
        - 객체 정의와 공간 사용 정보
        
        - 제약조건 관련 정보
        
        - 사용자 관련 정보
        
        - Role, Privilege등의 관련 정보
        
        - 감사 및 보안 관련 정보
        
    2. 크게 Base Table과 Data Dictionary View로 나뉨
        
        - Base Table: 데이터베이스 생성시 생성. 사람 접근X → 내용 조회할 수 있도록 Data Dictionary View제공
        
        - Data Dictionary View
        
        - DBCA를 사용해 데이터베이스 생성시 자동 생성되지만 Create Database명령어로 데이터베이스 수동 생성시 자동으로 생성되지 않음(catalog.sql을 실행해줘야함.)
        
        - Static Dictionary와 Dynamic Dictionary로 나뉨
        
    3. Static Dictionary: 실시간으로 변경X. 인스턴스 open일 경우만 조회
        
        - USER_XXX: 해당 사용자가 생성한 내용만 볼 수 있는 딕셔너리
        
        - ALL_XXX: 해당 사용자가 생성한 것과 생성하지 않았더라도 접근이 가능한 내용(SELECT권한 받은 내용)을 볼 수 있는 딕셔너리.
        
        - DBA_XXX: 데이터베이스에 생성되어 있는 모든 내용을 다 볼 수 있는 딕셔너리. DBA권한을 가지고 있는 사용자만 조회 가능
        
    4. Dynamic Dictionary: 조회시점 데이터 실시간으로 알 수 있음. `v$` 로 시작. 인스턴스 NOMOUNT 상태부터 조회

## SYSAUX Tablespace

- 주로 오라클 서버의 성능 튜닝을 위한 데이터들 저장

## 일반 Tablespace

- 일반적으로 가장 많이 사용되는 테이블스페이스
- 관리자가 필요에 의해 만드는 것으로 언제든 만들고 삭제 가능

## UNDO Tablespace

- Undo data: 사용자가 DML을 수행할 경우 발생하는 원본 데이터
- Undo data 만을 저장하는 segment를 Undo segment. Undo segment를 저장하는 테이블 스페이스를 Undo Tablespace라 함.
- 관리자가 생성/관리. Undo data외에 저장 불가.
- Undo data라도 사용자가 관여X, 서버프로세스가 직접 관리
- 특징
    1. 서버 프로세스는 테이블 스페이스에 undo segment를 생성하고 각 사용자별로 할당하여 undo data관리. 사용자는 관여X
    2. 테이블 스페이스는 Instance당 여러 개가 동시에 존재할 수 있음. 사용되는 것은 한 번에 1개.
    3. 9i부터는 자동 AUM(Automatic Undo Management)방법 권장
        
        - 초기화 파라미터 파일의 Undo_management=auto로 설정(수동관리는 manual)
        
        - 수동방법(manual)은 undo관련 장애가 발생했을 경우 복구 용도로 많이 사용.
        
        - 파라미터 값 변경할 경우 인스턴스 재시작해야 적용
        
- 사용목적
    1. Transaction Rollback
        
        : 사용자가 rollback 명령 수행할 경우 이곳에 저장된 undo data이용해 rollback
        
    2. Read Consistency(읽기 일관성)
        
        : CR(consistent Read)작업을 통해 트랜잭션이 끝나지 않은 데이터는 변경 전 데이터 보여줌
        
    3. Transaction Recovery(Instance Recovery)
        
        : 운영중이던 DB서버가 비정상 종료되었을 때 Roll Forward와 Roll Backward작업을 수행해 dirty database를 clean database로 만들어 주는 과정에서 undo data 사용
        
- Undo segment의 할당원리
    1. undo data file크기는 증가만 되고 줄어들지 않음. => commit을 해도 해당 undo segment안에 undo data는 지워지지 않고 남아 있기 때문.(다른 서버 프로세스가 덮어쓸 수 있게 할 뿐 자료를 삭제하는 것이 아님)
    2. 사용하지 않는 undo tablespace의 크기가 비정상적으로 클 경우 다른 작은 크기의 undo tablespace를 신규로 만들고 변경시킨 후 기존 undo tablespace삭제
- 관련된 주요 파라미터
    1. UNDO_RETENTION
        
        - commit후에도 해당 undo segment내의 데이터를 다른 서버 프로세스가 덮어쓰지 못하도록 막아주는 시간 → *ORA-01555. Snapshot too old* 에러 방지
        
        - 주로 CR(Consistence Read)작업으로 undo segment의 데이터 조회하는 경우에 많이 발생
        
        - undo segment여분이 있을 경우에만 적용. 모든 undo segment 사용중 일 경우 적용X
        
        - undo segment여분이 없을 경우 설정값이 무시되고 undo segment가 재사용됨.
        
        - 10g부터는 자동으로 관리하는 기능 제공.
        
    2. UNDO_RETENTION_GUARANTEE
        
        - UNDO RETENTION로 설정된 시간 동안 재활용하지 않고 데이터 지켜줌.
        
        - commit을 해도 undo segment를 특정시간동안 재활용하지 않아 undo tablespace의 사용량이 증가될 수 있음. → 기본값은 *NOGUARANTEE,* 즉 사용안함.
        

## TEMPORARY Tablespace

- 임시 자료를 저장하는 테이블 스페이스. DB가 재시작되면 내용 모두 사라짐.
- PGA공간이 부족하면 이곳을 이용하여 정렬작업, export, import등 여러가지 작업 수행
- 하나의 Instance에 여러 개 만들 수 있음. -> 성능향상을 위해 각 사용자별로 하나씩 할당해 주는 것이 좋음.
- 여러 개의 Temporary Tablespace중 반드시 1개를 Default Temporary Tablespace로 지정해야 함
- Default Temporary Tablespace는 독자적인 Temporary Tablespace를 할당 받지 못한 사용자나 System Temporary Tablespace가 사용하는 Temporary Tablespace를 의미함
- 11g버전 이상일 경우 Temporary Tablespace Group 기능 활용 권장
- Temporary Tablespace Group
    - 임시테이블 스페이스를 여러 개 만든 후 그룹으로 묶어주고 특정 schema에게 temporary tablespace group을 지정해 주는 것.
    => 하나의 스키마로 여러 명의 사용자가 동시에 로그인하더라도 사용자 각각 그룹안에 있는 여러 개의 temp tablespace를 별도로 사용해 성능 향상
