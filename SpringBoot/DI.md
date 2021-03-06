# 의존관계 주입(DI, Dependency Injection)

의존관계는 **정적인 클래스 의존 관계와 실행시점에 결정되는 동적인 객체(인스턴스)의존관계** 들을 분리해서 생각해야함

- 정적인 클래스 의존관계

  : 클래스가 사용하는 import 코드만 보고 의존관계를 쉽게 판단할 수 있음.

  정적인 의존관계는 애플리케이션을 실행하지 않아도 분석할 수 있음.

  클래스 다이어그램을 보고 의존관계를 판단 할 수 있음.

  그러나 실제 어떤객체가 주입될지는 알 수 없음. 

- 동적인 객체 인스턴스 의존관계

  : 애플리케이션 실행 시점에 실제 생성된 객체 인스턴스의 참조가 연결된 의존 관계.

  객체는 인스턴스를 생성하고 그 참조값을 전달해 연결.

  실행시점(런타임)에 외부에서 실제 구현 객체를 생성하고 클라이언트에 전달해서 클라이언트와 서버의 실제 의존 관계가 연결 되는 것을 `의존관계 주입` 이라 함.

  의존관계 주입을 사용하면 클라이언트 코드를 변경하지 않고 클라이언트가 호출하는 대상의 타입 인스턴스를 변경할 수 있음.

  의존관계 주입을 사용하면 정적인 클래스 의존관계를 변경하지 않고, 동적인 객체 인스턴스 의존관계를 쉽게 변경할 수 있음.



---



스프링 프레임워크는 객체생성과 의존관계를 컨테이너가 자동으로 관리함

- IoC 컨테이너, DI 컨테이너
  - 객체를 생성하고 관리하면서 의존관계를 연결해주는 것을 IoC컨테이너 또는 DI컨테이너라 함
  - 의존관계 주입에 초점을 맞추어 주로 DI컨테이너라 함

스프링 IoC의 핵심원리이며, 2가지 형태로 지원



![image](https://user-images.githubusercontent.com/103404127/172393379-03e31931-8ff1-4184-b836-1d17d2ae1ede.png)



컨테이너가 객체를 생성하고 클라이언트가 검색(Lookup)하여 사용하는 방식을 Dependency Lookup이라 하며, 실제 개발과정에서는 대부분 **Dependency Injection을 사용** 함

Dependency Injection은 객체사이의 의존관계를 프로그램 코드에 포함된 어노테이션 정보를 바탕으로하여 컨테이너가 자동으로 처리

의존성 설정을 바꾸고 싶을때는 어노테이션 정보만 수정하면 변경사항을 적용할 수 있어 유지보수가 향상됌

관련 어노테이션 `@Autowired`