# jQuery

: JavaScript Library

๐  [์ฐธ๊ณ ์ฌ์ดํธ1](https://api.jquery.com) [์ฐธ๊ณ ์ฌ์ดํธ2](https://jqueryui.com/)

์ฌ์ฉ:  `<script src="https://code.jquery.com/jquery-3.5.0.js"></script>` ์ถ๊ฐ



(1) ์ฅ์ 

- ๋จ์ํ JavaScript Programming, ๊ฐ๊ฒฐํ๊ฒ ์ฝ๋ฉํ๊ณ  ๋ง์ ์ผ์ ํด์ค
- CSS์ selector๋ฅผ ์ฌ์ฉํ์ฌ ์ต๋ํ๊ธฐ ์ฌ์.
- ๋ธ๋ผ์ฐ์ ์ ๋ค์์ฑ์ ์ฒ๋ฆฌํด์ค => ํธํ์ฑ ์ฒ๋ฆฌ์ ์๊ฐ ์๋นx(์ ์ ์ธ๊ธฐ ๋ง์๋ ๋ํ์  ์ด์ )
- ๋ณต์กํ JavaScript ๊ตฌํ์ DOM๋ฌธ๋ฒ์ ๋งค์ฐ ๊ฐ๊ฒฐํ๊ฒ ํด์ค => ๊ฐ๋ฐ ์๋ ํฅ์
- jQuery์ ๊ธฐ๋ฅ์ ํ์ฅํ ์ ์๋ plugin๊ตฌ์กฐ ์ง์
- Ajax์ง์



(2) template ์ค์ 

- ์์ฃผ ์ฌ์ฉ๋๋ ์ฝ๋๋ฅผ ๋ฏธ๋ฆฌ ์์ฑํ์ฌ ์๋ก์ด html ํ์ผ ์์ฑ ์ ์ถ๊ฐ
- PC๊ฐ ๋ฐ๋๋ฉด ๋ค์ ์ค์ ํด์ผํจ

- VSCode ์ค์  => User Snippets => html.json ๊ฒ์ ํ ์์ฑ

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

์์ฑ ํ ์ ์ฅ, ์ฌ์ฉ์ htmlํ์ผ ์์ฑํ `!! ์๋ ฅํ๊ณ  tab`์ ๋๋ฆ



(3) ์๋ ์คํ ํจ์

: ํ์ด์ง๊ฐ ๋ก๋๋๋ฉด ์๋์ผ๋ก ์คํ๋๋ ํจ์

-`$(document).ready(function(){...})`

-`$().ready(function(){...})`

-`$(function(){...})`

๋ชจ๋ ๊ฐ์ ์๋ฏธ, ๋ฐ์ผ๋ก ๊ฐ์๋ก ์ถ์ฝํ