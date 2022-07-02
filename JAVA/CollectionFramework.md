# Collection Framework

**컬렉션 프레임워크**: 몇가지 인터페이스를 통해 다양한 컬렉션 클래스를 이용할 수 있도록 한 것.

객체를 저장하는 기술, 동적 크기 변경 가능, 메모리 낭비를 피할 수 있음.

(\* 컬렉션: 객체를 수집해서 저장하는 역할 / 프레임워크: 사용방법을 미리 정해 놓은 라이브러리)

=> 주요 인터페이스 : *List, Set, Map* 

![image](https://user-images.githubusercontent.com/103404127/176895395-cd026c84-5953-4a83-923a-f265e9bfe517.png)

![image](https://user-images.githubusercontent.com/103404127/176897736-f9a30eae-692c-4fea-b302-abcdafc61d24.png)

<br>

## List

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

## Set

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

## Map

- 키(key)와 값(value)로 구성된 쌍을 저장하는 구조(키와 값 모두 객체)

- 키는 중복저장 X, 값은 중복저장O

  => 동일한 키로 값 저장시 기존 값 사라지고 새로운 값으로 대치

- 키로 객체 관리

- 메소드

![image](https://user-images.githubusercontent.com/103404127/176922379-8918bdb2-1897-49c2-93c4-d5422338e851.png)

- 저장된 전체 객체를 대상으로 하나씩 찾아오고 싶은 경우

```java
//1. keySet()
Map<K,V> map= ~;
Set<K> keySet = map.keySet();//모든 키를 Set컬렉션으로
Interator<K> keyIterator = keySet.iterator();
while(keyIterator.hasNext()){
    K key = keyIterator.next();//키를 하나씩 얻기
    V value = map.get(key);//키로 객체 찾아 값 가져오기
}

//2. entrySet()
Set<Map.Entry<K,V>> entrySet = map.entrySet();//모든 Map.Entry를 Set컬렉션으로
Iterator<Map.Entry<K,V>> entryIterator = entrySet.iterator();
while(entryIterator.hasNext()){
    Map.Entry<K,V> entry = entryIterator.next();//Map.Entry를 하나씩 얻기
    K key = entry.getKey();
    V value = entry.getValue();
}
```

### HashMap

- Map 인터페이스 구현 클래스
- 동등 객체가 될 조건 = 동일한 키가 될 조건
  - hashCode() 리턴값 같아야 함
  - equals() 메소드가 true

- 키와 값 타입은 클래스 킻 인터페이스 타입만 가능

```java
Map<K, V> map = new HashMap<K,V>();	//HashMap생성
```

### Hashtable

- HashMap과 동일한 내부 구조
- hashCode(), equals()
- 동기화된 메소드로 구성 => 멀티스레드 환경에서 안전하게 객체 추가/삭제
  - 멀티스레드가 동시에 메소드 실행 불가(스레드 하나가 실행 완료하면 다른 스래드 실행)

```java
Map<K, V> map = new Hashtable<K, V>(); //Hashtable생성
```

### Properties

- Hashtable의 하위클래스 => Hashtable의 모든 특징 그대로 가짐
- 키와 값이 **String타입으로 제한**됌
- 프로퍼티 파일을 읽을 때 주로 사용
- 프로퍼티 파일(*.properties)
  - 애플리케이션 옵션정보, DB연결정보, 국제화(다국어) 정보가 저장
  - 키와 값이 = 기호로 연결되어있는 텍스트 파일
- 프로퍼티 파일 읽기

```java
String path = 클래스.class.getResource("프로퍼티파일").getPath();
//클래스 파일 기준으로 상대경로를 이용해 프로퍼티 파일 경로 얻기
//getResource: 주어진 파일 상대경로 URL객체로 리턴
//getPath: 파일의 절대 경로 리턴
path = URLDecoder.decode(path,"utf-8");
Properties properties = new Properties(); //프로퍼티 파일 객체 생성
properties.load(new FileReader(path));//load: 프로퍼티 파일에서 데이터 읽기
```

- 키 값 읽기위해 getProperty() 메소드 이용
  - get()은 Object타입, 강제타입변환을 통해 String 얻어야하므로 주로 getProperty 사용 

<br>

## 검색기능을 강화시킨 컬렉션

### 이진트리구조(binary Tree)

- 여러개의 node가 트리 형태로 연결된 구조
- root node에서 시작해서 각 노드에 최대 2개의 노드를 연결할 수 있는 구조
- 위아래로 연결된 두 노드를 부모-자식관계(부모노드-자식노드)
- 1개의 부모노드는 최대 2개의 자식노드와 연결
- 부모 노드의 값 보다 작은 노드는 왼쪽에, 큰 노드는 오른쪽에 위치(값이 정렬되어 있음)
  - 왼쪽자식->부모->오른쪽자식 : 오름차순
  - 오른쪽 자식->부모->왼쪽자식 : 내림차순

### TreeSet

- 이진트리기반 Set컬렉션
- 하나의 노드는 노드값인 value, 왼쪽/오른쪽 자식노드를 참조하기 위한 두개의 변수로 구성
- 자동정렬: 부모값과 비교해 낮은 것은 왼쪽 자식노드, 높은 것은 오른쪽 자식노드에 저장

### TreeMap

- 이진트리기반 Map컬렉션
- 키와 값이 저장된 Map.Entry저장
- 자동정렬: 부모 키 값과 비교해 낮은 것은 왼쪽 자식노드, 높은 것은 오른쪽 자식노드에 저장

<br>

## LIFO와 FIFO 컬렉션

- LIFO(Last In First Out) : 나중에 넣은 것 먼저 빠져나감
- FIFO(First In First Out) : 먼저 넣은 것 먼저 빠져나감

### Stack

- LIFO 구조
- JVM 스택메모리가 대표적
- 주요 메소드

| 메소드         | 설명                                           |
| -------------- | ---------------------------------------------- |
| E push(E item) | 주어진 객체를 스택에 넣음                      |
| E peek()       | 스택의 맨 위 객체 가져옴(객체 스택에서 제거 X) |
| E pop()        | 스택의 맨 위 객체 가져옴(객체 스택에서 제거 O) |

### Queue

- FIFO 구조
- 스레드풀의 작업 큐가 대표적

- 주요 메소드

| 메소드             | 설명                                 |
| ------------------ | ------------------------------------ |
| boolean offer(E e) | 주어진 객체를 넣음                   |
| E peek()           | 객체 하나 가져옴(객체 큐에서 제거 X) |
| E poll()           | 객체 하나 가져옴(객체 큐에서 제거 O) |

- Queue인터페이스를 구현한 대표적 클래스: *LinkedList*(List 인터페이스를 구현하여 List컬렉션이기도 함)

