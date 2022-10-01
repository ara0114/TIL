# Session방식 로그인 기능 구현하기

1. 라이브러리 3개 설치

- npm install passport passport-local express-session

2. 라이브러리 첨부

```javascript
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const session = require('express-session');

app.use(session({secret : '비밀코드', resave : true, saveUninitialized: false}));
app.use(passport.initialize());
app.use(passport.session());
```

app.use(미들웨어)

미들웨어: 요청-응답 중간에 뭔가 실행되는 코드



done(서버에러, 성공시 사용자db데이터, 에러메세지)



```javascript
//미들웨어 쓰는법(로그인했니)
app.get('/mypage', 로그인했니, function(요청,응답){

});

//미들웨어 만드는법
function 로그인했니(요청,응답, next){//미들웨어 만드는법
    if(요청.user){
        next()
    }else{
        응답.send('로그인안하셨는데요?')
    }
}
```

serializeUser(): 유저의아이디로 세션데이터를 만들고 쿠키로 만들어 보냄

deserializeUser(): 로그인한 유저의 세션아이디를 바탕으로 개인정보를 db에서 찾는역할

```javascript
//세션만들기
passport.serializeUser(function(user, done){//id이용해 세션을 저장시키는 코드(로그인 성공시)
    done(null, user.id)//세션아이디를 쿠키로보냄
});
//로그인한 유저 개인정보를 DB에서 찾기
passport.deserializeUser(function(아이디, done){//이 세션데이터를 가진 사람을 db에서 해석해줘(찾아줘라) (마이페이지 접속시)
    //디비에서 user.id로 유저를 찾은뒤 유저정보를
    done(null,{요기에넣음})
});
```

