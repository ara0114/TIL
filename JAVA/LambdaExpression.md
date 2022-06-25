# 람다식

- 배경 : 객체 지향 프로그래밍과 함수적 프로그래밍을 혼합함으로써 효율적인 프로그래밍이 될 수 있도록 개발 언어가 변하고 있는데 그중 하나가 자바의 람다식(자바8부터 지원)

​		(*함수적 프로그래밍의 장점 : 병렬 처리와 이벤트 지향 프로그래밍에 적합)

## 람다식이란?

- 익명함수(Anonymous functions)를 생성하기 위한 식, 함수지향 언어에 가까움

- 장점 
  - 간결한 코드
  - 컬렉션 요소 필터링 또는 매핑 => 원하는 결과를 쉽게 집계
- `(매개변수) -> {실행코드}` 의 형태로 작성
- 매개 변수를 가진 코드블록. 함수 정의 형태를 띠고 있으나 런타임 시 인터페이스의 익명 구현 객체로 생성
- 어떤 인터페이스를 구현할 것인가는 대입되는 인터페이스(람다식의 타겟 타입)가 무엇이냐에 달려있음

```java
/* Runnable 인터페이스의 익명 구현 객체를 생성하는 전형적인 코드 */
Runnable runnable = new Runnable(){
    public void run(){...}
};

/* 람다식 표현(인터페이스 변수에 람다식 대입) */
Runnable runnable = () -> {...};
```

## 람다식 기본 문법

- 함수적 스타일의 람다식을 작성하는 방법

```java
(타입 매개변수, ...) -> { 실행문; ... }
//	(타입 매개변수, ...)는 중괄호 블럭을 실행하기 위해 필요한 값을 제공하는 역할
//	-> 기호는 매개변수를 이용해 중괄호를 실행한다는 뜻으로 해석

() -> {실행문; ...}
//	매개변수가 없다면 람다식에서 매개변수 자리 없어지므로 빈 괄호 반드시 사용
```

- 예시

```java
(int a) -> {System.out.println(a);}

//	런타임시 대입되는 값에 따라 자동으로 매개변수 타입 인식 => 일반적으로 매개변수 타입 언급 x
(a) -> {System.out.println(a);}

//	매개변수 하나라면 괄호 생략가능, 실행문 하나라면 중괄호 생략가능
a -> System.out.println(a);

/*---------------------------------------------------------*/

(x,y) -> {return x+y;};

//중괄호에 return문만 있을 경우 return문 사용안하고 작성 가능
(x,y) -> x+y
```

## 클래스 멤버와 로컬 변수 사용

- 람다식의 실행 블록에서는 클래스의 멤버(필드, 메소드) 및 로컬변수를 사용할 수 있음.

- 클래스 멤버는 제약 사항 없이 사용 가능, 로컬 변수는 제약 사항이 따름

[1] 클래스의 멤버 사용

- 람다식 실행 블록에는 클래스의 멤버인 필드와 메소드를 제약 사항 없이 사용할 수 있음.
- `this`  키워드를 사용시 주의가 필요
  - 람다식에서 this는 내부적으로 생성되는 익명 객체의 참조가 아니라 *람다식을 실행한 객체의 참조*

[2] 로컬 변수 사용

- 람다식은 메소드 내부에서 주로 작성되므로 로컬 익명 구현 객체를 생성시킨다고 봐야함
- 바깥 클래스의 필드나 메소드는 제한 없이 사용할 수 있으나, 메소드의 매개 변수 또는 로컬 변수를 사용하면 두 변수는 `final` 특성을 가져야 함. => 매개변수 또는 로컬 변수를 람다식에서 읽는 것은 허용되나, 람다식 내부 또는 외부에서 변경할 수 없음



## 메소드 참조

메소드를 참조해서 매개변수의 정보 및 리턴타입을 알아내, 람다식에서 불필요한 매개변수를 제거하는 것이 목적

[1] 정적 메소드와 인스턴스 메소드 참조

- 정적 메소드 참조 : 클래스 이름 뒤에 ::기호를 붙이고 정적 메소드 이름 기술
- 인스턴스 메소드 참조 :  객체를 생성 후 참조 변수 뒤에 :: 기호를 붙이고 인스턴스 메소드 이름 기술

```java
클래스 :: 메소드			//	정적 메소드 참조
참조변수 :: 메소드			//	인스턴스 메소드 참조
```

- 예시

```java
public class Calculator{
    public static int staticMethod(int x, int y){	//	정적 메소드
        return x+y;
    }
    public int instanceMethod(int x, int y){		//	인스턴스 메소드
        return x+y;
    }
}

public class MethodReferencesExample{
    public static void main(String[] args){
        IntBinaryOperator operator;
        
        operator = (x,y) -> Calculatr.staticMethod(x,y); // 정적 메소드 참조
        operator = Calculator :: staticMethod;
        
        Calculator obj = new Clculator();
        operator = (x, y) -> obj.instanceMethod(x,y);	//	인스턴스 메소드 참조
        operator = obj :: instanceMethod;
    }
}
```

[2] 매개변수의 메소드 참조 : 람다식에서 제공되는 a 매개변수를 호출해서 b 매개 변수를 매개값으로 사용하는 경우

```java
클래스 :: instanceMethod
    
// (a,b) -> { a.instanceMethod(b); }를 의미
```

[3] 생성자 참조 : 객체 생성을 의미, 객체를 생성하고 리턴하도록 구성된 람다식은 생성자 참조로 대치할 수 있음

- 생성자가 오버라이딩 되어 여러개 있을 경우, 컴파일러는 함수적 인터페이스의 추상 메소드와 동일한 매개 변수 타입과 갯수를 가지고 있는 생성자를 찾아 실행함. 해당 생성자가 존재하지 않으면 컴파일 오류 발생.

```java
클래스 :: new

// (a,b) -> { return new 클래스(a,b); }
```



## 타겟 타입

- 람다식은 인터페이스 변수에 대입 됌 => 람다식은 익명 구현 클래스를 생성하고 객체화 함
- 람다식은 **대입될 인터페이스(람다식의 타겟 타입)** 종류에 따라 작성방법이 달라짐

### 함수적 인터페이스

- 하나의 추상 메소드가 선언된 인터페이스만이 람다식의 타겟 타입이 될 수 있고, 이러한 인터페이스를 함수적 인터페이스라 함.

- `@FunctionalInterface` : 함수적 인터페이스 작성시 두개 이상의 추상메소드가 선언되지 않도록 컴파일러가 체킹(두개 이상 선언될 경우 오류 발생)해주는 어노테이션, 선택사항

- 함수적 인터페이스의 추상 메소드의 선언형태에 따라 람다식 작성 방법이 달라짐

​	[1] 매개 변수와 리턴값이 없는 추상 메소드

```java
/* 함수적 인터페이스 */
@FunctionalInterface
public interface MyFunctonalInterface{
    public void method();
}
/* 람다식의 작성 */
MyFunctionalInterface f = () -> {...}
/* 호출 방법 */
f.method();
```

  [2] 매개 변수가 있고 리턴값이 없는 추상 메소드

```java
/* 함수적 인터페이스 */
@FunctionalInterface
public interface MyFunctonalInterface{
    public void method(int x);
}
/* 람다식의 작성 */
MyFunctionalInterface f = (x) -> {...}
또는
MyFunctionalInterface f = x -> {...}
/* 호출 방법 */
f.method(3);
```

  [3] 매개 변수가 있고 리턴값이 있는 추상메소드

```java
/* 함수적 인터페이스 */
@FunctionalInterface
public interface MyFunctonalInterface{
    public int method(int x, int y);
}
/* 람다식의 작성 */
MyFunctionalInterface f = (x, y) -> {...; return 값; }
만약 중괄호 안에 return문만 있고, return문 뒤에 연산식이나 메소드 호출이 오는 경우라면 다음과 같이 작성가능
1. MyFunctionalInterface f = (x, y) -> { return x+y; } 는 MyFunctionalInterface f = (x, y) -> x+y;
2. MyFunctionalInterface f = (x, y) -> { return sum(x,y); } 는 MyFunctionalInterface f = (x, y) -> sum(x,y);
/* 호출 방법 */
int result = f.method(2,5);
```

