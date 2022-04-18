# Exception(예외처리)

예외가 발생했을 때 JVM이 간섭하여 프로그램이 끝나는 것이 아니라 나머지 정상 실행(처리)할 수 있게 해줌

- 예외: 프로그램 개발시 발생하는 에러와는 다름, 실행시 발생.

- 다중 exception을 쓰기도 함

```java
try{
    예외가 발생할 가능성이 있는 실행문장
} catch(처리할 예외타입){
    예외처리 문장(원인 출력 등)
} finally{
    무조건 실행해야 하는 문장(데이터베이스 연결 종료 등), 생략 가능
}
  
```

- 예외 선언은 처음에 좁은 범위, 내려갈 수록 넓은 범위의 예외를 명시.

- 예외 파악이 불분명 할 경우 Exception 클래스로 받음.

- 반드시 예외처리를 지정해야 하는 경우

  - DOC문서에서 throws절이 있는 메소드는 반드시 코드를 try~catch문에서 사용해야함.필수적으로 예외처리.

  ```java
  getString메소드는 SQLException이 발생할 수 있습니다.
  public String getString(int columnIndex) throws SQLException{
      ...
  }...
      try{
          ...
      } catch(SQLException e){
          ...
      } finally{
          ...
      }
  ```

  - 메소드에 throws절을 명시하면 try~catch문을 사용하지 않아도 됌.

  ```java
  public void prn(ResultSet r) throws SQLException{
      처리로직 구현
  }
  ```

  - 개발자가 사용자 예외를 만들어 처리가능. 보통 예외를 출력하는 출력파일을 따로 지정하는 경우에 많이 사용.

- 주요 예외종류

| 예외                          | 원인                                                         |
| ----------------------------- | ------------------------------------------------------------ |
| ArithmeticException           | 정수를 0으로 나눌 때 발생                                    |
| NullPointerException          | Null레퍼런스를 참조할 때 발생                                |
| ClassCastException            | 변환할 수 없는 타입으로 객체를 변환할 때 발생                |
| OutOfMemoryException          | 메모리가 부족한 경우 발생                                    |
| ArrayIndexOutOfBoundException | 배열의 범위를 벗어난 접근 시 발생                            |
| IllegalArgumentException      | 잘못된 인자 전달 시 발생                                     |
| IOException                   | 입출력동작 실패 또는 인터럽트 시 발생                        |
| NumberFormatException         | 문자열이 나타내는 숫자와 일치하지 않는 타입으로 변환 시 발생 |

