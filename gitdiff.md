**git diff** : 깃의 변경사항 보여줌

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

git diff, git diff --HEAD, git --staged, git --cached, git diff HEAD[파일이름], git diff staged[파일이름], git diff[브랜치이름], git diff 커밋해시, ...

---

