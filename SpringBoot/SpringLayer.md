# Spring Layer

[1] Web Layer

- 컨트롤러, 뷰 영역
- 이외에도 필터, 인터셉터 등 외부 요청과 응답에 대한 전반적인 영역 의미

[2] Service Layer

- 서비스영역
- 컨트롤러와 저장소(Repository, DAO)의 중간에 위치
- 트랜잭션이 사용되어야 하는 영역.
- AOP적용 처리

[3] Repository Layer

- DAO영역

- 데이터 저장소에 접근하는 영역

[4] DTOs

- DTO(계층간 데이터 교환을 위한 객체)영역

[5] Domain model

- 개발대상. 도메인을 모든 사람이 동일한 관점에서 이해할 수 있고 공유할 수 있도록 단순화한 것
- 엔터티가 사용되는 영역
