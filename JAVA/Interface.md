# Interface

- 상수와 추상메소드로만 이루어져 있음.

- 메소드 내용을 정의하는 {} 없음.

- 모든 추상메소드 앞은 public 이며, abstract 표기 안해도 됌.

- 추상클래스보다 많이 사용하며 추상클래스처럼 사용.

- 외부에 공개할 메소드를 등록하는 목적으로도 사용함.

- 인터페이스상의 추상메소드는 전부 오버라이딩해서 구현해야함. 하나라도 구현하지 않으면 추상클래스가 됌.

- 실체화.

- 상속과 달리 한번에 여러개 가능함. implements.

- 다형성, 클래스간 연결 느슨하게

- 객체 생성 불가. 인터페이스를 구현한 클래스의 객체를 생성해서 사용.

  인터페이스 타입 객체 = new 인터페이스 구현 클래스

- 인터페이스를 구현하는 클래스는 추가로 다른 메소드를 작성할 수 있음.

```java
interface USBMouseInterface{//인터페이스
    void mouseMove();//추상메소드
    void mouseClick();
}
interface RollMouseInterface{//인터페이스
    void roll();
}
public class MouseDriver implements RollMouseInterface, USBMouseInterface{
    //여러가지 interface를 구현하는 MouseDriver클래스
    void mouseMove(){...}
    void mouseClick(){...}
    void roll(){...}//추상메소드 구현
    
    int getStatus(){...}
    int getButton(){...}//추가메소드 작성
}
```

