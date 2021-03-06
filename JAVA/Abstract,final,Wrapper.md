# Abstract class(추상클래스)

__추상메소드를 0개 이상 가지고 있는 클래스__

- 추상메소드: 원형만 선언되어 있는 메소드, 중괄호{ } 생략,

  __서브 클래스에서 오버라이딩 해서 구현(강제로 해줘야함. 안하면 서브 클래스의 메소드도 추상메소드가 됌)__

- 완전하지 못하므로 객체를 생성할 수 없음.

- 구조와 설계 같은 느낌.

- 실체 클래스가 상속하여 구현.

- 특성 제한자(abstract, static, final)는 순서가 상관없음.

  메소드 선언시 abstract public ~, public abstract ~ 둘다 맞음.

```java
abstract class DObject{//추상클래스
    public DObject next;
    public DObject(){next = null;}
    abstract public void draw();//추상메소드
}
class Circle extends DObject{//추상클래스를 상속받는 서브클래스(실체클래스)
    public void draw(){//추상메소드 오버라이딩하여 실체 구현
        System.out.println("Circle");
    }
}

/*접근제한자의 순서는 상관없다.*/
abstract public void test{} //특성제한자 접근제한자 반환데이터형 메소드명
public abstract void test{} //접근제한자 특성제한자 반환데이터형 메소드명
```



# final

__고정__

- final클래스는 상속될 수 없음
- final메소드는 자식클래스가 오버라이딩 할 수 없음.
- final 필드는 객체마다 저장되고, 생성자의 매개값을 통해 여러값을 가질 수 있으므로 상수가 될 수 없음

- 초기값이 저장되면 최종적인 값이 되어 프로그램 실행도중 수정할 수 없음.
- 필드 선언시 초기값을 주거나, 생성자에서 초기값을 지정(객체 생성시에 외부 데이터로 초기화해야 한다면)



# 상수(static final)

__public static final int 변수명 = 값;__

- 모든 객체가 사용가능

- 한번 초기값이 저장되면 변경 불가. 불변의 값

- 초기값이 단순 값이라면 선언시에, 복잡한 초기화일 경우 정적블록에서

- 객체마다 저장되지 않고, 클래스에만 포함 됌.

- 이름은 대문자로 작성, 단어가 혼합된 이름이라면 `언더바(_)` 로 연결

- 고정된 값 반복해서 쓰이는 경우 사용

  1년 365일, 1주일 7일 등 로직상에서 변하지 않는 고정된 값 또한 상수의 대상

  상수의 사용이 많은 클래스: Calendar Class 등



# Wrapper class

__기본형을 객체로 다루기 위해 사용하는 매칭 클래스__

| 기본형(Primitive type) | 래퍼클래스(Wrapper Class) |
| :--------------------: | :-----------------------: |
|          byte          |           Byte            |
|         short          |           Short           |
|          int           |          Integer          |
|          long          |           Long            |
|          char          |         Character         |
|         float          |           Float           |
|         double         |          Double           |
|        boolean         |          Boolean          |

- 박싱(Boxing): 기본형을 래퍼클래스로 변환하는 것
- 언박싱(Unboxing): 래퍼클래스를 기본형으로 변환하는 것
