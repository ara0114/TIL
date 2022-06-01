# 배열, 배열API

## 1. 배열

비슷한 종류의 데이터를 한곳에 담아 저장하는 자료구조중 하나로 인덱스가 지정된 영역이 이어져 있는 것

<br>

[1] Declaration & Index Position

```javascript
//배열의 생성(선언)
const array = new Array(); //new Array()생성자로 배열 생성

const array2 = new Array(12);
console.log(array2[0]); //undefined -- 한개의 요소만으로 배열 생성x

const arr1 = new Array(12, 20);
const arr1 = [12, 20]; // 이렇게 []사용해서 배열 생성 권장
console.log(arr1[0]);
console.log(arr1[1]);

//인덱스
const fruits = ["사과", "바나나"];
console.log(fruits);
console.log(fruits.length); //2
console.log(fruits[0]); //사과
console.log(fruits[1]); //바나나
console.log(fruits[2]); //undefined
console.log(fruits[fruits.length - 1]); //바나나
```

[2] Looping over an array

```javascript
//for
for (let i = 0; i < fruits.length; i++) {
  console.log(fruits[i]);
}
//for of
for (let fruit of fruits) {
  //객체는 in 배열은 of
  console.log(fruit);
}
//forEach
fruits.forEach((fruit) => {
  console.log(fruit);
});
```

[3] Addition, Deletion, Copy

```javascript
//PUSH(맨뒤추가) POP(뒤에서꺼내기) UNSHIFT(맨앞추가) SHIFT(앞에서꺼내기)
//shift, unshift가 pop,push보다 느림

//push: add an item to the end
//pop: remove an item from the end
fruits.push("딸기", "복숭아");
const poped = fruits.pop();
console.log(poped);
fruits.pop();

//unshift: add an item to the begining
//shift: remove an item from the begining
fruits.unshift("딸기", "레몬");
fruits.shift();
fruits.shift();
fruits.push("딸기", "복숭아", "레몬");
console.log(fruits);

//fruits.splice(1,1);
//splice(삭제 시작 할 인덱스, 삭제갯수(지정하지않으면 모두), 인덱스 앞으로 추가할 데이터)
fruits.splice(1, 0, "배", "수박"); //1 인덱스에서 삭제없이 배, 수박 추가하겠다.
console.log(fruits);

//combine(concat)
//concat: 두개 또는 그 이상의 배열을 연결해 새로운 배열을 만듦(기존 배열은 유지)
const fruits2 = ["메론", "배"];
const newFruits = fruits.concat(fruits2);
console.log(newFruits);
```

[4] Searching

```javascript
//indexOf: find the index -- 데이터의 인덱스(앞에서부터 셈)
console.log(fruits);
console.log(fruits.indexOf("사과")); //사과의 인덱스
console.log(fruits.indexOf("수박")); //수박의 인덱스
console.log(fruits.indexOf("코코넛")); //찾는 데이터 없으니까 -1반환

//includes -- 있나없나(true/false)
console.log(fruits.includes("수박"));
console.log(fruits.includes("코코넛"));

//lastIndexOf -- 데이터의 인덱스(뒤에서부터 셈)
fruits.push("사과");
console.log(fruits);
console.log(fruits.indexOf("사과"));
console.log(fruits.lastIndexOf("사과"));
console.log(fruits.lastIndexOf("코코넛"));
```

<br>

\> array01.html - - - 배열(Loop) 예제

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    <h1>JavaScript Arrays</h1>
    <p id="demo"></p>
    <script>
      let fruits, text, fLen, i;
      fruits = ["Banana", "Orange", "Apple", "Mango"];
      fLen = fruits.length;
      text = "<ul>";
      //for
      for (i = 0; i < fLen; i++) {
        text += `<li> ${fruits[i]} </li>`;
      }
      //for of
      for (let fruit of fruits) {
        console.log(fruit);
      }
      //forEach
      fruits.forEach((fruit) => {
        console.log(fruit);
      });
      text += "</ul>";

      document.getElementById("demo").innerHTML = text;
    </script>
  </body>
</html>
```

## 2. 배열API - 배열의 메소드

[1] toString, join

```javascript
//toString: 배열의 값을 ,로 구분된 하나의 문자열로 만들기
let fruits = ["Banana", "Orange", "Apple", "Mango"];
document.getElementById("demo").innerHTML = fruits.toString();

//join: 배열을 하나의 문자열로 만들기, toString과 같은 역할을 하지만 특별한 구분자 사용가능
const fruits = ["apple", "banana", "orange"];
const result = fruits.join("/"); // 구분자 / 로 연결(구분자 없어도 됌-join(): , 가 기본값)
console.log(`value: ${result}, type: ${typeof result}`);
```

[2] split

```javascript
//split: an array 문자열을 배열로
const fruits2 = "사과, 키위, 바나나, 체리";
const result2 = fruits2.split(","); // ,를 기준으로 나눠서 배열에 저장
const result2 = fruits2.split(",", 2); // 리턴받을 사이즈 2로 지정 spilt(구분자,리턴사이즈)
console.log(result2);
```

[3] reverse

```javascript
//reverse: 배열자체를 거꾸로
const a = [1, 2, 3, 4, 5];
a.reverse();
console.log(a);
```

[4] splice, slice

```javascript
//splice: 배열자체를 분리
const re2 = a.splice(0, 2); //splice(n번째인덱스,갯수) 뽑아 분리
console.log(re2); //5,4
console.log(a); //3,2,1
//slice 원래배열은 냅두고 새로운 배열 생성
const re2 = a.slice(2, 5); //slice(n번째인덱스,n전까지) 뽑아서 새로운 배열 생성, 원래 배열은 유지
console.log(re2); //3,2,1
console.log(a); //5,4,3,2,1
```

[5] find

```javascript
//find: 검색하기-값을 가진 객체리턴(같은 것 있을 경우 첫번째꺼만)
class Student {
  constructor(name, age, enrolled, score) {
    this.name = name;
    this.age = age;
    this.enrolled = enrolled;
    this.score = score;
  }
}
const students = [
  new Student("A", 29, true, 45),
  new Student("B", 28, false, 88),
  new Student("C", 30, true, 90),
  new Student("D", 40, false, 66),
  new Student("E", 18, true, 88),
];

const re3 = students.find((student) => student.score === 88);
console.log(re3); // name이 'B'인 Student 객체리턴
```

[6] filter

```javascript
//filter: 원하는 값 filter(배열로)
const result = students.filter((student) => student.enrolled); //true인거 뽑아오기
console.log(result);
```

[7] map

```javascript
//map: 데이터 가져오거나 변환해서 가져올때(배열로)
const result = students.map((student) => student.score * 2);
console.log(result);
```

[8] some, every

```javascript
//some: 요소 하나라도 조건만족하면 true
const result = students.some((student) => student.score < 50); //true
//every: 요소 모두가 조건만족하면 true
const result2 = students.every((student) => student.score >= 50); //false
const result3 = !students.every((student) => student.score >= 50); //true
```

[9] reduce

```javascript
//reduce((prev,curr)=>처리로직, prev초기값): 처리로직결과값이 prev에 전달  --- 누적
const result = students.reduce((prev, curr) => {
  console.log("-------------");
  console.log(prev);
  console.log(curr);
  return prev + curr.score; //prev에 누적되는 값
}, 0);

console.log(result); //score합계
console.log(result / students.length); //score평균
```

[10] sort

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    <p>The sort() method</p>
    <button onclick="myFunction()">Try it</button>
    <p id="demo"></p>
    <script>
      let fruits = ["Banana", "Orange", "Apple", "Mango"];
      //let fruits = [1, 8, 5, 4];
      document.getElementById("demo").innerHTML = fruits;
      function myFunction() {
        fruits.sort(); //배열자체가 바뀜(기본:오름차순)
        //fruits.sort((a,b)=>a-b);//문자라서 안됌, 숫자형태만 가능
        fruits.reverse(); //오름차순뒤집었으니 내림차순
        document.getElementById("demo").innerHTML = fruits;
      }
    </script>
  </body>
</html>
```

[11] 복합사용 예

```javascript
//map,filter,join
const result = students
  .map((student) => student.score)
  .filter((score) => score >= 50)
  .join(); //student에서 점수(map)가 50이상인것 뽑은(filter) 배열을 문자열로 변환(join)

console.log(result);

//map,sort,join
const result = students
  .map((student) => student.score)
  .sort((a, b) => a - b) //오름차순으로 정렬... cf) b-a로 쓰면 내림차순
  .join();

console.log(result);
```

<br>
