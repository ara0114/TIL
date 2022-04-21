# Collections Framework

객체를 저장하는 기술

- 쉽고 사용 빈도는 높음
- 배열의 단점을 개선, 객체만 저장
- 동적 크기 변경 가능, 메모리 낭비를 피할 수 있음
- Set, List, Map 자료구조

1. Set

   - 순서 X(index X) → 중복 X
   - HashSet, TreeSet
   - Iterator나 배열 이용해서 순차적 접근/출력
   
2. List

   - 순서 O → 중복 O
   - ArrayList, Vector, LinkedList

   ​    └ 많이 사용 ┘

   - List

   ​    ↑

    ArrayList

   - subList()는 subString()처럼 이해

   - Vector
     - size(): 내가 입력한 요소의 사이즈
     - capacity(): 가용용량, 요소가 들어갈 수 있는 처음 크기, 다 채워지면 크기의 2배로 증가
     - trimToSize(): capacity를 size크기로 줄이는 역할
   
3. Map

   - Key, value 한쌍

   - 중복된 Key값은 허용하지 않지만(사용하면 기존 값 삭제), 중복된 value값은 허용한다.

   - Map타입을 인터페이스로 구현하는 HashMap, Hashtable

     - HashMap은 Iterator(keySet)만 사용가능하고,

       Hashtable은 Enumeration(keys), Iterator(keySet)모두 사용가능

   - put()으로 입력

   - 검색결과 없으면 null

   - keySet(): 키들을 set구조로 가져오겠다.

   - properties: 문자열 key, value



# Generics

클래스나 메소드의 자료형을 매개변수 형식으로 사용할 수 있는 기능

- 객체를 저장하는 기술인 Collection Framework의 단점을 개선
- `<T>` 선언하고 생성할때 사용할 실제 타입
- 제너릭을 쓰면 그 타입만 들어갈 수 있고, 잘못된거 들어가면 바로 알려준다.
- 객체 생성시 타입 확정

- 클래스나 인터페이스 이름 옆에 `<T>`, 객체생성시 타입 전달 받아 속성이나 메소드의 자료형으로 사용
- 멀티타입으로 여러개도 사용가능

```JAVA
Class Generic<T>{}
Class Multitype<T,V>{}
interface Generic<T>
```

- 메소드 리턴형 앞에 `<T>`

```java
public <T> void GenericMethod{}
```

- 제너릭 클래스와 메소드 모두 가지고 있을때, T는 각각 다름. 같지 않아도 됌

- 가변인자와 개선된 for문

```java
public void add(T ... args) {//가변인자
    for(T e : args) {//개선된 for문, args 처음부터 끝까지 모두 접근하는 for문 실행
        			 //개선된 for문 인자는 배열이 온다고 생각
      value[index++] = e;
    }
  }
```

