# 제네릭

- 클래스나 메소드의 자료형을 매개변수 형식으로 사용할 수 있는 기능
- 객체를 저장하는 기술인 Collection Framework의 단점을 개선 
- 제네릭 클래스와 메소드 모두 가지고 있을 때, 타입 파라미터 T는 각각 다름. 같지 않아도 됌
- 장점
  - 컴파일 시 강한 타입 체크를 통해 에러를 사전에 방지
  - 불필요한 타입변환(casting)을 제거를 통해 프로그램 성능 향상

## 제네릭 타입

- 정의 : 타입을 파라미터로 가지는 클래스와 인터페이스, 클래스 또는 인터페이스 이름 뒤에 `"<>"` 부호가 붙고 사이에 타입 파라미터 T가 위치.

- 객체 생성시 타입 확정. 속성이나 메소드의 자료형으로 사용

- 클래스를 설계할 때 구체적인 타입을 명시하지 않고, 타입 파라미터로 대체했다가 실제 클래스가 사용될 때 구체적인 타입을 지정함으로써 타입변환을 최소화
- 멀티 타입 파라미터: 두개 이상의 타입 파라미터를 사용

```java
public class 클래스명<T> {...}
public class 클래스명<T,V> {...}
public interface 인터페이스명<T> {...}
public interface 인터페이스명<T,V> {...}
```

## 제네릭 메소드

- 정의 : 매개 타입과 리턴타입으로 타입 파라미터를 갖는 메소드
- 호출방식
  - 코드에서 타입 파라미터의 구체적 타입 지정(명시적)
  - 컴파일러가 매개값 타입을 보고 구체적 타입 추정

```java
public <T> 리턴타입 메소드명(매개변수,...){...}
리턴타입 변수 = <구체적 타입> 메소드명(매개값);	// 명시적으로 구체적 타입 지정
리턴타입 변수 = 메소드명(매개값);	//	매가값을 보고 구체적 타입 추정
```

## 제한된 타입 파라미터(bounded type parameter)

- 정의 : 타입 파라미터 뒤에 `extends` 키워드 붙이고 상위타입 명시, 클래스 뿐 아니라 인터페이스도 가능
- 타입 파라미터에 지정되는 구체적 타입은 상위 타입이거나 상위 타입의 하위 또는 구현 클래스만 가능
- 메소드의 중괄호 안에서 타입 파라미터 변수로 사용 가능한 것은 상위타입의 멤버(필드, 메소드)로 제한. 하위 타입에만 있는 필드와 메소드는 사용할 수 없음

```java
public <T extends 상위타입> 리턴타입 메소드(매개변수, ...) {...}

public class Util{
    public <T extends Number> int compare(T t1, T t2){//제네릭 메소드
        double v1 = t1.doubleValue();
        double v1 = t1.doubleValue();
        return Double.compare(v1,v2);
    }
}
public class BoundedTypeParameterExample{//제네릭 메소드 호출
    public static void main(String[] args){
        //String str = Util.compare("a", "b");		// -> (x) : "a","b"는 String으로 Number타입이 아님
        
        int result1 = Util.compare(10, 20);			//Integer로 자동 변환. 매개값으로 구체적 타입 추정
        System.out.println(result1);
        
        int result2 = Util.compare(4.5, 3);			//Double로 자동변환. 매개값으로 구체적 타입 추정
        System.out.println(result2);
        
    }
} 
```

## 와일드 카드 타입

- 제네릭 타입을 매개값이나 리턴타입으로 사용할 때 구체적인 타입 대신에 와일드 카드를 세가지 형태로 사용

```java
- 제네릭타입<?> : Unbounded Wildcards(제한없음)
	타입 파라미터를 대치하는 구체적 타입으로 모든 클래스나 인터페이스 타입이 올 수 있음

- 제네릭타입<? extends 상위타입> : Upper Bounded Wildcards(상위클래스 제한)
    타입 파라미터를 대치하는 구체적 타입으로 상위 타입이나 하위 타입만 올 수 있음

- 제네릭타입<? super 하위타입> : Lower Bounded Wildcards(하위클래스 제한)
    타입 파라미터를 대치하는 구체적 타입으로 하위 타입이나 상위 타입이 올 수 있음
```

![image](https://user-images.githubusercontent.com/103404127/175758920-e8ca8e86-74ef-4099-99a3-053ad5b721d9.png)

클래스의 구조가 위와 같을 때

```java
- Course<?>
	수강생은 모든 타입(Person, Worker, Student, HighStudent)이 될 수 있음
- Course<? extends Student>
  	수강생인 Student와 HighStudent만 될 수 있음
- Course<? super Worker>
    수강생은 Worker와 Person만 될 수 있음
```

## 제네릭 타입의 상속과 구현

다른 타입과 마찬가지로 부모클래스가 될 수 있음.

자식 제네릭 타입은 추가적으로 타입 파라미터를 가질 수 있음.

제네릭 인터페이스를 구현한 클래스도 제네릭 타입이 됌.

```java
public class Child<T,M> extends Super<T,M> {...}
public class Child<T,M,C> extends Super<T,M> {...}
```

