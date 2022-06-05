# MVC 모델

## MVC(Model, View, Controller) 모델

- 1979년 스몰톡이라는 객체지향 언어를 사용한 사용자 인터페이스 개발에 소개된 개념, 오랫동안 GUI개발 분야에서 사용된 개발 패턴
- 새로운 개발 방법이 아니라 기존의 MVC개발 모델이 웹 응용프로그램개발에도 적합하다는 것이 입증된 것
- MVC모델은 웹 응용프로그램을 구성하는 서버모듈을 **사용자에게 보이는 표현**을 _뷰(View)_, **자료의 비즈니스 로직 처리** 를 _모델(Model)_, **흐름을 제어하는 역할**의 *컨트롤러(Controller)*로 분리하여 개발하는 모델
- JSP와 javabeans로 개발한 Model1의 경우 비즈니스 로직과 표현을 완전히 분리하기 쉽지 않을뿐만 아니라 프로젝트 규모가 커질수록 더욱 어려워짐
- 해결책으로 **비즈니스 로직과 표현을 분리하여 개발** 하고자 하는것이 Model2, **MVC모델**
- 장점
  - 웹 응용프로그램의 **수정이 쉬움**
  - 웹 응용프로그램의 **확장이 쉬움**
  - 웹 응용프로그램의 **유지보수가 쉬움**

|  MVC요소   | 구현 프로그램 |                         역할                          |
| :--------: | :-----------: | :---------------------------------------------------: |
|   Model    |   javabeans   |                   비즈니스로직처리                    |
|    View    |   jsp, html   |                         표현                          |
| Controller |    servlet    | 적절한 Model을 사용,처리하여 뷰로 이동시키는 제어처리 |

![image-20220604230335551](https://user-images.githubusercontent.com/103404127/172038816-02462a18-18f7-495c-8bc3-56384493653b.png)

## Model1과 Model2

[1] Model1(**JSP+JavaBeans**)

![image-20220604230744754](https://user-images.githubusercontent.com/103404127/172038818-a2bfea6d-d31a-4782-9638-1d4c3086494a.png)

- 개발순서

  ① DBMS 설정

  ② DTO Class 제작

  ③ DAO Class 제작

  ④ Service Class 제작

  ⑤ Service/DAO test

  ⑥ JSP 생성 연동

  <br>

[2] Model2(**MVC**)

![image-20220604230939614](https://user-images.githubusercontent.com/103404127/172038822-0cc04e3c-d07d-4e14-8a26-1a9eeecdf020.png)

1. 요청, 컨트롤러가 요청을 받아 분석
2. 컨트롤러가 알맞은 비즈니스 로직을 처리하는 모델사용(객체생성)
3. 결과를 담을 알맞은 뷰 선택
4. 모델의 결과를 뷰에 담아
5. 응답

<br>

- 개발순서

  ① DBMS 설정

  ② DTO Class 제작

  ③ DAO Class 제작

  ④ Service Class 제작

  ⑤ Service/DAO test

  ⑥ Servlet Controller 제작

  ⑦ Action Interface 제작

  ⑧ Action 구현 Class 제작, Service Class 연동

  ⑨ JSP 생성 연동
