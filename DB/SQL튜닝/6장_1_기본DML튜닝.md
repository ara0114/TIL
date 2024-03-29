## DML성능에 영향을 미치는 요소

- 인덱스, 무결성 제약, 조건절, 서브쿼리, REDO로깅, UNDO로깅, LOCK, 커밋

### 인덱스와 DML성능

- INSERT
    - 테이블: Freelist를 통해 입력할 블록 할당
    - 인덱스: 수직탐색을 통해 입력할 블록 할당
- DELETE
    - 테이블: 레코드 하나 삭제
    - 인덱스: 모든 인덱스 레코드 찾아 삭제
    - 테이블에서 레코드 하나 삭제하면 인덱스 레코드 모두 찾아 삭제
- UPDATE
    - 테이블: 변경된 컬럼 수정
    - 인덱스: 변경된 컬럼 참조하는 인덱스만 찾아 변경
    - 테이블에서 한 건 변경할 때마다 인덱스는 2개 오퍼레이션 발생
        - 인덱스는 정렬된 자료구조이므로 변경 시 저장위치도 달라지므로 삭제 후 삽입
- 인덱스 개수가 DML성능에 미치는 영향 매우 큼

### 무결성 제약과 DML 성능

- 개체 무결성(Entity Integrity)
- 참조 무결성(Referential Integrity)
- 도메인 무결성(Domain Integrity)
- 사용자 정의 무결성(또는 업무 제약조건)
- PK, FK 제약이 Check, Not Null 제약보다 성능에 더 큰 영향
    - Check, Not Null: 제약조건 준수여부만 확인
    - PK, FK: 실제 데이터 조회

### 조건절과 DML 성능

- 인덱스 튜닝 원리를 그대로 적용하여 성능 개선 가능

### 서브쿼리와 DML 성능

- 조인 튜닝 원리를 그대로 적용하여 성능 개선 가능

### REDO로깅과 DML 성능

- REDO로그: 트랜잭션 유실됐을 때 트랜잭션을 재현하여 유실 이전 상태로 복구하는데 사용(과거를 현재상태로 되돌림)
    - 오라클은 데이터 파일과 컨트롤 파일에 가해지는 모든 변경사항을 REDO로그에 기록
    - 사용 용도
        - Database Recovery
        - Cache Recovery(Instance Recovery시 roll forward단계)
        - Fast Commit
- DML 수행할 때마다 REDO로그 생성 → DML성능에 영향
    - INSERT작업에서 REDO로깅 생략기능 제공

### UNDO 로깅과 DML 성능

- UNDO로그: 변경된 블록을 이전 상태로 되돌리는데 필요한 정보를 로깅. 롤백.(현재를 과거상태로 되돌림)
    - 사용 용도
        - Transaction Rollback
        - Transactino Recovery(Instance Recovery시 rollback단계)
        - Read Consistency
- DML 수행할 때마다 UNDO 생성 → DML 성능에 영향
    - UNDO 세그먼트에 기록
    - 기록한 공간은 해당 트랜잭션이 커밋하는 순간, 다른 트랜잭션이 재사용할 수 있는 상태로 바뀜
    - 가장 오래전에 커밋한 공간부터 재사용. 언젠가 다른 트랜잭션에 의해 OVERWRITE됌
- 생략할 방법 없음

### LOCK과 DML 성능

- DML성능에 매우 크고 직접적인 영향
- 필요 이상으로 자주, 길게 사용하거나 레벨을 높일 수록 DML성능 느려짐
- 너무 적게, 짧게 사용하거나 필요한 레벨이하로 낮추면 데이터 품질 나빠짐
- DML성능과 데이터 품질을 위해 매우 세심한 동시성 제어 필요
    - 동시성 제어(Concurrency Control): 동시에 실행되는 트랜잭션 수를 최대화(고성능)하면서도 입력, 수정, 삭제, 검색 시 데이터 무결성을 유지(고품질)하기 위해 노력하는 것

### 커밋과 DML 성능

- DML과 별개로 실행하지만 DML을 끝내려면 커밋해야하므로 밀접한 관련
- LOCK에 의해 DML이 블로킹 된 경우, 커밋은 DML성능과 직결됌
    - DML을 완료할 수 있게 LOCK을 푸는 키가 커밋
- 트랜잭션 데이터 저장과정
    - DML 문을 실행하면 REDO 로그버퍼에 변경사항 기록
        - 오라클은 데이터를 변경하기 전 항상 로그부터 기록(Write Ahead Logging)
    - 버퍼블록에서 데이터를 변경(레코드 추가/수정/삭제).
        - 버퍼캐시에서 블록을 찾지 못하면 데이터 파일에서 읽는 작업부터
    - 커밋
    - LGWR 프로세스가 REDO로그 버퍼내용을 로그파일에 일괄 저장(디스크 I/O작업, Write Ahead Logging)
    - DBWR 프로세스가 변경된 버퍼블록들은 데이터 파일에 일괄 저장
- LGWR, DBWR프로세스는 주기적으로 깨어나 각각 파일에 기록. LGWR은 커밋시점에도 깨어나 기록(Log Force at Commit)
- 커밋 = ‘저장’
    - 그때까지 수행한 작업을 디스크에 기록
    - 너무 오랫동안 커밋하지 않거나(undo공간 부족 → 시스템 장애 상황 유발) 자주 커밋하는 것(프로그램 자체 성능 매우 느려짐)은 문제

## 데이터베이스 Call과 성능

### 데이터베이스 Call

- SQL 수행 단계
    - Parse Call : SQL 파싱과 최적화 수행 단계. SQL과 실행계획을 라이브러리캐시에서 찾으면 최적화 단계는 생략가능
    - Execute Call : SQL을 실행하는 단계.
    - Fetch Call : 데이터를 읽어 사용자에게 결과집합을 전송하는 과정. 전송할 데이터가 많을 경우 여러번 발생. SELECT문에서만 나타남.
- Call 발생위치에 따른 분류
    - User Call : 네트워크를 경유해 DBMS 외부(WAS 또는 AP서버)로부터의 Call. DBMS 입장에서 사용자는 WAS 또는 AP서버
    - Recursive Call : DBMS 내부에서 발생하는 Call. SQL파싱과 최적화 과정에서 발생하는 데이터 딕셔너리 조회, PL/SQL로 작성한 사용자 정의 함수/프로시저/트리거에 내장된 SQL을 실행할 때 발생하는 Call.
    - SQL 실행할 때 마다 Parse, Execute, Fetch call 단계 거침
    - 데이터베이스 Call 많으면 성능 느릴 수 밖에 없고, 네트워크 경유하는 User Call은 성능에 미치는 영향 매우 큼

### 절차적 루프 처리

- 루프를 돌며 건건이 Call이 발생하더라도 네트워크를 경유하지 않는 Recursive Call은 비교적 빠름
- 루프안에 commit 위치 시킬 경우 성능 저하
- 자바 내부 루프 로직은 네트워크를 경유하는 User Call로 성능이 나빠짐

### One SQL의 중요성

- 업무로직이 복잡하면 절차적으로 처리할 수 밖에 없지만 그렇지 않다면 가급적 One SQL로 구현하려 노력
- 절차적 프로그램을 One SQL로 구현하는데 유용한 구문 활용법
    - Insert Into Select
    - 수정가능 조인 뷰
    - Merge 문

## Array Processing활용

- 실무에서는 복잡한 업무 로직을 포함하여 절차적 프로그램을 One SQL로 구현하는 일이 쉽지않음
- One SQL으로 구현하지 않고 Array Processing을 활용해 Call부하를 줄일 수 있음

## 인덱스 및 제약 해제를 통한 대량 DML 튜닝

- 인덱스와 무결성 제약조건은 DML성능에 큰 영향
- OLTP에서는 인덱스와 무결성 제약조건을 해제할 수 없음
- 동시 트랜잭션 없이 대량 데이터를 적재하는 배치 프로그램에서는 인덱스와 무결성 제약조건을 해제하여 큰 성능 개선 효과 얻을 수 있음

## 수정가능 조인 뷰

- 다른 테이블과 조인이 필요할 때 전통적인 Update문을 사용하면 비효율 완전 해소 불가능
- 참조테이블과 2번 조인하는 비효율 없앨 수 있음
- 조인 뷰: From절에 2개 이상 테이블을 가진 뷰
- 수정가능 조인 뷰: (1쪽 집합과 조인하는 M쪽 집합에)입력, 수정, 삭제가 허용되는 조인 뷰
- 키 보존 테이블
    - 조인된 결과 집합을 통해서도 중복값 없이 Unique하게 식별이 가능한 테이블
    - Unique한 1쪽 집합과 조인되는 테이블이어야 조인된 결과집합을 통한 식별 가능
    - 뷰에 rowid를 제공하는 테이블

## MERGE문 활용

- DW에 신규(변경) 트랜잭션 데이터 반영하는 프로세스(두 시스템간 데이터 동기화)
    - 전일 발생한 변경 데이터를 기간계 시스템으로부터 추출(Extraction)
    - 변경 테이블을 DW시스템으로 전송(Transportation)
    - DW 시스템으로 적재(Loading)
- 적재(Loading) 작업을 효과적으로 지원하기 위해 Merge문 도입
- Source 테이블 기준으로 Target테이블과 Left Outer Join방식으로 조인에 성공하면 Update, 실패하면 Insert
- Optional Clauses
    - UPDATE와 INSERT를 선택적으로 처리가능
    - 수정가능 조인 뷰 대체 가능
- Conditional Operations
    - ON절에 기술한 조인문 외에 추가 조건절 기술 가능
- DELETE Clause
    - 이미 저장된 데이터를 조건에 따라 지우는 기능도 제공
    - Merge문 Delete절은 조인에 성공한 데이터만 삭제할 수 있음
        - 조인에 실패한 데이터는 UPDATE, DELETE 모두 불가
    - 조인에 성공한 데이터를 모두 UPDATE하고 그 결과 값이 DELETE where조건절을 만족하면 삭제
