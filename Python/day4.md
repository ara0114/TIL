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

#중첩리스트 활용
# dirty_dozen = ["Strawberries", "Spinach", "Kale", "Nectarines", "Apples", "Grapes", "Peaches", "Cherries", "Pears", "Tomatoes", "Celery", "Potatoes"]

fruits = ["Strawberries", "Nectarines", "Apples", "Grapes", "Peaches", "Cherries", "Pears"]

vegetables = ["Spinach", "Kale", "Tomatoes", "Celery", "Potatoes"]

dirty_dozen = [fruits, vegetables]

print(dirty_dozen)
#결과: [['Strawberries', 'Nectarines', 'Apples', 'Grapes', 'Peaches', 'Cherries', 'Pears'], ['Spinach', 'Kale', 'Tomatoes', 'Celery', 'Potatoes']]
```



\>4.2 excercise:  Who's Paying

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



\>4.3 excercise:  Tresure Map

```python
#You are going to write a program which will mark a spot with an X.

#In the starting code, you will find a variable called map.

#This map contains a nested list.
#When map is printed this is what the nested list looks like:
#['⬜️', '⬜️', '⬜️'],['⬜️', '⬜️', '⬜️'],['⬜️', '⬜️', '⬜️']

#In the starting code, we have used new lines (```\n```) to format the three rows into a square, like this:
#['⬜️', '⬜️', '⬜️']
#['⬜️', '⬜️', '⬜️']
#['⬜️', '⬜️', '⬜️']

#This is to try and simulate the coordinates on a real map. 
#https://res.cloudinary.com/dk-find-out/image/upload/q_80,w_1440,f_auto/Co-ordinates_oggjzg.jpg

#Your job is to write a program that allows you to mark a square on the map using a two-digit system. The first digit is the vertical column number and the second digit is the horizontal row number. e.g.:
#https://cdn.fs.teachablecdn.com/2vnboIYTFFruvl9FJ2w5

#First your program must take the user input and convert it to a usable format. 
#Next, you need to use it to update your nested list with an "x". 

#Hint 1. Remember that Lists start at index 0!
#Hint 2. map is just a variable that contains a nested list. It's not related to the map function in Python.

row1 = ["⬜️","⬜️","⬜️"]
row2 = ["⬜️","⬜️","⬜️"]
row3 = ["⬜️","⬜️","⬜️"]
map = [row1, row2, row3]
print(f"{row1}\n{row2}\n{row3}")
position = input("Where do you want to put the treasure? ")


horizonal = int(position[0])
vertical = int(position[1])

# #map[x]:세로위치
# 방법1
# selected_row = map[vertical - 1] #-1을 하지않으면 index error발생
# selected_row[horizonal - 1] = "X"

# 방법2
map[vertical - 1][horizonal - 1] = "X"

print(f"{row1}\n{row2}\n{row3}")
```

### day4 Project

\> Rock Paper Scissors

```python
rock = '''
    _______
---'   ____)
      (_____)
      (_____)
      (____)
---.__(___)
'''

paper = '''
    _______
---'   ____)____
          ______)
          _______)
         _______)
---.__________)
'''

scissors = '''
    _______
---'   ____)____
          ______)
       __________)
      (____)
---.__(___)
'''

#Write your code below this line 👇
import random

chooseImage = [rock, paper, scissors]

myChoose = int(input("What do you choose? Type 0 for Rock, 1 for Paper or 2 for Scissors. "))

if myChoose >= 3 or myChoose < 0 :
  print("You typed an invalid number, you lose")
else :
  print(chooseImage[myChoose])
  
  comChoose = random.randint(0, 2)
  print("Computer chose: ")
  print(chooseImage[comChoose])
  
  if myChoose == 0 and comChoose == 2 :
    print("You win")
  elif myChoose == 2 and comChoose == 0 :
    print("You lose")
  elif myChoose > comChoose:
    print("You win")
  elif myChoose < comChoose:
    print("You lose")
  elif myChoose == comChoose:
    print("Draw")
```

