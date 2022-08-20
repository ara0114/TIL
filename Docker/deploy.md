# 도커를 이용해 서버에서 프로젝트 실행하기
## 1.Docker Container/Image 만들기

1. Dockerfile 생성(프로젝트 폴더에 바로) 및 작성 후, properties 설정 변경

2. war 파일 생성 및 Dockerfile 위치변경

- `gradlew bootwar`

![image](https://user-images.githubusercontent.com/103404127/184495343-f5d0c2a4-4b19-4e73-82a8-abe4c5c06c0c.png)

![image](https://user-images.githubusercontent.com/103404127/184495412-b1e47ce0-a7dc-405c-8471-be041656dc22.png)

3. war파일 생성된 위치로 이동후, 도커 로그인

- `docker login`

4. network 및 volume 생성/확인

- 생성: `docker network create [이름]`

- 확인: `docker network ls`

![image](https://user-images.githubusercontent.com/103404127/184495828-d602c80d-a4eb-46b3-8164-27128737bcd4.png)

- 생성: `docker volume create [이름]`

- 확인: `docker volume ls`

![image](https://user-images.githubusercontent.com/103404127/184495884-c814d5d0-1fc5-4c9a-8e14-3d5ef5f9e9ff.png)

5. mysql 이미지 생성/컨테이너 생성 및 실행

- `docker pull mysql`

![image](https://user-images.githubusercontent.com/103404127/184496031-895d8eb5-0f24-4737-802f-50d6b3a071ba.png)

- `docker run -d --name [mysql 컨테이너별명] -e MYSQL_ROOT_PASSWORD=[root계정비밀번호] -p 3306:3306 --network [network ID] -v [volume name]:/var/lib/mysql` 

![image](https://user-images.githubusercontent.com/103404127/184496209-15519a72-8d8d-45dc-872d-436b3059f203.png)

6. 프로젝트 이미지 생성/컨테이너 생성 및 실행

- `docker build -t [war파일명] .`

![image](https://user-images.githubusercontent.com/103404127/184496894-792e8c0c-c04b-4f28-958f-77c39fcb1ebd.png)

- `docker run -it --name [프로젝트 컨테이너별명] --network [networ ID] -p 8000:8000 [war파일명] bash`

![image](https://user-images.githubusercontent.com/103404127/184496865-a190c2f2-0a28-48ca-8570-d46e45d28e05.png)

---

## 2. DockerHub에 push하기

1. 태그를 이용해 도커허브로 푸시하기위한 연결과정

- `docker tag [이미지별명] [허브 repository명]`

![image](https://user-images.githubusercontent.com/103404127/184497343-eafdd686-e6c4-46fb-8318-999f7bf9bed6.png)

2. repository로 푸시

- `docker push [허브 repository명]`

![image](https://user-images.githubusercontent.com/103404127/184497490-35f1941e-aaa9-42f3-9a18-fcde4a06b2e6.png)

![image](https://user-images.githubusercontent.com/103404127/184497555-e082634a-5ddb-4d45-a056-cab5224b83cb.png)

---

## 3. 원격서버에 가져오기

1. 원격서버에 도커 설치 및 실행여부 확인

- `sudo apt update` : 프로그램 설치 관리자 apt 최신정보로 업데이트

- `sudo apt install apt-transport-https ca-certificates curl software-properties-common` : 사전설치

- `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -` : docker repository key를 add
- `sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"` : docker repository를  add
- `sudo apt-cache policy docker-ce` : 설치가능버전확인

- `sudo apt install docker-ce` : docker 설치

- `sudo systemctl status docker` : docker 실행여부 확인

2. 도커 로그인 후, DockerHub에 올려둔 이미지 pull

- `docker pull [허브 repository명]`

![image](https://user-images.githubusercontent.com/103404127/184498553-c61a8395-744a-4a95-9e45-5397157c83cd.png)

- `docker images` : 이미지확인

![image](https://user-images.githubusercontent.com/103404127/184498687-8d544bbf-7a38-4929-bcd4-752907d96e48.png)

3. network 및 volume 생성.
4. mysql 컨테이너 생성 및 실행.

- `docker run -d --name [mysql 컨테이너별명] -e MYSQL_ROOT_PASSWORD=[root계정비밀번호] -p 3306:3306 --network [network ID] -v [volume ID]:/var/lib/mysql` 

5. 프로젝트 컨테이너 생성 및 실행.

- `docker run --name [프로젝트 컨테이너 별명] -p 8000:8000 --network [network ID] [프로젝트 repository명]`

![image](https://user-images.githubusercontent.com/103404127/184499109-2ca850db-10dc-4894-8594-7335b7ba8324.png)

- `docker ps -a` : 컨테이너 확인

![image](https://user-images.githubusercontent.com/103404127/184500393-842a3822-79f5-416a-9c59-1e14a0dd86d9.png)

정상실행 확인

![image](https://user-images.githubusercontent.com/103404127/184500509-3eab0333-4717-41c1-9d41-73d4bc4f6774.png)

---

### *MySQL Docker 설정

실행중인 mysql 컨테이너 bashshell실행

- `docker exec -it mysql bash -l`

![image](https://user-images.githubusercontent.com/103404127/184499911-78fcbe13-3143-48d2-9cc9-10545bf34675.png)

데이터베이스 및 계정 생성/권한설정

- `create database [데이터베이스명]`
- `create user [계정] identified by '[비밀번호]' `
- `grant all privileges on [권한적용할데이터베이스명].* to [계정] with grant option`

![image](https://user-images.githubusercontent.com/103404127/184500182-2dcc8c61-c745-4bdb-9bdb-331d17705dd7.png)



