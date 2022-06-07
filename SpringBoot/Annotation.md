# 어노테이션(@, Annotation)

프로그램에게 추가적인 정보를 제공해주는 메타데이터

- 컴파일러에게 코드 작성 문법에러를 체크하도록 정보를 제공
- 소프트웨어 개발 툴이 빌드나 배치시 코드를 자동으로 생성할 수 있도록 정보를 제공
- 실행시(런타임시) 특정 기능을 실행하도록 정보 제공

---

@SpringBootApplication : 스프링부트의 핵심 어노테이션, 아래 3개의 스프링 부트 어노테이션으로 구성

```
@EnableAutoConfiguration: 스프링의 다양한 설정 자동으로 구성
@ComponentScan: 컴포넌트 클래스를 검색하고 검색된 컴포넌트 및 클래스를 스프링 애플리케이션 컨텍스트에 등록
@Configuration : 클래스가 스프링 설정으로 사용됨을 의미,자바기반 설정파일임을 의미(XML설정 대신 사용)
```

@Bean : 메소드의 리턴값이 빈 객체로 사용됨을 의미

​	@Bean(name="value") : 빈으로 등록될 이름 지정, 별도의 이름을 지정하지 않으면 메소드 이름이 빈의 이름으로 등록됌.

@Component : 컨테이너가 객체를 생성해줌.

@Autowired : DI, 객체(해시코드)가 주입

@Value("value") : 문자열, 기본형 타입의 값이 주입

@Qualifier : 동일한 인터페이스를 구현한 클래스가 여러개 있는 경우 이름을 지정하여 명확하게 클래스를 인식할 수 있음

@RequestMapping("/") : 웹브라우저주소창에 url을 입력하면 이 어노테이션에 등록된 메소드가 호출됌. Controller에서만 사용가능

```
-사용자 요청시 처리할 메소드 리턴
-연결된 메소드의 매개변수는 요청/응답 객체, 요청처리 결과를 담아 뷰페이지로 전달할 Model객체, 요청지로부터 전달받은 파라미터값 등 다양한 값이 선언될 수 있음
-요청 url자체에 변수를 넣어줄 수 있는데 주소와 변수를 구분하기위해 @PathVariable을 사용
-기존 컨트롤러에 코드를 추가함
-@GetMapping, @PostMapping
```

@ResponseBody : 자바객체를 http요청의 body내용으로 변환/매핑하는 어노테이션. 문자열 데이터만 응답

@RequestBody : http요청의 body내용을 전달받아 자바 객체로 변환/매핑하는 어노테이션

@Controller : Controller로 사용되는 클래스 선언을 단순화 시켜줌. 뷰 리턴. 리턴타입이 String이면 jsp파일명을 의미, 문자열 리턴시 @ResponseBody명시함

@RestController : @Controller 와 @ResponseBody의 결합형태, 데이터(문자열) 리턴. 비동기 통신시 사용하면 좋음.

@RequestParam : request.getParameter

@PathVariable : url경로주소에 사용하는 값을 매개변수로 사용가능하게 해주는 어노테이션, RequestMapping의 어노테이션 값으로 {템플릿변수} 사용하고 @PathVarialbe 어노테이션을 이용하여 {템플릿변수}와 동일한 이름을 갖는 파라미터 추가함.

