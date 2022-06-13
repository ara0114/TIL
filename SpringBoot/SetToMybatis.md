MyBatis로 설정 바꾸기

- build.gradle -> 바꾸면 refresh까지

- application.properties

- DatabaseConfiguration.java 생성

  @Configuration : 클래스가 스프링 설정으로 사용됨을 의미

  @PropertySource(프로퍼티파일 경로)
  @MapperScan : 매퍼를 하나씩 등록하는게 아닌 패키지 경로를 지정하여 이하 위치에있는 인터페이스들은 전부 맵퍼로 사용할수있다.

  @Autowired : 의존관계주입

  @Bean: 메소드 호출해서 반환된 객체를 스프링 컨테이너에 등록

  @ConfigurationProperties(prefix="spring.datasource.hikari")

   => prefix가 저렇게 시작하는거 가저오겟다

- MemoMapper 인터페이스, MemoService 인터페이스 생성

- MemoServiceImpl 구현클래스 생성

  @Service: 서비스임을 알리는 어노테이션. 얘가 비즈니스 로직이야, dao가 받아온 데이터 가공

  @Autowired: Mapper 의존관계주입

- 정적영역 폴더(resources)에 mybatis폴더 생성 -> memo.xml 생성

  위에서 만든 Mapper인터페이스를 mapper로 인식할수있게해줌

  (DTD선언, mapper namespace설정-연동시키고자하는 매퍼 인터페이스명을 경로와 함께)

​		(폴더명 DatabaseConfiguration에서 sqlsession부분 경로와 일치해야)

- Controller에 의존관계 주입 Qualifier이용하는거

  어떤 빈을 주입해야 하는지 지정해줌.

  (//XXServiceImpl @Service에 객체생성할때 지정된이름)

---

- BbsController-> BbsService(DAO파일 메소드선언참고) -> BbsServiceImpl ->  BbsMapper -> bbs.xml -> BbsDAO에서쿼리 xml로 가져오기

- DAO, Constant, DBClose, DBOpen 삭제
