> cmd 창에서 아래명령어를 사용하여 mysql container 생성하고 실행할때 

- `docker run -d --name [mysql container 별명] -e MYSQL_ROOT_PASSWORD=[root 계정 비밀번호] -p 3306:3306 --network [network id] -v [volume name]:/var/lib/mysql mysql`

**문제발생**

![image](https://user-images.githubusercontent.com/103404127/182034296-b2c0e13a-7855-4baf-bc82-d0df9ffe070b.png)

**해결**

cmd 창에 `netstat -ano | findstr :3306` 입력

=> PID 확인

(mysqld.exe가 실행중이었음)

=> 작업끝내기

=> 도커 재시작

