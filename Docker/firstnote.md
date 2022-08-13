vm경량화=> 컨테이너

운영체제 포함없이 컨테이너엔진이포함된 호스트OS공유

컨테이너엔진이 호스트OS에 접근

컨테이너엔진중 가장 많이 =>DOCKER

---

컨테이너 만들기

: 도커파일로 이미지를 만들어서 컨테이너구동

- 도커파일: 파일, 환경변수, 등등

- 도커이미지: 런타임환경, 설정 등등 =>불변의상태 //어플리케이션 스냅샷//클래스라고생각//

  도커 컨테이너를 구성하는 파일 시스템과 실행할 어플리케이션 설정을 하나로 합친 것으로, 컨테이너를 생성하는 템플릿 역할

- 도커컨테이너: 이미지를 실행할수있도록 함//도커 이미지를 기반으로 생성되며, 파일 시스템과 어플리케이션이 구체화되어 실행되는 상태

---

로컬머신이미지 - PUSH - 컨테이너레지스트리(깃허브) - PULL - 서버


![image](https://user-images.githubusercontent.com/103404127/180437635-3851e173-bc9b-4474-a12b-3a67479e305b.png)

---

npm init -y

- 프로젝트 초기화

---

도커파일작성



From 사용할베이스이미지

WORKDIR 복사해올경로

COPY 복사해올파일

RUN npm install (npm ci 사용해도됌)

ENTRYPOINT 실행할파일



copy해올때마다 레이어 생성 => 빈번하게 바꾸는거는 마지막에 copy하여 최상단에

---

도커이미지 만들기



docker build -f Dockerfile -t fun-docker .

- .은 build context : 명령어실행하는 현재경로명시
- -f : 어떤 도커파일 사용할건지 명시
- -t : 도커이미지에 이름부여



docker images

- 로컬머신에 만들어진 이미지 확인

---

컨테이너실행



docker run -d -p 8080:8080 fun-docker

- -d : detached / 백그라운드에서 컨테이너 돌릴수있게
- -p : 포트지정 / 호스트머신포트:컨테이너포트 연결

docker ps

- 현재실행중인 컨테이너리스트확인

docker tag 

- 이름변경

docker login

- 계정정보넣기

docker push 계정정보/레파지토리

- 도커허브에업로드

---

Docker에선 권장 사항으로 하나의 이미지엔 하나의 앱만 넣고 여러 컨테이너를 조합하여 서비스를 구축하는 방법을 권장

각 sw별로 이미지 만들어 각각 컨테이너에 담고 compose로 환경설정해서 한번에 여러 컨테이너를 실행

---

docker run 컴파일하고저장

docker exec 이미지를 실행



docker images

docker ps -a



up -> docker stop -> exited