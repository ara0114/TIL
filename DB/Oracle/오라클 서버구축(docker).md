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
