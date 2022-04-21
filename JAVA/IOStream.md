# IO Stream(표준입출력, 파일입출력)

프로그램이 가지고 있는 or 가지고 있지 않은 데이터를 외부(다른프로그램)로 보내거나 가져오는 동작

- Stream은 연속적인 데이터 흐름. 단방향 구조. 전송하려는 데이터 많을 경우 지연시간 발생

| byte단위 처리(한글 처리 불가능) |                         | 2byte 문자 단위(한글 처리 가능) |
| ------------------------------- | ----------------------- | ------------------------------- |
| InputStream                     | 기본 입력 스트림 클래스 | Reader                          |
| OutputStream                    | 기본 출력 스트림 클래스 | Writer                          |
| FileInputStream                 | 파일 입력 스트림 클래스 | FileReader                      |
| FileOutputStream                | 파일 출력 스트림 클래스 | FileWriter                      |
| BufferedInputStream             | 버퍼 입력 기능 클래스   | BufferedReader                  |
| BufferedOutputStream            | 버퍼 출력 기능 클래스   | BufferedWriter                  |

- 기본형 데이터(int, float, double, ...)를 바이트스트림으로 입/출력하는 클래스
  - __DataInputStream__: 데이터 타입을 지정하여 입력할 수 있는 클래스
  - __DataOutputStream__: 데이터 타입을 지정해서 출력할 수 있는 클래스
  
- 객체를 쓰고 읽는 클래스(객체를 스트림으로 만든다) = __"직렬화"__  --아래에서 다시

  - __ObjectInputStream__: Class 객체를 읽어 올 수 있음

  - __ObjectOutputStream__: Class객체를 출력 할 수 있음

    

## 표준 입출력
키보드로 입력하는 것을 표준입력, 화면으로 출력하는 것을 표준 출력

1. 표준출력: System.out.printf()

| 표현 | 형태          |
| ---- | ------------- |
| %d   | int           |
| %c   | char          |
| %s   | String        |
| %x   | 16진수        |
| %o   | 8진수         |
| %f   | float, double |
| %e   | 공학 계산용   |

2. 표준입력: Scanner

| 메소드       | 뜻                                  |
| ------------ | ----------------------------------- |
| next()       | 빈공간 기준 한 단어(글자)씩         |
| nextLine()   | 빈공간 기준 한 줄씩(엔터---13)      |
| nextByte()   | -128 ~ +127 범위의 정수 입력        |
| nextShort()  | -32768 ~ +32767 범위의 정수 입력    |
| nextInt()    | 약 -21억 ~ +21억 범위의 정수 입력   |
| nextLong()   | 약 -900경 ~ +900경 범위의 정수 입력 |
| nextFloat()  | 실수 입력(소수점 아래 7자리)        |
| nextDouble() | 실수 입력(소수점 아래 15자리)       |



## 파일 입출력

파일을 읽어 내용을 입력하거나 파일에 내용을 출력

→ 수업 코드들 보고 반복

---

System.in: 키보드 표준입력 
new InputStreamReader(System.in): 입력을 받아 문자 인코딩을 실행 
new BufferedReader(): 입력받은 문자를 버퍼에 저장하는 역할 및 저장소 역할

​                   System.in 
​                    ↑  
​           InputStreamReader(System.in) 
​          ↑ 
new BufferedReader(new InputStreamReader(System.in)) 



read(): 1바이트(한글자)씩 읽어옴 -> FileReader

readLine(): 한줄씩 읽어옴, 반드시 예외처리해야함 -> BufferedReader



데이터를 주고 받을땐 DataInputStream, DataOutputStream, writeXXX메소드, readXXX메소드



`append`: true - 내용추가(이어쓰기), false - 덮어쓰기

-1: 파일의 끝

13: 엔터

line==null: 읽어올게 없다면

spilt(","): `,` 기준으로 쪼개서 하나씩

new Date().toLocaleString(): 현재위치의 로컬날짜

---

Serialization(직렬화) ↔ Desrialization(역직렬화)

: 인스턴스가 파일에 저장될 때 저장을 위해 거치는 과정

→ Serializable 인터페이스

: 인터페이스지만 추상메소드 존재X, __직렬화의 대상임을 표시하는 인터페이스__



멤버변수 앞에 `transient` 붙으면 직렬화 대상제외(내보내지않겠다.)



FileOutputStream: 방향만알려줌 파일로 내보낼거다

↔ FileInputStream : 읽어올거다



Object~ : 객체형태로
