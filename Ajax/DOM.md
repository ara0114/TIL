# HTML DOM(Document Object Model)

## DOM์ด๋

**๐ [์ฐธ๊ณ ์ฌ์ดํธ-MDN Web Docs](https://developer.mozilla.org/ko/docs/Web/API/Document_Object_Model/Introduction) **

- ์นํ์ด์ง๋ฅผ ์คํฌ๋ฆฝํธ ๋๋ ํ๋ก๊ทธ๋๋ฐ์ธ์ด๋ค์์ ์ฌ์ฉ๋  ์ ์๊ฒ ์ฐ๊ฒฐ์์ผ์ฃผ๋ ์ญํ  ๋ด๋น
- ์นํ์ด์ง ๊ฐ์ฒด ์งํฅ ํํ.
- ๊ตฌ์กฐํ๋ nodes์ property, method๋ฅผ ๊ฐ๊ณ ์๋ objects๋ก ๋ฌธ์๋ฅผ ํํ
- ๋์ผํ ๋ฌธ์๋ฅผ ํํ/์ ์ฅ/์กฐ์ ํ๋ ๋ฐฉ๋ฒ์ ์ ๊ณต
- ์๋ฐ์คํฌ๋ฆฝํธ์ ๊ฐ์ ์คํฌ๋ฆฝํ ์ธ์ด๋ก DOM์ ์์ ํ  ์ ์์
- ์นํ์ด์ง๋ ์ผ์ข์ ๋ฌธ์. ์ด ๋ฌธ์๋ ์น ๋ธ๋ผ์ฐ์ ๋ฅผ ํตํด ํด์ ๋
- W3C์์ ํ์ค ์ ์
- Ajax๋ฅผ ์ฌ์ฉํ์ฌ ์๋ฒ๋ก๋ถํฐ ์๋ต ๊ฒฐ๊ณผ๋ฅผ ์ ์ก๋ฐ์ ๋ธ๋ผ์ฐ์ ์ HTML์์ ์ถ๋ ฅํ ๋ DOM๋ชจ๋ธ ์ด์ฉ
- ๋์ ์ผ๋ก HTML์์ฑํ ๋ ํ์
- Object๋ค์ Tree์ฒ๋ผ ์์ฑ

![image](https://user-images.githubusercontent.com/103404127/172041965-7a57df9f-eb1a-41e5-9020-a7ba3ffc5459.png)



## DOMํ์ฉ

- ์์ = node = tag = element

[1] Finding HTML Elements

| Method                                | Description               |
| :------------------------------------ | :------------------------ |
| document.getElementById(id)           | id๋ก ์์ ์ฐพ๊ธฐ            |
| document.getElementsByTagName(name)   | ํ๊ทธ name์ผ๋ก ์์ ์ฐพ๊ธฐ   |
| document.getElementsByClassName(name) | ํด๋์ค name์ผ๋ก ์์ ์ฐพ๊ธฐ |

- Element => ํ๋์ ๋ฆฌํด๊ฐ

- Elements => ๋ชจ๋ ํ๊ทธ ๋ค ์ฝ์ด๋ผ => ๋ฆฌํดํ์ ๋ฐฐ์ด

- idํ์์ js, classํ์์ css์์ ์ฃผ๋ก ๊ฒ์

[2] Changing HTML Elements

| Method                                 | Description         |
| -------------------------------------- | ------------------- |
| element.innerHTML = new html content   | ์์์ html ๋ณ๊ฒฝ    |
| element.attribute = new value          | ์์์ ์์ฑ ๊ฐ ๋ณ๊ฒฝ |
| element.setAttribute(attribute, value) | ์์์ ์์ฑ ๊ฐ ๋ณ๊ฒฝ |
| element.style.property = new style     | ์์์ ์คํ์ผ ๋ณ๊ฒฝ  |

[3] Adding and Deleting Elements

| Method                          | Description        |
| ------------------------------- | ------------------ |
| document.createElement(element) | ์์ ์์ฑ          |
| document.removeChild(element)   | ์์ ์ ๊ฑฐ          |
| document.appendChild(element)   | ์์ ์ถ๊ฐ          |
| document.replaceChild(element)  | ์์ ๋ณ๊ฒฝ          |
| document.write(text)            | text๋ฅผ ํ์ด์ง ์ถ๋ ฅ |

[4] Adding Events Handlers

| Method                                                | Description                             |
| ----------------------------------------------------- | --------------------------------------- |
| document.getElementById(id).onclick = function(){...} | ์์ ํด๋ฆญ์ ์คํ๋๋ ์ด๋ฒคํธ ํธ๋ค๋ฌ ์ถ๊ฐ |

---

<br>\> ํ์ผ ์ ํ ํ๊ทธ ์ถ๊ฐํ๊ธฐ

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        let i = 0;
        function add(){
            let parentdiv = document.getElementById('textHolder');
            let divel = document.createElement('div');
            divel.appendChild(document.createTextNode(`ํ์ผ ์ ํ ${++i} `));
            let inputel = document.createElement('input');
            inputel.type = 'file';      
            divel.appendChild(inputel);//divel์ child๋ก inputel์ ์ถ๊ฐํ์ฌ ํ๋๋ก ๋ง๋ค๊ณ 
            parentdiv.appendChild(divel);//parent์ divel์ ๋ฃ์ด์ค๋ค.
        }
        function del(){
            let parentdiv = document.getElementById('textHolder');
            if(i > 0){//divํ๊ทธ๊ฐ ์์๋๋ง ์ญ์ ํ๊ฒ ๋ค.
                parentdiv.removeChild(parentdiv.lastChild);//lastChild๋ ๋ง์ง๋ง ํ๊ทธ
                --i;
            }
        }
    </script>
</head>
<body>
    <button name="btnAdd" onclick="add()">ํ์ผ ์ ํ ์ถ๊ฐ</button>
    <button name="btnAdd" onclick="del()">ํ์ผ ์ ํ ์ ๊ฑฐ</button>
    <br>
    <div id="textHolder">
    </div>
</body>
</html>
```

<br>\> ๋๋กญ๋ค์ด ๋ฆฌ์คํธ ์์์ ์์ดํ์ ์ถ๊ฐ,์ญ์ ,๋ณ๊ฒฝ

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
        // ๋๋ถ๋ฅ
        const addressList = ["์์ธ","์ธ์ฒ","๊ฒฝ๊ธฐ๋","๊ฐ์๋"];
        
        // ์ค๋ถ๋ฅ
        const gugunListSeoul = ["๋ธ์๊ตฌ", "๊ฐ๋จ๊ตฌ", "๊ตฌ๋ก๊ตฌ", "๋งํฌ๊ตฌ"];
        const gugunListIncheon = ["๋จ๋๊ตฌ", "๋ถํ๊ตฌ", "์๊ตฌ", "๊ณ์๊ตฌ"];
        const gugunListKy = ["๋ถ์ฒ์", "์ํฅ์", "์์์", "์์์"];

        window.onload = function(){//ํ์ด์ง๊ฐ ๋ก๋ฉ๋ ๋
            //๋๋ถ๋ฅ์ ๋ด์ฉ
            let sido = document.getElementById('sidoSelect');
            for(let i=0;i<addressList.length;i++){
                let optionel = document.createElement('option');//์ต์ํ๊ทธ์์ฑ
                optionel.value = addressList[i];//์ต์์์์ ์์ฑ์ addressList๋ฅผ ๋ฃ์
                //<option value='์์ธ'></option>
                optionel.appendChild(document.createTextNode(addressList[i]));//์ต์ํ๊ทธ์ ํ์คํธ๊ฐ ๋ฃ์ด์ค
                //<option value='์์ธ'>์์ธ</option>
                sido.appendChild(optionel);
            }
            //์ค๋ถ๋ฅ & ๋ฒํผ ์จ๊ฒจ๋๊ธฐ(๋๋ถ๋ฅ ์ ํํ๋ฉด ๋์ฌ ์ ์๋๋ก ์ด๊ธฐํ)
            let gugun = document.getElementById('gugunSelect');
            let btnArea = document.getElementById('btnArea');
            gugun.style.display = 'none';
            btnArea.style.display = 'none';
        }

        function changeSidoSelect(){
            let sido = document.getElementById('sidoSelect');
            let idx = sido.options.selectedIndex;//์ต์์ค ๋ด๊ฐ ์ ํํ ๊ฒ์ ์ธ๋ฑ์ค
            let area = document.getElementById('area');
            area.value = '';

            gugunSelectFill(idx);
        }

        function gugunSelectFill(idx){
            let data = null;//์ค๋ถ๋ฅ ๋ฐฐ์ด ๋ค์ด๊ฐ ์์ ์
            let gugun = document.getElementById('gugunSelect');
            let btnArea = document.getElementById('btnArea');
            
            if(idx == 0){
                gugun.style.display = 'none';
                btnArea.style.display = 'none';
                return ; //์คํ์ข๋ฃ(๋ฐ์๊บผ ๋ค ์คํ x)
            }
            if(idx == 1){data = gugunListSeoul;}
            if(idx == 2){data = gugunListIncheon;}
            if(idx == 3){data = gugunListKy;}
            if(idx == 4){
                gugun.style.display = 'none';
                btnArea.style.display = 'none';
                alert('ํ์ฌ๋ ์ง์ํ์ง ์์ต๋๋ค.');
                return ;//์คํ์ข๋ฃ(๋ฐ์๊บผ ์คํ x)
            }

            //gugun.innerHTML = '';
            gugun.innerHTML = '<option value="">์ค๋ถ๋ฅ๋ฅผ ์ ํํ์ธ์</option>';

            for(let i=0;i<data.length;i++){
                let optionel = document.createElement('option');
                optionel.value = data[i];
                //<option value='๋จ๋๊ตฌ'></option>
                optionel.appendChild(document.createTextNode(data[i]));
                //<option value='๋จ๋๊ตฌ'>๋จ๋๊ตฌ</option>
                gugun.appendChild(optionel);
            }
            gugun.style.display = '';
            btnArea.style.display = '';//๋ณด์ฌ์ฃผ๋์์(โ none)
        }

        function getArea(){
            let area = document.getElementById('area');
            let sido = document.getElementById('sidoSelect');
            let gugun = document.getElementById('gugunSelect');

            area.value = `${sido.value} ${gugun.value}`;
        }
    </script>
</head>
<body>
    <div id="sido">
        <select id="sidoSelect" onchange="changeSidoSelect()">
            <option value="">๋๋ถ๋ฅ๋ฅผ ์ ํํ์ธ์.</option>
        </select>
        <select id="gugunSelect">
            <option value="">์ค๋ถ๋ฅ๋ฅผ ์ ํํ์ธ์.</option>
        </select>
        <label>
            <button id="btnArea" name="btnArea" onclick="getArea()">์ ํ</button>
            <input type="text" id="area" size="40">
        </label>
    </div>
</body>
</html>
```

---

*etc.*

div ํ๊ทธ์ ๊ฐ์ ๊ฐ์ ธ์ค๋ ๋ฐฉ๋ฒ

- document.all : document ํ๊ทธ ์์ ํ๊ทธ id ๋๋ name ์์ฑ์ ๋ชจ๋ ์ฐพ์(๋นํ์ค)
- innerText : ํ๊ทธ์ Text ๊ฐ์ ์ ๊ทผ(๋นํ์ค)

