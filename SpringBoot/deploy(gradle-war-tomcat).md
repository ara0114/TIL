#  Spring Boot 프로젝트 war파일 배포 - 외장 TOMCAT

> 프로젝트 환경상 외장 TOMCAT을 이용하기 위함

- STS4

- TOMCAT 10.0.20 

  ```
  톰캣 버전 확인
  1. cmd 창에서 tomcat폴더의 lib폴더로 이동
  2. java -cp catalina.jar org.apache.catalina.util.ServerInfo 명령 실행
  ```

- 자바 JDK 11.0.14

  ```
  버전 확인
  1. cmd 창에서 java -version 또는 javac -version 명령 실행
  ```

## 1. war 생성

1. build.gradle 설정 후 Refresh Gradle Project 하여 변경사항 적용

2. 탭중 Window - Show View - Other - Gradle - Gradle Tasks 선택 후 Open

<img src="https://github.com/ara0114/TIL/assets/103404127/0610a8d6-089c-4245-b2cf-216b3a69eae8">

3. Gradle Tasks 목록중 해당 프로젝트에서 bootWar 더블클릭

<img src="https://github.com/ara0114/TIL/assets/103404127/d1e757a5-ccb4-4dd4-a1c0-885f8220bbde">

4. 프로젝트의 build-libs 폴더에 war파일이 생성됌.

<img src="https://github.com/ara0114/TIL/assets/103404127/5b87b07a-9360-4aa9-928d-b1c1500acc51">

## 2. Tomcat 설정/실행

1. 프로젝트의 application.properties 파일의 server.port 와 server.xml 파일(톰캣/conf 에 있음)의 Connector port가 일치하는지 확인

<img src="https://github.com/ara0114/TIL/assets/103404127/7a02ed2d-4501-4f0f-b71b-9304ab9168bf">

2. 💥톰캣폴더에 webapps 폴더를 지우고 webapps-javaee 폴더 생성💥
   - cf. webapps-javaee 디렉토리 내용을 Tomcat이 자동으로 Jakarta EE로 변환하고 webapps 디렉토리에 복사함

3. webapps-javaee 폴더에 생성했던 war파일을 옮긴 후, 이름을 ROOT로 변경

<img src="https://github.com/ara0114/TIL/assets/103404127/b2d17938-c586-4d41-bd12-ffd9250ff807">

4. 톰캣/bin 에서 startup.bat 실행 => Spring 구동 확인
   - cf. 종료할땐 shutdown.bat

5. 브라우저에 localhost:8000 입력하여 접근
