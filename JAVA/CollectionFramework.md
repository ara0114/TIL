# Collection Framework

**컬렉션 프레임워크**: 몇가지 인터페이스를 통해 다양한 컬렉션 클래스를 이용할 수 있도록 한 것.

객체를 저장하는 기술, 동적 크기 변경 가능, 메모리 낭비를 피할 수 있음.

(\* 컬렉션: 객체를 수집해서 저장하는 역할 / 프레임워크: 사용방법을 미리 정해 놓은 라이브러리)

=> 주요 인터페이스 : *List, Set, Map* 

![image](https://user-images.githubusercontent.com/103404127/176895395-cd026c84-5953-4a83-923a-f265e9bfe517.png)

![image](https://user-images.githubusercontent.com/103404127/176897736-f9a30eae-692c-4fea-b302-abcdafc61d24.png)

<br>

## 1. List

- 객체를 일렬로 늘어놓은 구조.

- 객체를 인덱스로 관리 => 객체를 저장하면 자동 인덱스가 부여되고 인덱스로 객체를 검색, 삭제할 수 있음

- 객체 자체를 저장하는 것이 아니라 객체의 번지를 참조하는 것

  - 동일 객체를 중복 저장 시, 동일한 번지 참조

  - null 저장 시, 객체를 참조하지 않음

- 메소드

![image](https://user-images.githubusercontent.com/103404127/176904427-44e4fe80-2bb1-46b6-b27d-15e68841a04f.png)

```java
List<String> list = "...";
list.add("abc");	//맨끝에 객체 추가
list.add(1,"def");	//지정된 인덱스에 객체 삽입
String str = list.get(1);	//인덱스로 객체 찾기 -> 인덱스 1에 있는 객체
list.remove(0);		//인덱스로 객체 삭제 -> 인덱스 0에 있는 객체
list.remove("def");	//객체 삭제
/*--------------------------------------------------------------------*/

for(int i=0; i<list.size(); i++){//전체 객체 대상으로 하나씩 반복하여 저장된 객체 얻기
    String str = list.get(i);	//인덱스 i에 저장된 String 객체가져옴 
}
for(String str : list){ }//인덱스 필요없을때 String 객체 하나씩 가져오기
```

### Array List

- List 인터페이스 구현클래스
- capacity(저장용량)를 초과한 객체가 들어오면 자동으로 capacity가 늘어남(기본 10개, 처음부터 용량 크기 설정가능)
- 객체 추가시 인덱스 0부터 차례로 저장
- 빈번한 객체 삽입/삭제가 일어나는 곳에선 사용이 바람직하지 않음 => LinkedList사용
  - 특정 인덱스의 객체 제거시 바로 뒤 인덱스 부터 모두 앞으로 당겨짐
  - 특정 인덱스에 객체 삽입시 해당 인덱스부터 모두 뒤로 밀려남
- 인덱스 검색이나 맨 마지막에 객체를 추가하는 경우(순차적인경우) LinkedList보다 좋은 성능
- 고정된 객체들로 List를 생성할 때도 있음 => Arrays.asList(T...a)메소드 사용
  - asList()의 매개값 순차적으로 입력 또는 T[]배열 매개값으로 주기

```java
List<String> list = new ArrayList<String>();	//ArrayList생성
List<String> list = new ArrayList<String>(30);	//capacity가 30인 ArrayList생성
List<T> list = Arrays.asList(T...a);	//고정된 객체들로 구성된 List생성

List<String> list1 = Arrays.asList("abc","def");
List<Integer> list2 = Arrays.asList(1,2);
```

### Vector

- ArrayList와 동일한 내부구조
- 동기화된 메소드로 구성 => 멀티스레드 환경에서 안전하게 객체 추가/삭제
  - 멀티스레드가 동시에 메소드 실행 불가(스레드 하나가 실행 완료하면 다른 스래드 실행)

```java
List<E> list = new Vector<E>();	//Vector생성
```

### Linked List

- ArrayList와 사용방법 같음. 내부구조는 다름
- 인접 참조를 링크해서 체인처럼 관리
- 빈번한 객체 삽입/삭제 시 ArrayList보다 좋은 성능
  - 특정 인덱스의 객체 제거시 앞뒤 링크만 변경(나머지 변경x)
- 처음 생성시 내부 비어있음(어떤 링크도 만들어 지지 않으므로)

```java
List<E> list = new LinkedList<E>();	//LinkedList생성
```

### 성능비교

|    구분    | 검색 | 중간에 추가/삭제 | 끝에 추가/삭제(순차적) |
| :--------: | :--: | :--------------: | :--------------------: |
| ArrayList  | 빠름 |       느림       |          빠름          |
| LinkedList | 느림 |       빠름       |          느림          |

<br>

## 2. Set

- 저장순서 유지X, 객체 중복저장X, 하나의 null만 허용
- 집합
- 메소드

![image](https://user-images.githubusercontent.com/103404127/176911758-ac127eb6-08c8-4e5c-b3e7-168566e9fb22.png)

- 인덱스가 없음. 
- 전체 객체를 대상으로 한번씩 반복해서 가져오는 반복자(Iterator-Iterator인터페이스 구현한 객체)제공
  - Iterator 인터페이스 메소드

| 메소드            | 설명                                    |
| ----------------- | --------------------------------------- |
| boolean hasNext() | 가져올 객체가 있으면 true, 없으면 false |
| E next()          | 하나의 객체 가져오기                    |
| void remove()     | Set컬렉션의 객체 제거                   |

```java
Set<String> set = ...; //set타입 String으로
Iterator<String> iterator = set.iterator();	//전체 객체 대상으로 한번씩 반복해서 가져오는 iterator선언
while(iterator.hasNext()){//가져올 객체가 있다면
    String str = iterator.next();//하나 가져오기
    if(str.equals("abc")){
        iterator.remove();//next로 가져온 객체 제거(set에서 제거)
    }
}
/*--------------------------------------------*/
Set<String> set = ...;
for(String str : set){  }	//Iterator사용하지 않더라도 전체 객체 대상으로 반복
```

### HashSet

- Set 인터페이스 구현클래스

- 순서X

- 동일한 객체 중복 저장X

  - 동일객체 != 같은 인스턴스

  - 객체 저장 전 hashCode() 호출하여 해시코드를 얻어 이미 저장되어있는 객체들의 해시코드와 비교

  - 동일한 해시코드가 있을 경우 다시 equals() 메소드로 두 객체 비교후 true면 동일객체로 판단 => 중복저장x

<br>

## 3. Map

- 키(key)와 값(value)로 구성된 쌍을 저장하는 구조(키와 값 모두 객체)

- 키는 중복저장 X, 값은 중복저장O

  => 동일한 키로 값 저장시 기존 값 사라지고 새로운 값으로 대치

- 키로 객체 관리

- 메소드

![image-20220702000741811](CollectionFramework.assets/image-20220702000741811.png)



