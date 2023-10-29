## Direct Path I/O

- 일반적인 블록 I/O는 DB버퍼 캐시 경유 - OLTP는 성능향상
- DW/OLAP/배치 프로그램은 주로 대량 데이터를 처리하여 버퍼캐시를 경유하는 I/O 메커니즘이 성능을 떨어트림 → 오라클에서 Direct Path I/O 기능 제공(버퍼캐시 경유하지 않고 곧바로 데이터 블록 읽고 씀)
- Direct Path I/O 기능이 작동하는 경우
    - 병렬쿼리로 Full Scan을 수행할 때
    - 병렬 DML을 수행할 때
    - Direct Path Insert를 수행할 때
    - Temp 세그먼트 블록들을 읽고 쓸 때
    - direct 옵션을 지정하고 export를 수행할 때
    - nocache 옵션을 지정한 LOB컬럼을 읽을 때

## Direct Path Insert

- Insert가 느린 일반적인 이유
    - 데이터를 입력할 수 있는 블록을 Freelist에서 찾음
    - Freelist에서 할당받은 블록을 버퍼캐시에서 찾음
        - 버퍼캐시에 없다면 데이터 파일에서 읽어 버퍼캐시에 적재
    - INSERT 내용을 Undo 세그먼트에 기록
    - INSERT 내용을 Redo 로그에 기록
- Direct Path Insert 방식 사용 방법
    - Insert … Select문에 append 힌트 사용
    - parallel 힌트를 이용해 병렬 모드로 Insert
    - direct 옵션을 지정하고 SQL Loader로 데이터 적재
    - CTAS(Create table as Select)문 수행
- Direct Path Insert 방식이 빠른 이유
    - Freelist를 참조하지 않고 테이블 HWM(High-Water mark)바깥 영역에 데이터를 순차적으로 입력
    - 블록을 버퍼캐시에서 탐색하지 않음
    - 버퍼캐시에 적재하지 않고 데이터 파일에 직접 기록
    - Undo 로깅을 하지 않음
    - Redo 로깅을 안하게 할 수 있음(nologging모드) - 일반 Insert문을 로깅하지 않게 하는 법은 없음
- Array Processing도 append_values 힌트를 사용하여 Direct Path Insert방식으로 처리가능
- 사용시 주의할점
    - Exclusive 모드 TM Lock이 걸림
        - 커밋하기 전까지 다른 트랜잭션은 해당 테이블에 DML수행 못함
        - 트랜잭션 빈번할 경우 사용x
    - 테이블에 여유공간이 있어도 재활용하지 않음
        - Freelist가 아니라 HWM 바깥영역에 입력하므로
        - Range파티션 테이블의 경우 과거데이터를 DELETE가 아닌 파티션 DROP방식으로 지워줘야함
        - 비 파티션 테이블의 경우 주기적으로 Reorg 작업을 수행해줘야함

## 병렬 DML

- INSERT는 append 힌트로 Direct Path Write 방식으로 유도 가능
- 병렬 INSERT는 append 힌트를 지정하지 않아도 Direct Path Insert 방식 사용
- UPDATE, DELETE는 기본적으로 Direct Path Write 불가능
    - 병렬 DML로 처리할 경우 가능
- 병렬처리는 대용량 데이터가 전제 이므로 오라클은 병렬 DML에 항상 Direct Path Write 방식 사용
- DML 병렬로 처리하기
    - 병렬 DML활성화(alter session set enable parallel dml)
    - 각 DML문에 힌트 사용
        - /*+ parallel(a 4) */
        - /*+ full(b) parallel(b 4) */
        - /*+ enable_parallel_dml parallel(c 4) */
        - /*+ enable_parallel_dml full(d) parallel(d 4) */
- Exclusive 모드 TM Lock이 걸림 → 트랜잭션 빈번할 경우 사용x
- 병렬 DML이 잘 작동하는지 확인하는 방법
    - 실행계획에서 PX COORDINATOR의 위치가 DML보다 위에 있으면 DML작업을 각 병렬 프로세스가 처리
