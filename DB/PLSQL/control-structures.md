# 제어문
## 조건문

### IF 문

```sql
IF condition THEN
	statements;
ELSIF condition THEN
	statements;
ELSE statements;
END IF;
```

### CASE 문

```sql
CASE expression | condition
	WHEN condition THEN result | statement
	ELSE result | statement
END [CASE];
```


## 반복문

### LOOP

- EXIT문 수행될 때까지 루프 내 구문 반복.
- 반복 횟수 미리 알 수 없고 적어도 1번 수행해야 할 때 사용

```sql
LOOP
	statments;
	EXIT [expression | condition];
END LOOP;
```

### WHILE LOOP

- 조건을 만족할 경우 루프 내 구문 반복
- 반복 횟수 미리 알 수 없고 구문이 실행되지 않아도 될때 사용

```sql
WHILE LOOP expression LOOP
	statements;
END LOOP;
```

### FOR LOOP

- 인덱스 범위에 속하는 경우 루프 내 구문 반복
- 인덱스는 1씩 증가하거나 감소.

```sql
FOR i in [reverse] lower_bound .. upper_bound LOOP
	statements;
END LOOP;
```
