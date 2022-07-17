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

\>3.1 excercise: Odd or Even

```python
#Write a program that works out whether if a given number is an odd or even number.

number = int(input("Which number do you want to check? "))

if number % 2 == 0:
  print("This is a even number.")
else:
  print("This is an odd number.")
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
```

\> day3-main.py

```python
print("Welcome to the rollercoaster!")
height = int(input("What is your height in cm? "))

if height >= 120:
  print("You can ride the rollercoaster!")
  age = int(input("What is your age? "))
  if age < 12:
    print("Please pay $5.")
  elif age <= 18:
    print("Please pay $7.")
  else:
    print("Please pay $12.")
else:
  print("Sorry, you have to grow taller before you can ride.")
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

