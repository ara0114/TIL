# jQuery

: JavaScript Library

🔗  [참고사이트1](https://api.jquery.com) [참고사이트2](https://jqueryui.com/)

사용:  `<script src="https://code.jquery.com/jquery-3.5.0.js"></script>` 추가



(1) 장점

- 단순한 JavaScript Programming, 간결하게 코딩하고 많은 일을 해줌
- CSS의 selector를 사용하여 습득하기 쉬움.
- 브라우저의 다양성을 처리해줌 => 호환성 처리에 시간 소비x(전에 인기 많았던 대표적 이유)
- 복잡한 JavaScript 구현시 DOM문법을 매우 간결하게 해줌 => 개발 속도 향상
- jQuery의 기능을 확장할수 있는 plugin구조 지원
- Ajax지원



(2) template 설정

- 자주 사용되는 코드를 미리 작성하여 새로운 html 파일 생성 시 추가
- PC가 바뀌면 다시 설정해야함

- VSCode 설정 => User Snippets => html.json 검색 후 작성

```json
{
	// Place your snippets for html here. Each snippet is defined under a snippet name and has a prefix, body and 
	// description. The prefix is what is used to trigger the snippet and the body will be expanded and inserted. Possible variables are:
	// $1, $2 for tab stops, $0 for the final cursor position, and ${1:label}, ${2:another} for placeholders. Placeholders with the 
	// same ids are connected.
	// Example:
	"!!": {
		"prefix": "!!",
		"body": [
			"<!DOCTYPE html>",
			"<html lang='ko'>",
			"<head>",
			"<meta charset='UTF-8'>",
			"<meta name='viewport' content='width=device-width, initial-scale=1.0'>",
			"<title>$1</title>",
			"<style>$2</style>",
			"<script src='https://code.jquery.com/jquery-3.5.0.js'></script>",
			"<script>",
				"$(function () {",
					"$3",
				"});",
			"</script>",
			"</head>",
			"<body>",
				"$4",
			"</body>",
			"</html>",
		],
		"description": "Log output to console"
	}
}
```

작성 후 저장, 사용은 html파일 생성후 `!! 입력하고 tab`을 누름



(3) 자동 실행 함수

: 페이지가 로드되면 자동으로 실행되는 함수

-`$(document).ready(function(){...})`

-`$().ready(function(){...})`

-`$(function(){...})`

모두 같은 의미, 밑으로 갈수록 축약형