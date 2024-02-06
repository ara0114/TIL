# docker 이미지생성/설정

- 새폴더 생성 후 git bash로 `git clone https://github.com/oracle/docker-images` 실행
- 해당폴더의 `docker-images\OracleDatabase\SingleInstance\dockerfiles`로 이동하여 버전에 맞는 폴더에 linux oracle zip파일 옮겨두기
- 해당폴더의 `docker-images\OracleDatabase\SingleInstance\dockerfiles` 에서 ` ./buildContainerImage.sh -e -v 21.3.0` 명령실행

DOCKER 이미지 생성후 

CMD 창에서 다음 명령 실행

```bash
docker run --name oracle21c ^
-p 11521:1521 -p 15500:5500 -p 12484:2484 ^
--ulimit nofile=1024:65536 --ulimit nproc=2047:16384 --ulimit stack=10485760:33554432 --ulimit memlock=3221225472 ^
-e ORACLE_SID=orcl ^
-e ORACLE_PDB=orclpdb ^
-e ORACLE_PWD=1234 ^
-e INIT_SGA_SIZE=2048 ^
-e INIT_PGA_SIZE=1024 ^
-e INIT_CPU_COUNT=2 ^
-e ENABLE_ARCHIVELOG=false ^
-v C:\dockerDisk\oracle21c:/opt/oracle/oradata ^
oracle/database:21.3.0-ee
```

명령어 정리

```bash
--도커 컨테이너 실행
docker start oracle21c
--실행
docker exec -it oracle21c /bin/bash
--root로 실행
docker exec -it -u root oracle21c /bin/bash

--vi설치(bash$)
yum -y install vi
-- grep
env | grep ORA

```

환경설정(oraenv.sh)

```bash
export ORACLE_SID=ORCL
export ORACLE_BASE=/opt/oracle
export ORACLE_PDB=orclpdb
export ORACLE_PWD=1234
export ORACLE_HOME=/opt/oracle/product/21c/dbhome_1

alias ll='ls -la'
```

## impdp

- 디비버 사용 전 도커 컨테이너 실행(도커 - 오라클 모두 실행되어야함)
- 디렉토리 네임, 경로 확인(이를 통해 data_pump_dir 확인)

```sql
SELECT * FROM DBA_DIRECTORIES;
```

- 원하는 덤프파일이 있는 위치에서 cmd실행

```powershell
# dmp파일 펌프 디렉토리로 복사해오기
docker cp adsql.dmp oracle21c://opt/oracle/admin/ORCL/dpdump/
# 루트 사용자로 로그인
docker -exec -it -u root oracle21c /bin/bash
```

- 명령어 실행(bash$)

```bash
# 파일이 있는 위치로 이동
cd /opt/oracle/admin/ORCL/dpdump/
# 파일의 소유자를 DBA로 변경
chown oracle:dba adsql.dmp
```

- 테이블 스페이스 생성/공간할당

```sql
CREATE TABLESPACE ts_test
DATAFILE '/opt/oracle/oradata/ORCLCDB/ORCLPDB1/ts_test_01.dbf'
SIZE 100M autoextend ON NEXT 20m maxsize unlimited;
ALTER TABLESPACE ts_test
ADD DATAFILE '/opt/oracle/oradata/ORCLCDB/ORCLPDB1/ts_test_02.dbf'
SIZE 10M autoextend ON NEXT 10m maxsize unlimited;
```

- test유저 생성 및 기본 테이블 스페이스 할당

```sql
alter session set "_ORACLE_SCRIPT"=TRUE;
CREATE USER test IDENTIFIED BY test DEFAULT TABLESPACE tbs1;
```

- test유저에 권한부여

```sql
GRANT CONNECT, RESOURCE TO TEST;
GRANT UNLIMITED TABLESPACE TO TEST;
GRANT SELECT ANY TABLE TO TEST;
GRANT CREATE SYNONYM, CREATE VIEW TO TEST;
```

- 덤프파일 있는 경로에 임포트할 디렉토리 생성

```sql
CREATE directory dir_pump AS '/opt/oracle/oradata/pump';
```

- 임포트 수행(bash$)

```bash
impdp system/1234@ORCLPDB directory =dir_pump dumpfile =adsql.dmp remap_tablespace=tbs1:ts_test;
```
