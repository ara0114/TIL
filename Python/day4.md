## Randomisation

🔗[파이썬 랜덤모듈](https://www.askpython.com/python-modules/python-random-module-generate-random-numbers-sequences) : 손쉽게 난수를 생성할 수 있도록 개발한 모듈

랜덤모듈 사용하기-> import random 입력

모듈(Module)이란?

- 복잡한 것을 개발하기 위해 코드가 너무 길어지는 경우, 코드가 너무 방대해 어떤것이 진행되고 있는지 이해하기 힘들어질 수 있음. 이럴경우 코드를 개별 모듈로 나누는 작업을 하게되며 각 모듈은 프로그램에서 서로 다른 기능을 담당하게 됌.
- 새로운 모듈을 만들고 사용할 수 있나? -> O, import 파일명

\>day4. main.py

```python
import random

# 정수 난수 생성하기
random_integer = random.randint(1,10) #1이상 10이하의 정수 난수
print(random_integer) 

#부동 소수점 난수 생성하기(0.00000000 ~ 0.9999999...)
random_float = random.random() #0과 1사이(1포함x)에 존재하는 숫자(부동소수점 난수)
print(random_float)
#How to create to a random decimal number between 0 and 5?
#0.00000... ~ 4.9999999...
randomFloat = random.random() * 5
print(randomFloat)

love_score = random.randint(1,100)
print(f"Your love score is {love_score}")
```



\>4.1 excercise: Heads or Tails Exercise

```python
#You are going to write a virtual coin toss program. It will randomly tell the user "Heads" or "Tails". 🎲

#Important, the first letter should be capitalised and spelt exactly like in the example e.g. Heads, not heads.

#There are many ways of doing this. But to practice what we learnt in the last lesson, you should generate a random number, either 0 or 1. Then use that number to print out Heads or Tails.

#1 means Heads
#0 means Tails

import random

random_side = random.randint(0,1)
if random_side == 1 :
  print("Heads")
else:
  print("Tails")
```



## List

🔗[파이썬 리스트](https://docs.python.org/3/tutorial/datastructures.html) 

리스트(List)란?

- Data Structure
- 데이터를 체계화하고 저장하는 방식
- fruits = [item1, item2, ...] 처럼 대괄호 한쌍에 많은 항목 저장, 모든 데이터 형식을 저장할 수 있음. 혼합된 데이터 형식 가능, 데이터 형식 상관 없음. **대괄호를 열어 리스트를 시작하고 대괄호를 닫아 리스트를 종료함** , 대괄호 안의 항목은 쉼표로 구분

- **순서 O**

\>day4. list practice

```python
states_of_america = ["Delaware", "Pennsylvania", "New Jersey", "Georgia", "Connecticut", "Massachusetts", "Maryland", "South Carolina", "New Hampshire", "Virginia", "New York", "North Carolina", "Rhode Island", "Vermont", "Kentucky", "Tennessee", "Ohio", "Louisiana", "Indiana", "Mississippi", "Illinois", "Alabama", "Maine", "Missouri", "Arkansas", "Michigan", "Florida", "Texas", "Iowa", "Wisconsin", "California", "Minnesota", "Oregon", "Kansas", "West Virginia", "Nevada", "Nebraska", "Colorado", "North Dakota", "South Dakota", "Montana", "Washington", "Idaho", "Wyoming", "Utah", "Oklahoma", "New Mexico", "Arizona", "Alaska", "Hawaii"]

print(states_of_america)
print(states_of_america[1]) #0부터 시작하므로 "Pennsylvania"출력
print(states_of_america[-1]) #음수인덱스: 마지막에서부터 -1(마지막은 0이없음) ->"Hawaii" 출력

#리스트 항목 변경하기
states_of_america[1] = "Pencilvania"

#리스트 항목 추가하기 - 마지막에 1개
states_of_america.append("Angelaland")
#리스트 항목 추가하기 - 마지막에 여러개(리스트로 추가)
states_of_america.extend(["Angelaland","Jack Bauer Land"])
```

\>4.2 excercise:  Who's Paying Start Here

🔗[Convert String to List in Python](https://www.askpython.com/python/string/convert-string-to-list-in-python) 

```python
#You are going to write a program which will select a random name from a list of names. The person selected will have to pay for everybody's food bill. 

#Important: You are not allowed to use the `choice()` function.

#Splits the string `names_string` into individual names and puts them inside a List called `names`. For this to work, you must enter all the names as name followed by comma then space. e.g. name, name, name

#Hint 1. You might need the help of the `len()` function.
#Hint 2. Remember that Lists start at index 0!

# Split string method
names_string = input("Give me everybody's names, separated by a comma. ")
names = names_string.split(", ")

import random

#Get the total nuber of items in list.
num_items = len(names)

random_choice = random.randint(0,num_items - 1) #리스트 0부터 시작하기때문에 -1해서 순서 난수 구하기
print(f"{names[random_choice]} is going to buy the meal today!")

#---------------------------------------------------------------------#
#choice()를 사용할 경우
person_who_will_pay = random.choice(names)
print(person_who_will_pay + " is going to buy the meal today!")
```

