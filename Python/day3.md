## 흐름 제어와 논리 연산자

파이썬은 띄어쓰기와 들여쓰기가 정말 중요

if 안에서 들여쓰기 된 모든 것들이 if 조건 안에서 실행 되는 것

`=` : 변수에 값을 넣어준다

`==` : 왼쪽 오른쪽 값이 같다(equals to)

### if/else

```python
if condition:
    do this
else:
    do this
```

### Nested if/else

```python
if condition:
    if another condition:
        do this
    else:
        do this
else:
    do this
```

### if/elif/else

```python
if condition1:
    do A
elif condition2:
    do B
else:
    do this
    
------------------
3가지중 한가지만 실행
```

### Multiple if

```python
if condition1:
	do A
if condition2:
    do B
if condition2:
    do C
    
---------------------------------------
3가지 조건 모두 확인 후 해당하는 것 모두 실행
```

\> day3-main.py

```python
print("Welcome to the rollercoaster!")
height = int(input("What is your height in cm? "))
bill = 0

if height >= 120:
  print("You can ride the rollercoaster!")
  age = int(input("What is your age? "))
  if age < 12:
    bill = 5
    print("Child tickets are $5.")
  elif age <= 18:
    bill = 7
    print("Youth tickets are $7.")
  elif age >= 45 and age <= 55:
    print("Everything is going to be ok. Have a free ride on us!")
  else:
    bill = 12
    print("Adult tickets are $12.")
  
  wants_photo = input("Do you want a photo taken? Y or N. ")
  if wants_photo == "Y":
    bill += 3
  
  print(f"Your final bill is ${bill}")

else:
  print("Sorry, you have to grow taller before you can ride.")
```

\>3.1 excercise: Odd or Even

```python
#Write a program that works out whether if a given number is an odd or even number.

number = int(input("Which number do you want to check? "))

if number % 2 == 0:
  print("This is a even number.")
else:
  print("This is an odd number.")
```

\>3.2 exercise: BMI 2.0

```python
#Write a program that interprets the Body Mass Index (BMI) based on a user's weight and height.

#It should tell them the interpretation of their BMI based on the BMI value.

#BMI = weight / height*height

#Under 18.5 they are underweight
#Over 18.5 but below 25 they have a normal weight
#Over 25 but below 30 they are overweight
#Over 30 but below 35 they are obese
#Above 35 they are clinically obese.

height = float(input("enter your height in m: "))
weight = float(input("enter your weight in kg: "))

bmi = round(weight / (height ** 2))

if bmi < 18.5:
  print(f"Your bmi is {bmi}, you are underweight.")
elif bmi < 25:
  print(f"Your bmi is {bmi}, you have a normal weight")
elif bmi < 30:
  print(f"Your bmi is {bmi}, you are overweight")
elif bmi < 35:
  print(f"Your bmi is {bmi}, you are obese")
else:
  print(f"Your bmi is {bmi}, you are clinically obese")
```

\>3.3 exercise: Leap Year

```python
# Write a program that works out whether if a given year is a leap year. A normal year has 365 days, leap years have 366, with an extra day in February.
# This is how you work out whether if a particular year is a leap year.
# > on every year that is evenly divisible by 4 except every year that is evenly divisible by 100 unless the year is also evenly divisible by 400

# version1
year = int(input("Which year do you want to check? "))
if year%4 == 0 or (year%100 == 0 and year%400 == 0) :
  print("Leap Year")
else:
  print("Not leap year.")
----------------------------------------------------------
# version2
year = int(input("Which year do you want to check? "))
if year%4 == 0:
    if year%100 == 0:
        if year%400 == 0:
            print("Leap Year")
        else:
            print("Not leap year")
    else:
        print("Leap Year")
else:
    print("Not leap year")
```

#### 참고

- Python에서는 &&, || 대신 and, or 사용

\>3.4 exercise: Pizza Order

```python
# Congratulations, you've got a job at Python Pizza. Your first job is to build an automatic pizza order program.Based on a user's order, work out their final bill.
# Small: $15, $Medium: 20, $Large: 25
# Small+pepperoni: +$2, Medium/Large+pepperoni: +$3
# Extra cheese: +$1

print("Welcome to Python Pizza Deliveries!")
size = input("What size pizza do you want? S, M, or L ")
add_pepperoni = input("Do you want pepperoni? Y or N ")
extra_cheese = input("Do you want extra cheese? Y or N ")

bill = 0

if size == "S":
  bill += 15
elif size == "M":
  bill += 20
elif size == "L":
  bill += 25

if add_pepperoni == "Y":
  if size == "S":
    bill += 2
  elif size == "M" or size == "L":
    bill += 3

if extra_cheese == "Y":
  bill += 1

print(f"Your final bill is: ${bill}")
```

### 논리 연산자

and, or, not

not: 조건과 결과를 반대로, 조건이 참이면 결과는 거짓

\>3.5 exercise: Love Calculator Exercise

```python
#You are going to write a program that tests the compatibility between two people. To work out the love score between two people:
#Take both people's names and check for the number of times the letters in the word TRUE occurs. Then check for the number of times the letters in the word LOVE occurs. Then combine these numbers to make a 2 digit number.
#For Love Scores less than 10 or greater than 90, the message should be:
"Your score is x, you go together like coke and mentos."
#For Love Scores between 40 and 50, the message should be:
"Your score is y, you are alright together."
#Otherwise, the message will just be their score. e.g.:
"Your score is z."

print("Welcome to the Love Calculator!")
name1 = input("What is your name? \n")
name2 = input("What is their name? \n")

combine_name = name1 + name2
lower_name = combine_name.lower()

t = lower_name.count("t")
r = lower_name.count("r")
u = lower_name.count("u")
e = lower_name.count("e")

true = t + r + u + e

l = lower_name.count("l")
o = lower_name.count("o")
v = lower_name.count("v")
e = lower_name.count("e")

love = l + o + v + e

score = true * 10 + love

if (score < 10) or (score > 90):
    print(f"Your Score is {score}, you go together like coke and mentos.")
elif (score >= 40) and (score <= 50):
    print(f"Your Score is {score}, you are alright together.")
else:
    print(f"Your Score is {score}")
```

### day3 Project

```python
print('''
*******************************************************************************
          |                   |                  |                     |
 _________|________________.=""_;=.______________|_____________________|_______
|                   |  ,-"_,=""     `"=.|                  |
|___________________|__"=._o`"-._        `"=.______________|___________________
          |                `"=._o`"=._      _`"=._                     |
 _________|_____________________:=._o "=._."_.-="'"=.__________________|_______
|                   |    __.--" , ; `"=._o." ,-"""-._ ".   |
|___________________|_._"  ,. .` ` `` ,  `"-._"-._   ". '__|___________________
          |           |o`"=._` , "` `; .". ,  "-._"-._; ;              |
 _________|___________| ;`-.o`"=._; ." ` '`."\` . "-._ /_______________|_______
|                   | |o;    `"-.o`"=._``  '` " ,__.--o;   |
|___________________|_| ;     (#) `-.o `"=.`_.--"_o.-; ;___|___________________
____/______/______/___|o;._    "      `".o|o_.--"    ;o;____/______/______/____
/______/______/______/_"=._o--._        ; | ;        ; ;/______/______/______/_
____/______/______/______/__"=._o--._   ;o|o;     _._;o;____/______/______/____
/______/______/______/______/____"=._o._; | ;_.--"o.--"_/______/______/______/_
____/______/______/______/______/_____"=.o|o_.--""___/______/______/______/____
/______/______/______/______/______/______/______/______/______/______/_____ /
*******************************************************************************
''')
print("Welcome to Treasure Island.")
print("Your mission is to find the treasure.")

#https://www.draw.io/?lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=Treasure%20Island%20Conditional.drawio#Uhttps%3A%2F%2Fdrive.google.com%2Fuc%3Fid%3D1oDe4ehjWZipYRsVfeAx2HyB7LCQ8_Fvi%26export%3Ddownload

next = input('You\'re at a crossroad. Where do you want to go? Type "left" or "right". ' ).lower()

if next == "left":
    next = input(
        'You\'ve come to a lake. There is an island in the middle of the lake. Type "wait" to wait for a boat. Type "swim" to swim across.'  
    ).lower()
    if next == "wait":
        next = input(
            "You arrive at the island unharmed. There is a house with 3 doors. One red, one yellow and one blue. Which color do you choose? "
        ).lower()
        if next == "red":
            print("It's a room full of fire. Game Over.")
        elif next == "blue":
            print("You enter a room of beasts. Game Over.")
        elif next == "yellow":
            print("You found the treasure! You Win!")
        else:
            print("You chose a door that doesn't exist. Game Over.")
    else:
        print("You get attacked by an angry trout. Game Over.")
else:
    print("You fell into a hole. Game Over.")
```

