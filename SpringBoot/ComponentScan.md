## 컴포넌트 스캔과 의존관계 자동주입

- `@ComponentScan`붙여 컴포넌트 스캔을 사용할 수 있음
  - `@Component`가 붙은 클래스를 스캔해 스프링 빈으로 등록해줌
  - 스프링 빈의 기본이름은 클래스명을 사용하며 맨 앞글자만 소문자 사용
    - 만약 직접 지정하고싶으면 @Component("지정할이름") 으로 부여하면 된다.

*cf*. 컴포넌트 스캔을 사용하면 @Configuration이 붙은 설정정보도 자동으로 등록됌

​     => excludeFilters를 통해 컴포넌트스캔 대상에서 제외할 수 있음.(보통 제외하지 않음)

![image](https://user-images.githubusercontent.com/103404127/205498574-b007c8af-06f7-4550-b776-46bd8268c099.png)



- `@Autowired` 사용하면 스프링컨테이너가 스프링빈을 찾아 의존관계 자동으로 주입
  - 기본적으로 타입이 같은 빈을 찾아 주입
  - getBean(xxx.class)와 같은 동작한다고 보면 됌
  - 생성자에서 여러 의존관계도 한번에 주입받을 수 있음.

## 탐색 위치와 기본 스캔 대상

### 탐색시작위치

- `@basePackages` 를 통해 `탐색할 패키지` 의 시작위치를 지정할 수 있음(모든클래스 스캔하려면 시간 오래걸리므로)

  : 해당 패키지를 포함해 하위패키지 모두 탐색, 여러 시작위치를 지정할 수 있음

- `@basePackageClasses` 를 통해 `지정한 클래스의 패키지`를 시작위치로 지정

- 만약 지정하지 않으면 @ComponentScan이 붙은 설정 정보 클래스의 패키지가 시작위치가 됌

- 설정정보 클래스를 프로젝트 최상단(루트)에 두고 @ComponentScan붙이면 최상단부터 하위 모두 자동으로 스캔 대상이 됌

  - 스프링부트 기본제공방법: @SpringBootApplication을 프로젝트 시작 루트에 둠(여기에 @ComponentScan 들어있음)

### 기본스캔대상

- @Component
- @Controller : 스캔뿐아니라 스프링 MVC컨트롤러로 인식
- @Service: 비즈니스 계층 인식에 도움
- @Repository: 스캔뿐아니라 데이터접근계층으로 인식하고 데이터계층의 예외를 스프링 예외로 변환해줌
- @Configuration: 스캔뿐아니라 스프링 설정 정보로 인식하고 스프링 빈이 싱글톤 유지하도록 추가 처리함

*cf.*애노테이션은 상속관계라는 것이 없음.(애노테이션 안에 애노테이션? => 스프링이 지원하는 기능)



## 필터

- `includeFilters`: 컴포넌트 스캔대상을 추가로 지정
- `excludeFilters`: 컴포넌트 스캔에서 제외할 대상 지정

- 둘다 새로운 어노테이션 등록할 수 있음
- 보통 @Component 면 충분하므로 둘다 사용할 일 많지 않음. + 스프링 부트 기본 설정에 최대한 맞추어 사용하는 것을 권장함 

### 필터 옵션

- ANNOTATION: 기본값(생략가능). 어노테이션 인식해 동작
- ASSIGNABLE_TYPE: 지정한 타입과 자식타입 인식해 동작
- ASPECTJ: AspectJ 패턴사용
- REGEX: 정규표현식
- CUSTOM: TypeFilter라는 인터페이스 구현해 처리



## 중복등록과 충돌

- 같은 빈 등록할 경우

  - 자동 빈 vs 자동 빈 => ConflictingBeanDefinitonException 발생

  - 수동빈 vs 자동 빈 => 수동빈이 우선(수동빈이 자동빈 오버라이딩),

    최근 스프링부트에서는 다음과 같은 오류 발생하도록 기본값 바꿈

    ```
    Consider renaming one of the beans or enabling overriding by setting spring.main.allow-bean-definition-overriding=true
    ```

    