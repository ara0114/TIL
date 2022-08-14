> <h2>cmd 창에서 아래명령어를 사용하여 mysql container 생성하고 실행할때</h2> 

- `docker run -d --name [mysql container 별명] -e MYSQL_ROOT_PASSWORD=[root 계정 비밀번호] -p 3306:3306 --network [network id] -v [volume name]:/var/lib/mysql mysql`

**문제발생**

![image](https://user-images.githubusercontent.com/103404127/182034296-b2c0e13a-7855-4baf-bc82-d0df9ffe070b.png)

**해결**

cmd 창에 `netstat -ano | findstr :3306` 입력

=> PID 확인

(mysqld.exe가 실행중이었음)

=> 작업끝내기

=> 도커 재시작



> <h2>cmd창 및 원격서버에서 아래명령어를 사용하여 프로젝트 container 생성하고 실행할때</h2>

- cmd 창:`docker run -it --name [프로젝트 container 별명] --network [network id] -p 8000:8000 [war파일 이름] bash`
- 원격서버: `docker run --name [프로젝트 container 별명] -p 8000:8000 --network [network id] [프로젝트 repository name]`

**문제발생**

![image](https://user-images.githubusercontent.com/103404127/182370641-4e69c2d9-14c1-403a-9267-4582d52e6339.png)

**해결**

각각에서 mysql서버에 접속

database 및 계정생성 후 권한설정

![image](https://user-images.githubusercontent.com/103404127/182370910-ab5554e3-362a-4514-ba51-17bd23dbb5a6.png)

![image](https://user-images.githubusercontent.com/103404127/182371053-71284b86-39f0-4b24-a858-2db610058f7d.png)

나와서 재실행하면 정상적으로 작동
