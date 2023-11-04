# 데이터 이동

- 디렉토리 객체: 서버의 파일 시스템에 있는 물리적 디렉토리를 나타내는 논리적 구조.
특정 운영체제 디렉토리의 위치를 포함.
SYS유저의 소유. 디렉토리 이름은 데이터베이스에서 고유함.
클라이언트가 아닌 서버에 있는 파일을 액세스 하므로 파일 위치 지정시 디렉토리 객체 필요

## 주요 작동 구성요소

- DBMS_DATAPUMP: 대량의 데이터/메타 데이터 이동을 위한 고속 export 및 import 유틸리티용 API포함
- Direct Path API(DPAPI): unload/load 시 데이터 변환 및 구문 분석을 최소화
- DBMS_METADATA: 모든 메타데이터 unloading/loading을 위한 작업자 프로세스에 사용. XML을 이용해 데이터베이스 객체 정의 저장
- External Table API: ORACLE_DATAPUMP 및 ORACLE_LOADER 액세스 드라이브 사용해 External Table에 데이터 저장할 수 있음
- SQL*Loader: External Table과 통합되어 External Table 액세스 파라미터에 Loader Control File 자동 이전
- expdp 및 impdp: DBMS_DATAPUMP 패키지 호출 ⇒ Data Pump 작업 시작/모니터 하는 Thin layer
- 기타 클라이언트: replication(복제), Transportable TBS, 유저 응용프로그램 등 데이터 이동 Infrastructure를 활용하는 응용프로그램. SQL *Plus는 진행중 작업에 대한 간단항 상태 쿼리를 위해 DBMS_DATAPUMP의 클라이언트로 사용될 수 있음.

## Oracle Data Pump

- 오라클 데이터베이스에서 데이터/메타 데이터를 매우 빠른 속도로 로드/언로드 할 수 있음
- DBMS_DATAPUMP를 통해 호출할 수 있음
- Direct path 또는 External Table중 사용할 데이터 액세스 방식을 자동결정
    - Direct path: 테이블 구조가 Direct path를 허용하고 최대의 단일 스트림 성능이 요구되는 경우
    - External Table: 클러스터화 된 테이블, 참조 무결성 제약조건, 암호화된 열 또는 기타 여러항목이 있는 경우
- 장시간 실행되는 작업에서 작업에 영향을 주지 않고 분리했다가 재연결 가능(작업실행 중 여러위치에서 작업을 모니터 할 수 잇음)
- 중단된 모든 작업은 메타 정보가 그대로 남아있으면 데이터 손실없이 재시작 될 수 있음.
- 장점 - 관련 파라미터
    - 세분화 된 객체 및 데이터 선택 - EXCLUDE, INCLUDE, CONTENT
    - 데이터베이스 버전 명시적 지정 - VERSION
    - 병렬 실행 - PARALLEL
    - export 작업공간 소비량 예측 - ESTIMATE_ONLY
    - 분산환경 네트워크 모드
    - 재매핑 기능
    - 데이터 샘플링 및 메타 데이터 압축 - COMPRESSION
    - Data pump export중 데이터 압축 - SAMPLE
    - 암호화를 통한 보안
    - XML Type 데이터를 clob로 export하는 기능
    - 이전 import 및 export파일을 지원하는 레거시 모드

## Data Pump export & import Client

- export: 덤프파일 세트. 일련의 운영체제 파일. 데이터/메타데이터를 언로드하는 유틸리티
- import: 엑스포트 덤프파일세트에 저장된 데이터/메타데이터를 대상 시스템으로 로드하는데 사용
- Data Pump API: 클라이언트가 아닌 서버 팡리 액세스
- 네트워크 모드: 유틸리티를 사용해 원격데이터베이스에서 덤프파일 세트로 바로 엑스포트 하거나 중간에 개입하는 파일 없이 소스 데이터베이스에서 바로 Target Database를 로드할 수 있음. 읽기전용원본 데이터베이스의 데이터 엑스포트할때 유용
- 마스터 테이블: data pump작업을 실행하는 유저의 스키마에 생성되는 테이블. 작업의 모든 측면 유지 관리. 작업이 정지되는 경우 data pump를 재시작하는 수단. data pump 정상완료시 삭제. 
파일기반 엑스포트 작업동안 구축. 덤프파일세트에 기록.
파일기반 임포트 작업의 첫단계는 현재유저의 스키마로 로드하는 작업. 모든 객체를 연속적으로 생성하는데 사용
- 인터페이스: data pump 엑스포트/임포트와 상호작용할 수 있음
    - 명령행 -대부분의 엑스포트 파라미터 지정가능
    - 파라미터파일 - 모든 명령행 파라미터 지정할 수 있음(PARFILE제외)
    - 대화식 명령행 - 터미널 로깅 중단. 명령행/파라미터파일로 시작한 엑스포트작업중 CTRL+C 누르면 이 모드 활성화. 실행중인 작업 또는 정지된 작업 연결시에도 활성화
    - GUI 인터페이스 - Schema > database Export/import 선택
- 모드: 데이터베이스의 서로 다른 부분을 로드취소/로드 할 수 있게함. 각 모드 적절한 파라미터 사용해 명령행에서 지정.
    - 전체
    - 스키마
    - 테이블
    - 테이블스페이스
    - Transportable 테이블스페이스
    - Transportable 데이터베이스
- import 변형 적용
    - REMAP_DATAFILE: 서로 다른 파일 시스템 의미를 사용하는 플랫폼 간에 데이터베이스 이동시 유용
    - REMAP_TABLESPACE: 객체를 한 테이블 스페이스에서 다른 테이플 스페이스로 이동할 수 있음
    - REMAP_SCHEMA: 객체 소유권을 변겨알 수 있는 이전의 FROMUSER/TOUSER기능을 제공
    - REMAP_TABLE: 전체 테이블의 이름을 바꾸는 기능을 제공
    - REMAP_DATA: 삽입중인 데이터를 재매핑할 수 있는 기능을 제공

### SQL*Loader

- 데이터를 External파일에서 오라클 데이터베이스의 테이블로 로드
- 데이터 파일의 데이터 형식을 거의 제한하지 않는 강력한 데이터 구문 분석 엔진이 있음
- 사용하는 파일
    - 입력 데이터 파일
    - Control file: SQL *Loader에 로드할 데이터 위치, 데이터 형식, 메모리관리, 레코드 선택 및 거부 기준, 중단된 로드 처리 등 구성 세부사항, 데이터 조작 사항 알려줌
    - 로그파일
    - Bad file
    - Discard file

### External Table

- 오라클 데이터베이스 외부의 운영체제에 파일로 저장되는 읽기 전용 테이블
- DDL구성
    - 오라클 데이터베이스 열 유형
    - 오라클 데이터베이스 데이터 열에 대한 External 데이터 매핑 기술
- 데이터, 데이터 저장방법을 기술하는 것이 아닌 External table layer에서 서버에 데이터 어떻게 표시해야하는지를 기술
- 액세스 드라이버
    - ORACLE_LOADER: External Table에서 테이블 데이터를 읽는데에만 사용, 이를 데이터베이스에 로드. 텍스트파일을 데이터 소스로 사용함
    - ORACLE_DATAPUMP: External파일의 테이블 데이터를 데이터베이스에 로드, 데이터베이스의 데이터를 External 파일로 언로드 할 수 도 있음. 바이너리파일을 External파일로 사용함.
- 장점
    - External파일에서 직접 데이터를 사용하거나 다른 데이터베이스로 데이터를 로드할 수 잇음.
    - External데이터는 먼저 로드할 필요 없이 데이터베이스에 상주하는 테이블과 병렬로 직접 조인 및 쿼리할 수 있음
    - 복합 쿼리의 결과는 External 파일로 언로드할 수 있음.
    - 로드를 이해 다른 소스에서 생성된 파일을 결합할 수 있음.
- 정보 확인
    - [DBA | ALL | USER]_EXTERNAL_TABLES: 데이터베이스에 있는 External Table의 특정 속성
    - [DBA | ALL | USER]_EXTERNAL_LOCATIONS: External Table의 데이터소스
    - [DBA | ALL | USER]_TABLES: 데이터베이스에 있는 관계형 테이블에 대한 설명
    - [DBA | ALL | USER]_TAB_COLUMNS: 데이터베이스에 있는 테이블 열, 뷰 및 클러스터에 대한 설명
    - [DBA | ALL]_DIRECTORIES: 데이터베이스에 있는 디렉토리 객체에 대한 설명
