# Pandas

- 엑셀의 파이썬 버전
  - 엑셀은 표 형태로 데이터를 저장 -> 판다스의 `DataFrame`
- import pandas as pd 

## Dataframe

- Series를 여러개 붙여 만듦(세로)

### Series 데이터 생성

```python
import pandas as pd
nums = [i for i in range(1,11)] #[1,2,3,4,5,6,7,8,9,10]
seriesNums = pd.Series(nums)
"""0 1
   1 2
   2 3
   3 4
   4 5
   5 6
   6 7
   7 8
   8 9
   9 10"""
```

- list를 Series로 만들면 pandas의 다양한 기능을 이용할 수 있음
  - series.`mean()` : 평균
  - series.`describe()` : 묘사. 시리즈 정보

### DataFrame 생성

#### 리스트 전달하여 DataFrame생성

```python
nums = [
    [1,2,3],
    [4,5,6],
    [7,8,9]
]
dfNums = pd.DataFrame(nums)
"""  0 1 2
   -------
   0 1 2 3
   1 4 5 6
   2 7 8 9
"""

users = [
    ['kim',180,5],
    ['park',170,5],
    ['lee',130,5]
]
dfUsers = pd.DataFrame(users)
# 컬럼설정
dfUsers.columns = ["name", "height", "age"]
""" name height age
 0  kim  180    5
 1  park 170    5
 2  lee  130    5
"""

# 여러개 Series를 합친것이 DataFrame
type(dfNums) # pandas.core.frame.DataFrame
dfNums[0]
""" 0 1
    1 4
    2 7
    Name: 0, dtype: int64
"""
type(dfNums[0]) # pandas.core.series.Series
```

#### 딕셔너리 전달하여 DataFrame생성

```python
users = {
    "name" : ["kim","park","lee"],
    "height" : [180,170,130],
    "age" : [25,30,5]
} # {'name':['kim','park','lee'], 'height':[180,170,130], 'age':[25,30,5]}
dfUsers = pdDataFrame(users)
""" name height age
 0  kim  180    25
 1  park 170    30
 2  lee  130    5
"""
```

#### ✔리스트 in 딕셔너리 전달하여 DataFrame생성 => 이런 형식의 데이터 포맷으로 올 가능성 큼

```python
users = [
    {"name":"kim","height":"180","age":"25"},
    {"name":"park","height":"170","age":"30"},
    {"name":"lee","height":"130","age":"5"},
]
dfUsers = pd.DataFrame(users)
```

### DataFrame 조회

- csv파일 읽어오기

  - pd.`read_csv`("파일명.csv", encoding='cp949')

- head, tail 함수 : 데이터 생김새 보고 싶을때 맨위 또는 맨아래 n개만 볼 수 있는 기능

  - `head()`: 맨위부터 읽어옴(기본 5개)
  - `tail()`: 맨아래부터 읽어옴

  ```python
  sample.head()
  sample.tail()
  sample.head(10) # 맨위부터 10개
  ```

- index : 더 빠르게 검색하고, 데이터 정렬할 때 사용

  ```python
  sample = pd.read_csv("파일명.csv", encoding='cp949', index_col = 0) # 맨 첫번째(0번) 컬럼을 인덱스로 지정
  sample.index #RangeIndex(start = 0, stop = 500, step = 1)
  sample = sample.set_index("열이름") # 열을 인덱스로 설정
  ```

#### 컬럼명 으로 조회

- df[컬럼명] : 1개의 컬럼
- df[["컬럼명","컬럼명"]] : 2개이상 컬럼 동시에 조회하고 싶을때 컬럼명 리스트 형태로 

#### loc, iloc 으로 조회

- 원하는 행 또는 열에 인덱싱, 슬라이싱 가능
- loc[행 인덱스] => 행row조회
- loc[행 인덱스, 컬럼명] => 행row, 열column 조회
- iloc[행 인덱스 번호] => 행row조회
- iloc[행 인덱스 번호, 열 인덱스 번호] => 행row, 열column 조회

```python
sample.loc[start:end] #인덱스가 start인 행부터 end인 행까지 가져옴
sample.loc[:,"start":"end"] #인덱스가 start인 열부터 end인 열까지 모든 행(:) 조회
sample.iloc[start:end] #인덱스번호가 start인 행부터 end인 행까지 가져옴
sample.iloc[:, "start":"end"] #인덱스가 start인 열부터 end인 열까지 모든 행(:) 조회
```

#### indexing

- 조건에 따라 원하는 부분만 가져오고 싶은 경우 사용
- df[조건] 또는 df.loc[조건] 문법을 통해 조건에 맞는 데이터만 추출
- and는 `&`, or는 `|` 로 사용

### DataFrame 수정

- 새로운 열 추가
  - df[추가할 열 이름] = 열의 값
- 데이터 수정
  - 조회문법에 대입연산자(`=`) 넣기

### DataFrame 삭제

- 컬럼삭제
  - df.drop([삭제할 컬럼명], axis =1)
    - axis = 1은 열축. axis='column' 열축을 따라 좌에서 우로 탐색
- 로우삭제
  - df.drop(삭제할로우, axis=0)
    - axis = 0은 행축. axis='row' 행축을 따라 위에서 아래로 탐색

- 데이터보호를 위해 drop해도 원본데이터를 삭제하진 않음.

### 자주 사용하는 함수

#### 연산함수

- sum() : 합계. 기본옵션 axis = 0( 행 축 기준으로 열을 쭉 더함), axis=1이면 열 축 기준으로 행을 더함 
- divide() : 나누기. divide(나눌 수), divide(나눌 수, axis옵션)
- cumprod() : 누적곱
- cummax() : 누적최댓값

#### apply

- DataFrame에 파이썬함수를 연결
- apply(연결시킬 파이썬 함수, axis = 0 or 1)

#### concat

- 서로 다른 두개의 데이터 프레임을 합침
- pd.concat([df, df2, ... 합치고 싶은 데이터프레임], axis옵션) : axis=0이 기본옵션.(아래에 붙임), 1이면 옆에 붙이기

### 중복 데이터 처리

- duplicated

  - 중복 데이터 찾기

  - True일 경우 중복.

  - keep속성을 이용해 어떤 값 중복으로 인식할 것인지 설정. 기본값은 first
    - df.duplicated(keep="last") , df.duplicated()

  - subset속성을 사용해 특정 컬럼에 대한 중복만 처리 가능
    - df.duplicated(subset = [컬럼명])

- drop_duplicates

  - 중복값 삭제
  - subset, keep 사용가능
    - df.drop_duplicates(), df.drop_duplicates(subset=[컬럼명], keep="first")

### 결측 데이터 처리

- isnull
  - 결측치 찾기
  - df.isnull() : 결측치일 경우 True
  - df.isnull().sum() : 각 컬럼별로 몇개의 결측치가 있는지
- fillna
  - 결측치 채우기
  - df.fillna(특정값): 결측치일경우 특정 값으로 채우기
  - df.fillna(method="ffill"): 결측치 일 경우 앞의 값으로 대체(ffill = forward fill)
  - df.fillna(method="bfill"): 결측치 일 경우 뒤의 값으로 대체(dfill = backward fill)
- dropna
  - 결측치 삭제
  - df.dropna(): 결측치 있는 행 삭제

### 시각화

- matplotlib 사용하여 기본 그래프 만들수 있음

  - 라인플롯(line plot)
  - 스캐터플롯(scatter plot)
  - 컨투어플롯(contour plot)
  - 서피스플롯(surface plot)
  - 바 차트(bar chart)
  - 히스토그램(histogram)
  - 박스 플롯(box plot)

- 라인 플롯 예시

  ```python
  import matplotlib.pyplot as plt
  sample = pd.read_csv("파일명")
  
  plt.rc('font', family="폰트명") # 한글 사용하기 위한 폰트설정
  sample[컬럼명].plot(label="라벨명", xlabel="x축 라벨명", ylabel="y축 라벨명") # .plot(): 그래프생성
  plt.legend() # 범례 추가
  plt.figure(figsize=(가로길이,세로길이)) # 그래프 사이즈 조절
  
  #여러개 그래프 한번에
  #1줄에 2개 그래프생성
  figure, (ax1, ax2) = plt.subplots(nrows=행 갯수, ncols=열 갯수, figsize=(가로길이, 세로길이)) 
  sample[컬럼명].plot(ax=ax1, label="라벨명", xlabel="x축라벨명")
  sample[컬럼명].plot(ax=ax2, label="라벨명", xlabel="x축라벨명")
  ```

  

