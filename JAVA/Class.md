# 클래스(Class)

- 객체를 만드는 설계도
- 객체의 공통된 특징을 기술한 것
- 객체의 특성과 행위를 정의
- 객체를 생성하기 위한 필드와 메소드가 정의되어 있음
- 클래스로부터 만들어진 객체를 해당 클래스의 인스턴스라고 함
- 클래스의 용도
  - 라이브러리(API: Application Program Interface)용 : 다른 클래스에서 이용할 목적으로 설계
  - 실행용: main()메소드 제공 역할
  - 프로그램 전체에 단 **한개의 실행 클래스** 와 나머지의 라이브러리 클래스 

## 클래스 선언

[1] 클래스이름

- 식별자 작성 규칙

|      | 작성규칙                                                     | 예                                  |
| ---- | ------------------------------------------------------------ | ----------------------------------- |
| 1    | 하나 이상의 문자로 이루어져야 한다. <br /> 단일 단어라면 첫 글자를 대문자 나머지를 소문자로 작성, <br /> 혼합 단어라면 각 단어의 첫글자를 대문자로 작성 | Car, Member, SportsCar, ChatServer  |
| 2    | 첫번째 글자는 숫자가 올 수 없다.                             | Car3(o), 3Car(x)                    |
| 3    | '$', '_'외의 특수문자는 사용할 수 없다.                      | $Car(o), _Car(o),  @Car(x), #Car(x) |
| 4    | 자바 키워드는 사용할 수 없다.                                | int(x), for(x)                      |

<br>[2] 클래스 선언

- 일반적으로 소스파일당 하나의 클래스 선언하고 소스파일과 클래스 이름이 같도록 해야함

```java
public class Student{//public class 클래스명
    ...
}
```

- 파일하나에 여러개의 클래스를 선언하면 선언한 수 만큼 바이트 코드(.class) 파일 생성 => 소스만 하나일뿐 각기 다름
- 하나의 파일안에 클래스가 2개 이상 있을 경우 `public`접근제한자로 메인클래스(main메소드 가짐) 명시, 파일명은 메인클래스명과 같게 함. 파일이름과 같지 않은 클래스에 public 붙이면 컴파일 에러 발생

<br>[3] 객체생성과 클래스변수

- `new` 연산자: 메모리의 힙(heap)영역에 객체 생성 및 객체 주소 리턴.
- 클래스변수: 객체를 사용할 수 있음. 참조타입.

```java
/* new연산자로 객체 생성후 리턴된 객체의 주소를 변수에 저장 => 변수가 객체를 참조 */

Student s1;			//클래스변수
new Student();		//new 클래스()

또는

Student s1 = new Student();	
```

-  new연산자를 사용한 만큼 객체(클래스의 인스턴스)가 메모리에 생성. 각 객체는 자신만의 고유데이터를 가짐. 독립적



## 클래스 구성

클래스에는 객체가 가져야 할 구성멤버 **필드(Field), 생성자(Constructor), 메소드(Method)** 가 선언되며, 생략되거나 복수개가 작성될 수 있음.

객체가 생성되면 `도트(.)` 연산자를 통해 접근 가능

```java
public class ClassName{
    //1.필드: 객체의 데이터가 저장되는 곳
    int fieldName;
    
    //2.생성자: 객체 생성시 초기화 역할 담당
    ClassName() {...}
    
    //3.메소드: 객체의 동작에 해당하는 실행 블럭
    void methodName() {...}
}
```

<br>

[1] 필드

- 객체의 고유 데이터, 부품 객체, 상태 정보를 저장하는 곳, `클래스 멤버 변수` 라고도 부름

- 선언 형태는 변수와 비슷하지만 변수와 다름

  | 필드                                     | 변수                                              |
  | ---------------------------------------- | ------------------------------------------------- |
  | 생성자와 모든 메소드 전체에서 사용가능   | 자신이 선언된 생성자와 메소드 내부에서만 사용가능 |
  | 객체가 소멸되지 않는 한 객체와 함께 존재 | 생성자와 메소드가 실행 종료되면 자동 소멸         |

- 생성자와 메소드 중괄호 블록내부 외 어떤 곳에서나 선언 가능(생성자와 메소드 중괄호 블록내부에 선언된 것은 모두 로컬 변수)

- 타입은 필드에 저장할 데이터 종류 결정

  - 기본타입(byte, short, int, long, float, double, boolean)

  - 참조타입(배열, 클래스, 인터페이스)

- 초기값은 필드 선언시 주어질 수도 있고 생략될 수도 있음. 초기값이 지정되지않은 필드들은 객체 생성시 자동으로 기본 초기값으로 설정됌.

```java
/* 타입 필드명 [= 초기값] */

String name = "홍길동";
int age = 20;
String adderess;
boolean experience;
```

- 필드를 사용한다 = 필드값을 읽고 변경한다
  - 클래스내부: 단순히 필드 이름으로 읽고 변경
  - 클래스외부: 클래스로부터 객체를 생성한 뒤 필드 사용

<br>

[2] 생성자

- 객체 생성시 초기화 담당 - 필드를 초기화하거나 메소드를 호출해서 객체를 사용할 준비를 함
- 메소드와 비슷하게 생겼지만, 리턴타입이 없음. 클래스 이름과 동일
- new 연산자로 호출되는 `{}` 블록
- 생성자를 실행시키지 않고는 클래스로부터 객체를 만들수 없음
- 모든 클래스는 생성자가 반드시 존재하며, 하나 이상을 가질 수 있음
- 기본 생성자
  - 생성자 선언 생략 시 {} 내용이 비어있는 기본 생성자를 자동 추가함.
  - 클래스에 명시적으로 선언한 생성자가 한개 라도 있으면 기본생성자 추가하지않음.


- 매개 변수 선언은 생략할 수 도 있고 여러개를 선언할 수도 있음
  - 매개변수는 생성자 호출 시 외부의 값을 생성자 블록 내부로 전달하는 역할

- 생성자 오버로딩
  - 매개변수의 타입, 개수 등을 달리하여 생성자를 여러개 선언하는 것
- 오버로딩 많아질 경우 생성자간 중복된 코드 발생할 수 있음 => 다른 생성자 호출하는 방법으로 개선가능
  - this는 자신의 다른 생성자를 호출하는 코드. 반드시 생성자의 첫줄에서만 허용

```java
public class Car{
    ...
    Car(){}//기본생성자
    Car(String type){...객체 초기화 코드}//매개변수 생성자, 생성자 오버로딩
    Car(String type, String color){...}
    Car(String type, String color, int maxSpeed){
    	this(type,color);//클래스의 다른 생성자 호출
        this.maxSpeed = maxSpeed;
    }
	...
}
Car car1 = new Car();
Car car2 = new Car("자가용"); //생성자를 이용한 필드 초기화
Car car3 = new Car("택시","흰색");
Car car4 = new Car("자가용","검정",200);
```

<br>

[3] 메소드

- 객체의 동작 - 필드를 읽고 수정, 다른 객체를 생성해서 다양한 기능 수행.
- 객체 간 데이터 전달의 수단으로 사용 - 외부로부터 매개값을 받을 수도 있고 실행 후 값을 리턴할 수도 있음

- 메소드 호출시 중괄호 블록에 있는 모든 코드들이 일괄적으로 실행됌

- 메소드 선언부(리턴타입,메소드명,매개변수선언)와 실행블록으로 구성되며 선언부를 시그너처(signature)라고도 함

```
리턴타입 메소드명 (매개변수, ...){
	...실행블록
}
```

1. 리턴타입: 메소드가 실행후 리턴하는 값의 타입. 리턴값이 없을 수도 있음(타입 void), 리턴타입이 있다해서 반드시 리턴값을 변수에 저장할 필요는 없음.

```java
- 리턴값이 있는 메소드: 선언에 리턴타입이 있다면 반드시 리턴문 사용해서 리턴값 지정. return문 실행되면 메소드 즉시 종료. 리턴값은 리턴타입이거나 리턴타입으로 변환될 수 있어야 함
- 리턴값이 없는 메소드: void 로 선언된 리턴값 없는 메소드에서도 return문 사용가능함.=> return ; (메소드 실행 강제종료)
```

2. 메소드명: 메소드가 어떤 기능을 수행하는지 쉽게 알 수 있도록 기능 이름으로 짓는 것이 좋음. 너무 짧지 않도록 함.

```
식별자 규칙
- 숫자로 시작할 수 없음
- '$'와 '_'을 제외한 특수문자 사용X
- 소문자로 작성(관례적)
- 단어가 혼합된 이름이라면 뒤에오는 단어의 첫 글자는 대문자로 작성
```

3. 매개변수선언: 메소드가 실행할 때 필요한 데이터를 외부로부터 받기 위해 사용
   - 매개변수의 갯수 모를때: 매개변수를 배열타입으로 선언 => 배열 항목 수는 호출할 때 결정, 배열을 생성하지 않고 값의 리스트만 넘겨주는 방법도 있음.

```java
/* 메소드 선언 */
void powerOn(){
	System.out.println("전원on");
}
double divide(int x,int y){...}
//배열타입으로 선언
int sum1(int[] values){...}
int sum2(int … values){...}

/* 메소드 호출 */
powerOn();
divide(50,5);
int[] values = {1,2,3};
int result = sum1(values);

int result2 = sum1(new int[] {1,2,3,4,5});

int result3= sum2(1,2,3); // …로 선언된 매개변수는 배열타입이므로 메소드 호출시 리스트로 나열
```

- 메소드 호출

  - 클래스 내부의 다른 메소드에서 호출 시, 단순한 메소드 이름으로 호출

  - 클래스 외부에서 호출할 경우, 클래스로부터 객체 생성 후 참조변수를 이용해 메소드 호출(객체가 존재하지 않으면 메소드도 존재하지 않기 때문)

- 메소드 오버로딩
  - 같은 이름의 메소드를 여러개 선언하는 것. 매개 변수의 타입, 개수, 순서중 하나가 달라야 함
  - 매개값을 다양하게 받아 처리할 수 있도록 하기 위해 필요함
