# Collections Framework

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

   ​          └ 많이 사용 ┘

   - List

   ​         ↑

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