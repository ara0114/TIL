# Control File

- **Binary File**. ⇒ 사용자나 DBA가 직접 수정할 수 없음.
  ⇒ 내용을 변경하려면 서버 프로세스에게 변경을 요구하는 SQL문장이나 DDL문장을 수행
- Control File 안에는 **Database전체의 상태정보가 들어있음. 운영될 때 실시간으로 각종 정보가 저장되고 조회**됨
- 파일에 장애 발생할 경우 Instance가 실패되어 중단되므로 잘 관리
- 삭제되지 않도록 주의. 혹시나 삭제되더라도 복구할 수 있도록 여러곳에 복사본을 만들어 분산시켜 사용할 것을 권장 ⇒ **다중화**
- 오라클 서버의 시작순서와 파일
  - STARTUP → (Parameter File) → NOMOUNT → (Control File) → MOUNT → (Redo log File, Data File) → OPEN
- Parameter File에 Control File의 위치정보가 기록되어 있음.
  ⇒ 여러 곳으로 다중화 할 경우 Parameter File에 Control File의 위치를 기록한 후 그 위치에 Control File 복사
- NOMOUNT 단계 마치면 Control File 내용 읽고 MOUNT 단계로 진행
- Database 무결성 확인 후 Data File과 Redo Log File을 읽고 OPEN단계 진행
- **Control File 다중화 순서**
  - Spfile내용변경 → Instance 종료 → Control File 복사(다중화) → Instance 시작
- **참고** (Pfile과 Spfile)

|  | Pfile(정적) | Spfile(동적) |
| --- | --- | --- |
| 파일 기본경로 | $ORACLE_HOME/dbs | $ORACLE_HOME/dbs |
| 파일이름 | initSID.ora | SpfileSID.ora |
| 내용변경 | 관리자(사람) | 서버프로세스 |
| 파일형태 | TEXT(OS편집기로 편집가능) | Binary(OS편집기로 편집안됌) |
