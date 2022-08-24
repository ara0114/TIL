## git diff : 깃의 변경사항 보여줌

git diff 옵션사용안하면 스테이징-워킹디렉토리 모든파일 변경사항..난리난다

\>예시

```bash
git diff --git a/rainbow.txt b/rainbow.txt

--- a/rainbow.txt

+++ b/rainbow.txt

@@ -3,4 +3,5 @@ orange 

yellow

green

blue

-purple

+indigo

+violet
```

\>예시 설명

```
-3,4: a파일 3번째라인에서 시작해서 4줄
+3,5: b파일 3번째라인에서 시작해서 5줄
- 는 a에서 온 변경사항
+ 는 b에서 온 변경사항
```



---

등록되지 않은 변경사항 보기

- git diff

  

작업디렉토리 변경사항 보기(변경사항 목록출력)

마지막 커밋이후의 변경사항과 작업디렉토리에 있는 변경사항보기

- git diff HEAD



스테이지에 등록된 변경사항 보기

- git diff --staged

- git diff --cached



diff의 범위 특정파일로 좁히기

- git diff HEAD [filename]
- git diff --staged [filename]



브랜치간 변경사항 비교하기

- git diff branch1..branch2
- git diff branch1 branch2



커밋간 변경사항 비교하기

- git diff commitHash1..commitHash2
- git diff commitHash1 commitHash2

---

### Diff practice

**1970s branch일때**

브랜치변경사항

![image](https://user-images.githubusercontent.com/103404127/186462609-bd5564dc-a57f-444c-8db4-0dca707372f7.png)

브랜치변경사항 범위좁혀서

![image](https://user-images.githubusercontent.com/103404127/186462189-b392e1d2-2521-4b1a-87e8-7606fccd8067.png)



**current branch로 전환하고**

HEAD와 HEAD의 이전 커밋인 부모 커밋과 비교하기(새커밋에서 부모커밋 OR 부모커밋에서 자식커밋 비교)

- git diff HEAD HEAD~1

![image](https://user-images.githubusercontent.com/103404127/186463905-f88710b5-165b-465c-84f8-65d97cdd982b.png)

- git diff HEAD~1

![image](https://user-images.githubusercontent.com/103404127/186464142-df89a5a5-ae2e-4f84-9f5f-6a0bab7d36cd.png)



**queen.txt 파일 변경후 저장. staging 등록 (커밋은x) / fleetwoodmac.txt 파일 변경후 저장. staging 등록 안한 상태에서**

작업 디렉토리에 있는 파일중 스테이지에 등록한 파일의 변경사항 출력

- git diff --staged
- git diff --cached

![image](https://user-images.githubusercontent.com/103404127/186465924-87fe8380-47d5-4f08-96f5-4307294033ef.png)

바로 전 커밋 이후 두 파일 모두 스테이지 등록했거나 등록하지 않은 모든 변경사항 출력

- git diff HEAD

![image](https://user-images.githubusercontent.com/103404127/186466660-79ede9fd-d408-47bb-afb8-7f22a65d89d9.png)
