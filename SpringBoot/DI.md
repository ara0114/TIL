# 의존성 주입(DI)

스프링 프레임워크는 객체생성과 의존관계를 컨테이너가 자동으로 관리함

스프링 IoC의 핵심원리이며, 2가지 형태로 지원



![image](https://user-images.githubusercontent.com/103404127/172393379-03e31931-8ff1-4184-b836-1d17d2ae1ede.png)



컨테이너가 객체를 생성하고 클라이언트가 검색(Lookup)하여 사용하는 방식을 Dependency Lookup이라 하며, 실제 개발과정에서는 대부분 **Dependency Injection을 사용** 함

Dependency Injection은 객체사이의 의존관계를 프로그램 코드에 포함된 어노테이션 정보를 바탕으로하여 컨테이너가 자동으로 처리

의존성 설정을 바꾸고 싶을때는 어노테이션 정보만 수정하면 변경사항을 적용할 수 있어 유지보수가 향상됌

관련 어노테이션 `@Autowired`