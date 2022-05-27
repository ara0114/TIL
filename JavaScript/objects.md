<h3>1. 객체(Objects)</h3>

JavaScript 데이터 유형 중 하나.

관련 데이터 및 기능 모음.

JavaScript의 거의 모든 객체는 Object의 인스턴스

```javascript
const obj1 = {}; //object literal syntax
const obj2 = new Object(); //object constructor syntax

function print(person){
    console.log(person.name);
    console.log(person.age);
}

// object = {key: value}
const baby = {name: 'hong', age: 4};
print(baby);
baby.hasJob = true; //속성을 나중에 추가할 수 있음
console.log(baby.hasJob);

delete baby.hasJob; // 속성을 나중에 삭제할 수 있음
console.log(baby.hasJob); //delete했으므로 undefined출력

// key should be always String
console.log(baby.name);
console.log(baby['name']);
baby['hasJob'] = true;
console.log(baby['hasJob']);

function  printValue(obj,key){
    console.log(obj.key); //인식X
    console.log('=============');
    console.log(obj[key]); //인식O, 변수에 담긴거 확인할때는 이렇게 사용해야함.
}

printValue(baby, 'name');
printValue(baby, 'age');


const person1 = {name: 'bob', age: 2};
const person2 = {name: 'steve', age: 3};
const person3 = {name: 'dave', age: 4};
const person4 = new Person('baby',30); //Property value shorthand(단축속성)
console.log(person4);

//Constructor Fuction
function Person(name,age){
    this.name = name;
    this.age = age;
}

// in: 속성이 그 개체안에 있는지 확인(key in obj)
console.log('name' in baby);
console.log('age' in baby);
console.log('random' in baby);
console.log(baby.random);

for(let key in baby){//객체에 있는지 in
    console.log(key);
}

const array=[1,2,4,5];
for(let value of array){//배열의 값 of
    console.log(value);
}

// 복사 
const user = {name: 'bob', age: 20};
const user2 = user;//값복사가 아니라 참조값 할당되므로 동일한 곳 가르켜
console.log(user);
user2.name = 'coder';
console.log(user);

const user3 = {};
for(let key in user){
    user3[key] = user[key]; //같은곳 아니고 따로따로 객체형태 갖게됌(값만 복사)
}
console.log(user3);

user.name = 'bob';
console.log(user3);
console.log(user);

console.clear();

const user4 = Object.assign({},user);
console.log(user4);
user.name = 'dev'
console.log(user4);
console.log(user);

// assign 오버로딩?.
const fruit1 = {color: 'red'};
const fruit2 = {color: 'blue', size: 'big'};
const mixed = Object.assign({},fruit1,fruit2);
console.log(mixed);//같은 속성인 color 덮어씌워짐
// 깊은복사
// 두개합쳐서복사
```

- 객체값 접근/객체의 반복문

```javascript
// 1.객체값 접근
let person = {
            firstName: "John",
            lastName: "Doe",
            age: 50,
            eyeColor: "Blue"
        };

// 2.객체의 반복문
let output = "";
for(let key in person){//+는 연결기호
	output += `❤ ${key}: ${person[key]} <br>`;
}

// 1.객체값 접근
document.getElementById("demo").innerHTML = `${person.firstName} is ${person.age} years old`;
document.getElementById("demo").innerHTML = `${person['firstName']} is ${person['age']} years old`;

// 2.객체의 반복문
document.getElementById("demo").innerHTML = output;
```

- in/with
  - in: 속성이 객체 안에 있는지 확인. 존재하면 true리턴
  - with: 객체의 속성을 출력할 때 여러번 사용되는 객체명을 줄여줌

```javascript
let output='';
let student = {
	이름: '홍길동',
	국어: 92,
	수학: 98,
	영어: 96,
	과학: 98
};

//1.in
output += `이름 in student(${'이름' in student}) \n`;
output += `성별 in student(${'성별' in student})`;
        
//2.with사용x
output += `이름 : ${student.이름} \n`;
output += `국어 : ${student.국어} \n`;
output += `수학 : ${student.수학} \n`;
output += `영어 : ${student.영어} \n`;
output += `과학 : ${student.과학} \n`;
output += `총점 : ${student.국어 + student.수학 + student.영어 + student.과학} \n`;

//3.with사용o
with(student){
	output += `이름 : ${이름} \n`;
	output += `국어 : ${국어} \n`;
	output += `수학 : ${수학} \n`;
	output += `영어 : ${영어} \n`;
	output += `과학 : ${과학} \n`;
	output += `총점 : ${국어 + 수학 + 영어 + 과학} \n`;
}
```

- push함수를 사용해 객체생성
  - 배열안에 객체를 하나씩 만들어 넣음. 서로 다른 형태의 객체를 배열에 담음

```javascript
let students = [];//빈 배열생성
students.push({//배열에 객체 삽입
	이름: '홍길동', 국어: 87,
	수학: 98, 영어: 88, 과학: 95,
	장래희망: '생명공학자'
});

students.push({//배열에 객체 삽입
	이름: '김길순', 국어: 76,
	수학: 96, 영어: 94, 과학: 90,
	장래희망: '프로그래머'
});
        
students.push({//배열에 객체 삽입
	이름: '이길동', 국어: 92,
	수학: 98, 영어: 96, 과학: 98,
	특기: '요리', 취미: '일렉기타'
});

console.log(students);
```

<br><h3>2. 속성과 메소드</h3>

배열 내부에 있는 값을 요소, __객체 내부의 값__을 __*속성*__이라 함

__객체 속성중 기능 처리__를 __*메소드*__라 함

메소드 내에서 자신의 속성을 출력하고 싶을 때는 this 키워드 사용

```javascript
let person = {//literal로 객체생성
	firstName: "John",
	lastName: "Doe",
	id: 5566,
	fullName: function(){
		return this.firstName + " " +this.lastName;
	},
	eat: function(food){
		return `${this.firstName}이 ${food}를 먹습니다.`;
	}
}

document.getElementById("demo").innerHTML = person.fullName();
document.getElementById("demo").innerHTML = person.eat('국수');
```

<br><h3>3. 생성자 함수, 프로토타입</h3>

- 생성자 함수
  - 클래스 없이 new 사용해 객체 생성
  - new 키워드로 객체를 생성할 수 있는 함수(new없이 객체 생성하면 생성자 함수라 할수 없음)
  - this키워드로 객체 속성과 함수에 접근
  - 함수명을 대문자로 지정

- 프로토타입
  - 생성자 함수로 생성된 객체가 공통으로 가지는 공간
  - 프로토타입을 사용치 않고 메소드를 만들 경우 객체가 생성될 때마다 속성과 메소드를 계속 만들어 메모리가 비효율적이게 됌

```javascript
function Person(first,last,age,eye){//생성자함수로 객체생성
	this.firstName = first;
	this.lastName = last;
	this.age = age;
	this.eyeColor = eye;
}

let myFather = new Person("John","Doe",50,"blue");
let myMother = new Person("Sally","Rally",48,"green");

//1.생성자함수 사용
document.getElementById("demo").innerHTML 
= `My father is ${myFather.age}. My mother is ${myMother.age}`;*/

//2.프로토타입 사용 --하나 만들어서 공유./클로저랑 같이보기
Person.prototype.name = function(){
	return `${this.firstName} ${this.lastName}`;
}
document.getElementById("demo").innerHTML 
= `My Father is ${myFather.name()}`;
document.getElementById("demo2").innerHTML 
= `My Mother is ${myMother.name()}`;
```

<br><h3>4. 클래스</h3>

- 연관있는 메소드와 필드를 묶어 놓은 것
- 객체를 만들수 있는 틀(template)
- 데이터가 들어있지 않음. 한번만 선언

```javascript
class Person{//클래스
    constructor(name, age){//생성자
        this.name=name;
        this.age=age;
    }

    speak(){//속성 아니고 메소드
        console.log(`${this.name}: hello~`);
    }
}

const hong = new Person('hong', 20);
console.log(hong.name);
console.log(hong.age);
hong.speak();
```

