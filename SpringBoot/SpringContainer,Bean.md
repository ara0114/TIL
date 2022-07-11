# 스프링 컨테이너

ApplicationContext를 스프링 컨테이너(인터페이스)라 함

- BeanFactory(스프링 컨테이너 최상위 인터페이스 - 스프링빈 관리, 조회) 기능을 모두 상속받아 제공

- bean 관리기능 + 부가기능(국제화, 환경변수, 이벤트, 리소스 조회)

@Configuration이 붙은 클래스를 설정(구성)정보로 사용함

---

1.스프링컨테이너 생성

new AnnotationConfigApplicationContext(AppConfig.class)

스프링컨테이너를 생성할 때는 구성정보를 지정해줘야함.

여기선 AppConfig.class를 구성정보로 지정함

<br>

2.스프링 빈 등록

@Bean이라 적힌 메소드를 모두 호출해서 반환된 객체를 스프링 컨테이너에 등록 => 이렇게 스프링 컨테이너에 등록된 객체를 스프링 빈이라 함.

스프링빈은 @Bean이 붙은 메소드 명을 스프링빈의 이름으로 사용함.

이름 직접 부여할 수도 있음

빈이름은 항상 다른 이름을 부여해야함

<br>

3.스프링 빈 의존관계설정 준비(객체생성)

<br>

4.스프링 빈 의존관계설정 완료(의존관계주입)

<br>

---

스프링컨테이너를 통해 필요한 스프링빈(객체)를 찾아야하며 applicationContext.getBean()메소드를 사용해 찾을수 있음



컨테이너에 등록된 모든 빈 조회

- ac.getBeanDefinitionNames(): 스프링에 등록된 모든 빈 이름 조회

- ac.getBean(): 빈이름으로 빈 객체(인스턴스) 조회

스프링 내부에서 사용하는 빈은 getRole()로 구분할 수 있음

- ROLE_APPLICATION : 사용자가 정의한 빈
- ROLE_INFRASTRUCTURE : 스프링이 내부에서 사용하는 빈



스프링 빈 조회(기본)

- ac.getBean(빈이름, 타입)

- ac.getBean(타입)



스프링 빈 조회(동일 타입 둘 이상)

- 그냥 타입으로 조회시 같은 타입의 스프링 빈 둘이상이면 오류 발생 -> 빈 이름 지정

- ac.getBeansOfType(): 해당타입의 모든 빈 조회



스프링 빈 조회(상속)

- 부모타입으로 조회시 자식도 함께 조회됌(Object-> 모든 스프링빈 조회)

---

스프링 빈 설정 메타정보(BeanDefinition)

- 스프링 컨테이너는 XML인지 자바코드인지 알 필요 없이 BeanDefinition만 알면 됌 

- 스프링 컨테이너는 이 메타정보를 기반으로 스프링 빈 생성

- 직접 정의하거나 사용할 일 거의 x
- 스프링 다양한 형태의 설정정보를 추상화해서 사용한다

- BeanDefinition 정보
  - BeanClassName: 생성할 빈 클래스 명(팩토리역할 빈 사용하면 x)
  - factoryBeanName: 팩토리역할 빈 사용할 경우 이름
  - factoryMethodName: 빈을 생성할 팩토리 메소드
  - Scope: 싱글톤(기본값)
  - lazyInit: 스프링 컨테이너 생성시 빈을 생성하는 것이 아니라, 실제 빈을 사용할 때까지 최대한 생성을 지연처리 하는지 여부
  - InitMethodName: 빈 생성 및 의존관계를 적용 후, 호출되는 초기화 메소드
  - DestroyMethodName: 빈 생명주기 끝난 후 제거하기 직전 호출되는 메소드
  - Constructor arguments,Properties: 의존관계주입에서 사용(팩토리 역할 빈 사용하면 x)
