## 데이터 형식 이해 및 문자열 조작방법

```python
#Data Types

#String
print("Hello"[4])
print("123"+"345")

#Integer
print(123 + 345)

123_456_789 #123456789

#Float
3.14159

#Boolean
True
False

#Type Errors
num_char = len(input("What is your name?"))

new_num_char = str(num_char)
print("Your name has " + new_num_char + " characters.")

#Type Checking
type()

a= str(123)
print(type(a))

#print(70+float("100.5"))
print(str(70)+str(100))

#Type Conversion
str()
int()
float()
bool()

# Maths Operations
3 + 5
7 - 4
3 * 2
6 / 3
2 ** 3  # 2*2*2=8

#우선순위
# PEMDASLR (Parentheses(괄호), Exponents(지수), Multiply(곱셈) & Divide(나눗셈), Add(덧셈) & Subtract(뺄셈), Left to Right)
# ()
# **
# * /
# + -

print(3 * (3 + 3) / 3 - 3)

#Rounding Numbers(올림)
round(4.6666666666)
print(round(2.66666,2))

#Floor divisionQ(버림)
9 // 4

#Shorthand Operators
# a += 2  short for a = a + 2
# -=
# *=
# /=


score = 0
height = 1.8
isWinning = True
#f-Strings
print(f"your score is {score}, your height is {height}, you are winning is {isWinning}")
```

\>2.1 excercise: 데이터형식-두자리 숫자 입력 더하기

```python
two_digit_number = input("Type a two digit number: ")

print(type(two_digit_number)) #타입확인

first_digit = two_digit_number[0]
second_digit = two_digit_number[1]

result = int(first_digit)+int(second_digit)

print(result)
```

\>2.2 exercise: BMI 계산기

```python
height = input("enter your height in m: ")
weight = input("enter your weight in kg: ")

#BMI = weight/height^2

bmi = int(weight) / float(height) ** 2
print(int(bmi))
```

\>2.3 exercise: Life in Weeks Exercise- 삶을 주(week)로 표현하기

```python
#Create a program using maths and f-Strings that tells us how many days, weeks, months we have left if we live until 90 years old.

age = input("What is your current age?")

years_remaining = 90 - int(age)
days_remaining = years_remaining * 365
weeks_remaining = years_remaining * 52
months_remaining = years_remaining * 12

message = f"You have {days_remaining} days, {weeks_remaining} weeks, and {months_remaining} months left."

print(message)
```

---

### day2 project

\> Tip Calculator

```python
#If the bill was $150.00, split between 5 people, with 12% tip.
#Each person should pay (150.00 / 5) * 1.12 = 33.6
#Format the result to 2 decimal places = 33.60

print("Welcome to the tip calculator!")
bill = input("What was the total bill? $")
tip = input("How much tip would you like to give? 10, 12 or 15? ")
people = input("How many people to split the bill? ")

total_bill = float(bill)*(1.00+int(tip)/100)

bill_per_person = float(total_bill) / int(people)

pay = round(bill_per_person,2)

pay = "{:.2f}".format(bill_per_person)

print(f"Each person should pay: ${pay}")
```

