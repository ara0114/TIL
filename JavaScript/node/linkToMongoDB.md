RDBMS => SQL 언어 사용해야함

- MySQL
- MariaDB
- Oracle
- MS SQL Server

NoSQL =>SQL언어없이. Object자료형으로 입출력 가능, 데이터 입출력에만 신경쓸 수 있음

- Dynamo
- Oracle NoSQL
- MongoDB
- Redis
- Cassandra

## MongoDB연결하기

```javascript
const MongoClient = require('mongodb').MongoClient;

var db;
MongoClient.connect('mongodb+srv://DB연결아이디:DB연결패스워드@cluster0.ztmdtzz.mongodb.net/?retryWrites=true&w=majority', function(에러,client){
    
    //연결되면 할일
    if(에러) return console.log(에러)

    db = client.db('todoapp');  //todoapp이라는 database(폴더)에 연결해주세요
    
    //post라는 collection에 저장해달라
    db.collection('post').insertOne('저장할데이터',function(에러, 결과){
        console.log('저장완료');
    });
    app.listen(8080, function(){
        console.log('listening on 8080') 
    });
})
```

저장할 데이터 형식은 {이름: 'John', 나이:20} 이런식으로 `Object자료형`

.insertOne

조회

.find 

.findOne

수정

.updateOne

.updateMany //한번에 많이 수정하면

삭제

.deleteOne



operator

$set(변경)

$inc(증가)

$min(기존값보다 작을때만 변경)

$rename(key값 이름변경)

---

delete요청하는법

1. method-override라는 라이브러리이용(node에서쓸수있는) => form에서 delete요청가능해짐
2. ajax이용

AJAX: *새로고침없이* 서버에 요청하는걸 도와주는 JS문법

```javascript
        $.ajax({
          method : 'DELETE',
          url : '요청할경로',
          data : '요청과 함께 보낼데이터'
        });
```



e.target : 내가누른요소

dataset.id : data-id 가져와라



this : 지금 이벤트 동작하는곳



폼에서 put, delete하도록 도와줌: npm install method-override

---

하나 찾을때 collection().findOne()

많이 찾을때 collection().find().toArray()



query String(서버로 몰래 전달되는 정보들)



검색요청시 

정확히 일치하는것만 찾아주는 문제점 해결하는법

- 정규식사용

/문자열/

- find()사용해서 쓰는건 오래걸려=> 인덱싱 해두면 빨라진다
- binary seach적용하기(미리 숫자순으로 정렬되어야함)



몽고디비 특징: _id순으로 정렬 미리 되어있음.

제목 미리 정렬해두면 db는 알아서 binary search해줌

index : 기존 collection을 정렬해놓은 사본



index생성방법

- 몽고디비 원하는 컬렉션에서 create index
- 문자자료는 type을 'text', 숫자자료는 type을 1 or -1

text index만들어두면

- 빠른검색
- `or` 검색가능
- `-`로 제외검색가능
- `" "`로 정확히 일치하는 것만 검색가능
- but 띄어쓰기 기준으로 단어 저장하기때문에 한글친화적이지않음
  - 해결책
    - text index쓰지말고 검색할 문서의 양 제한두기
    - text index만들때 다르게 만들기 - 띄어쓰기단위로 indexing금지, 글자 두개 단위로 indexting해봐라(nGram)
    - search index사용 => find()가 아닌 aggregate()사용



aggregate()



검색조건 더 주는법

​    { $sort : {_id : 1} } // id기준으로 정렬해서 가져와라

​    { $limit : 5 } //5개만 가져와라

​    { $project : { 제목: 1, \_id : 0, score: { $meta: "searchScore" } } } //_id:0이면 id빼고 가져오란뜻. 제목:1이면 제목은 가져오란뜻.  score 달라고하면줌 (검색어 많이 들어간거 점수)



---

query string 쉽게 만들기

var 자료 = { 이름1 : '값1', 이름2 : '값2' }

$param(자료) //이름1=값1&이름2=값2

또는

$(폼태그name속성).serialize()
