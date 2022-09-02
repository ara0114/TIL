## python functions

defining&calling 

```python
#Defining Functions
def my_function():
    #Do this
    #Then do this
    #Finally do this

#Calling Functions
my_function()
```

\>hurdle1(for)

```python
#Reeborg has entered a hurdles race. Make him run the course, following the path shown.
#What you need to know
#	The functions move() and turn_left().
#You may have noticed that your solution has some repeated patterns. If you know how to define functions, define a function named jump() and use it to simplify your program.

def turn_right():
    turn_left()
    turn_left()
    turn_left()

def jump():
    move()
    turn_left()
    move()
    turn_right()
    move()
    turn_right()
    move()
    turn_left()

for step in range(6):
    jump()
```



## Loops - While Loop

```python
while something_is_true:
    #Do this
    #Then do this
    #Do something repetedly
```

\>hurdle1(while)

```python
def turn_right():
    turn_left()
    turn_left()
    turn_left()

def jump():
    move()
    turn_left()
    move()
    turn_right()
    move()
    turn_right()
    move()
    turn_left()
    
number_of_hurdles = 6
while number_of_hurdles > 0:
    jump()
    number_of_hurdles -= 1
    print(number_of_hurdles)
```

\>hurdle2(while)

```python
#Reeborg has entered a hurdle race, but he does not know in advance how long the race is. Make him run the course, following a path similar to the one shown, but stopping at the only flag that will be shown after the race has started.

#What you need to know
#	The functions move() and turn_left().
#	The condition at_goal() and its negation.
#	How to use a while loop.

#Your program should also be valid for world Hurdles 1.

def turn_right():
    turn_left()
    turn_left()
    turn_left()

def jump():
    move()
    turn_left()
    move()
    turn_right()
    move()
    turn_right()
    move()
    turn_left()
    
#while at_goal() != True:
#    jump()
while not at_goal():
    jump()
```

## For vs While

for: 어떤것을 반복하고 각각에 대해 어떤것을 수행해야 할때 / 전체순서에서 몇번째에 해당하는지 어떤아이템을 반복할지/ 상한선이 정해져있음

while: 그저 특정 작업을 설정한 조건에 도달할때까지 반복수행하고자 할때 / 조건이 거짓이 되지않는다면 무한반복(Infinite Loop) 되므로 주의

<br>

\>hurdle3

```python
#Reeborg has entered a hurdle race. Make him run the course, following the path shown.

#The position and number of hurdles changes each time this world is reloaded.

#What you need to know
#	The functions move() and turn_left().
#	The conditions front_is_clear() or wall_in_front(), at_goal(), and their negation.
#	How to use a while loop and an if statement.

#Your program should also be valid for worlds Hurdles 1 and Hurdles 2.

def turn_right():
    turn_left()
    turn_left()
    turn_left()

def jump():
    turn_left()
    move()
    turn_right()
    move()
    turn_right()
    move()
    turn_left()

while not at_goal():
    if wall_in_front():
        jump()
    else:
        move()
```

\>hurdle4

```python
#Reeborg has entered a hurdle race. Make him run the course, following the path shown.

#The position, the height and the number of hurdles changes each time this world is reloaded.

#What you need to know
#You should be able to write programs that are valid for worlds Around 4 and Hurdles 3, and ot combine them for this last hurdles race.
#Your program should also be valid for worlds Hurdles 1, Hurdles 2 et Hurdles 3

def turn_right():
    turn_left()
    turn_left()
    turn_left()

def jump():
    turn_left()
    while wall_on_right():
        move()     

    turn_right()
    move()
    turn_right()

    while front_is_clear():
        move()
        
    turn_left()
    
while not at_goal():
    if wall_in_front():
        jump()
    else:
        move()
```





### day6 Project

\> Lost in a maze

```python
#Reeborg was exploring a dark maze and the battery in its flashlight ran out.

#Write a program using an if/elif/else statement so Reeborg can find the exit. The secret is to have Reeborg follow along the right edge of the maze, turning right if it can, going straight ahead if it can’t turn right, or turning left as a last resort.

#What you need to know
#	The functions move() and turn_left().
#	Either the test front_is_clear() or wall_in_front(), right_is_clear() or wall_on_right(), and at_goal().
#	How to use a while loop and if/elif/else statements.
#	It might be useful to know how to use the negation of a test (not in Python).

def turn_right():
    turn_left()
    turn_left()
    turn_left()

while front_is_clear():
    move()
turn_left()

while not at_goal():
    if right_is_clear():
        turn_right()
        move()
    elif front_is_clear():
        move()
    else:
        turn_left()
```

---

*cf.* Indentation[들여쓰기]: Space*4 = Tab
