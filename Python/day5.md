## Loops - For Loop

```python
#For Loop with Lists

for item in list_of_items:
    #Do something to each item
    
ex1)
fruits = ["Apple","Peach","Pear"]
for fruit in fruits:
  print(fruit)
  print(fruit + " Pie")
  print(fruits) #for문안에서 실행됌(여기선 총3번)

ex2)
fruits = ["Apple","Peach","Pear"]
for fruit in fruits:
  print(fruit)
  print(fruit + " Pie")
print(fruits) #들여쓰기가 없으므로 for문 끝난다음 1번만 출력

# ------------------------------------------------------ #
#For Loop with Range

for number in range(a,b):
    print(number)
    
ex1)
for number in range(1,10): #범위 1과 10 사이의 수.(10은 포함x), 기본적으로 1씩 증가시키면서 수행
    print(number) # 1, 2, 3, 4, ..., 9
    
ex2)
for number in range(1,10,3): #범위 1과 10 사이의 수.(10은 포함x), 3씩 증가시키면서 수행
    print(number) # 1, 4, 7

ex3) 1부터 100까지의 수 더하기
total = 0
for number in range(1,101):
    total += number
```



\>5.1 excercise: Average Height

```python
#You are going to write a program that calculates the average student height from a List of heights.
#e.g. student_heights = [180, 124, 165, 173, 189, 169, 146]

#The average height can be calculated by adding all the heights together and dividing by the total number of heights.
#e.g.
#180 + 124 + 165 + 173 + 189 + 169 + 146 = 1146

#There are a total of 7 heights in student_heights
#1146 ÷ 7 = 163.71428571428572

#Average height rounded to the nearest whole number = 164

#Important You should not use the sum() or len() functions in your answer. You should try to replicate their functionality using what you have learnt about for loops.

#Hint 1.Remember to use the round() function to round the average height before you print it.


student_heights = input("Input a list of student heights ").split()
for n in range(0, len(student_heights)):
  student_heights[n] = int(student_heights[n])

# sum()을 for문으로
total_height = 0
for height in student_heights:
  total_height += height

# len()을 for문으로
number_of_students = 0
for student in student_heights:
  number_of_students += 1

average_height = round(total_height / number_of_students)
print(average_height)

#---------------------------------------------------------
# sum(), len() 사용한다면
total_height = sum(student_heights)
number_of_students = len(student_heights)
average_height = round(total_height / number_of_students)
print(average_height)
```



\>5.2 excercise:  Highest Score

```python
#You are going to write a program that calculates the highest score from a List of scores.
#e.g. student_scores = [78, 65, 89, 86, 55, 91, 64, 89]

#Important you are not allowed to use the max or min functions. The output words must match the example. i.e
#The highest score in the class is: x

#Hint 1.Think about the logic before writing code. How can you compare numbers against each other to see which one is larger?

student_scores = input("Input a list of student scores ").split()
for n in range(0, len(student_scores)):
  student_scores[n] = int(student_scores[n])
print(student_scores)

highest_score = 0 
for score in student_scores:
  if score > highest_score:
    highest_score = score
print(f"The highest score in the class is: {highest_score}")

# ------------------------
# max(), min()의 사용
print(max(student_scores))
print(min(student_scores))
```



\>5.3 excercise:  Adding Evens

```python
#You are going to write a program that calculates the sum of all the even numbers from 1 to 100. Thus, the first even number would be 2 and the last one is 100:
#i.e. 2 + 4 + 6 + 8 +10 ... + 98 + 100

#Important, there should only be 1 print statement in your console output. It should just print the final total and not every step of the calculation.

#Hint 1.There are quite a few ways of solving this problem, but you will need to use the range() function in any of the solutions.

total = 0
for number in range(2,101,2):
  total += number
print(total)

# --------------
# 다른방법사용하기
total2 = 0 
for number in range(1, 101):
  if number % 2 == 0:
    total2 += number
print(total2)
```



\>5.4 excercise:  Fizz Buzz

```python
#You are going to write a program that automatically prints the solution to the FizzBuzz game.

#Your program should print each number from 1 to 100 in turn.

#When the number is divisible by 3 then instead of printing the number it should print "Fizz".

#`When the number is divisible by 5, then instead of printing the number it should print "Buzz".`
#  `And if the number is divisible by both 3 and 5 e.g. 15 then instead of the number it should print "FizzBuzz"`

#e.g. it might start off like this:

#`1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz .... etc.

#Hint 1.Remember your answer should start from 1 and go up to and including 100.
#Hint 2.Each number/text should be printed on a separate line.

for number in range(1,101):
  if number % 3 == 0 and number % 5 == 0:
    print("FizzBuzz")
  elif number % 3 == 0:
    print("Fizz")
  elif number % 5 == 0:
    print("Buzz")
  else:
    print(number)
```



### day5 Project

\> PyPassword Generator

```python

```

