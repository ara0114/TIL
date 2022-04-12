# Git & Git hub

### 04/12

#### 1. branch

- 나뭇가지처럼 여러 갈래로 작업 공간을 나누어 독립적으로 작업할 수 있도록 도와줌
- 장점
  - 독립 공간을 형성하므로 원본(master)이 안전
  - 하나의 작업이 하나의 브랜치로 나누어 진행되므로 체계적인 개발이 가능
  - Git은 브랜치 만드는 속도가 굉장히 빠르고 용량도 적음

1. git branch

   - 브랜치 조회, 생성, 삭제 등

   ```bash
   # 브랜치 목록 조회
   $git branch
   
   # 브랜치 새로 생성하기
   $git branch <브랜치 이름>
   
   # 브랜치 삭제하기
   $git branch -d <브랜치 이름>
    (‣주의: -D 사용시 강제 삭제)
   ```

   

2. git switch

   - 다른 브랜치로 이동

   ```bash
   # 다른 브랜치로 이동
   $git switch <이동할 브랜치 이름>
    
   # 브랜치 새로 생성과 동시에 이동
   $git switch -c <브랜치 이름>
   ```

    
    
3. git merge

   - 분기된 브랜치들을 하나로 합치는 명령어
   - Merge하기 전에 우선 메인 브랜치로 switch 해야함.

   ```bash
   $git merge branch1
    
   #`git merge <합치려는 대상 브랜치 이름>`
   ```

   - Merge Conflict

     - Merge하는 두 브랜치에서 같은 파일의 한 부분을 동시에 수정하고 Merge하면 Conflict 발생

       (같은 파일이더라도 서로 다른 부분 수정시, Conflict 없이 자동으로 Merge commit)

     - 해결방법
        
     ```bash
     1. $git status로 충돌 파일 확인
     2. 해당 파일을 열면 충돌 내역이 나옴
     3. `=======`를 기준으로 위와 아래 내용 중 하나를 고르거나, 새로 작성
     4. 내용 선택/수정 후 저장
     5. merge commit 진행
        ($git add & $git commit)
     ```



#### 2. Git workflow

1) 원격 저장소 소유권이 없는 경우(Fork & Pull)

   - 오픈 소스 프로젝트와 같이 자신의 소유가 아닌 원격 저장소인 경우 사용

   - 진행순서

     (1)  소유권이 없는 원격 저장소를 `fork`를 통해 내 원격 저장소로 복제

     - (온라인) 원본 원격 저장소에서 `Fork`버튼을 누르면 자동으로 내 원격 저장소에 복제

     (2) __복제된 내 원격 저장소__에서 로컬 저장소로 `clone`

     ```bash
     $git clone <내 원격 저장소 주소>
     ```

     (3) 로컬 저장소와 원격 저장소를 연결

     - 원본 원격 저장소에 대한 이름은 `upstream`으로 붙이는 것이 일종의 관례

     ```bash
     $git remote add upstream <원본 원격 저장소 주소>
     ```

     (4) 로컬에서 자신이 작업할 기능에 대한 __브랜치 생성__ 및 __기능구현__

     ```bash
     $git switch -c <브랜치명>
     ```

     (5) 기능이 구현 완료되면 __복제된 내 원격 저장소__에 브랜치를 `push`

     ```bash
     $git push origin <브랜치명> 
     ```

     (6) 복제된 내 원격 저장소에서 master와 브랜치 반영확인

     (7) `Pull Request`를 통해 원본 원격 저장소의 master에 반영 요청

     - (온라인) 복제된 내 원격 저장소에서 `Compare & pull request`버튼을 누름
     - 혹은 내 원격 저장소 상단 `Pull request`메뉴를 누르고 `New pull request`로 진행
     - 원본 원격 저장소의 관리자가 반영 여부 결정

     (8) 원본 원격 저장소(upstream)의 master에 브랜치가 merge되면 복제된 원격 저장소(origin)의 브랜치는 삭제

     (9) 로컬에서 master 브랜치로 이동

     ```bash
     $git switch master
     ```

     (10) 변경된 원본 원격 저장소(upstream)의 master 내용을 로컬에 받아옴

     ```bash
     $git pull upstream master
     ```

     (11) 로컬 브랜치 삭제

     ```bash
     $git branch -d <브랜치명>
     ```

     (12) 새로운 기능 추가를 위해 새로운 브랜치를 생성하며 위 과정 반복

     

2. 원격 저장소 소유권이 있는 경우(Shared repository)

   - 원격 저장소가 자신의 소유이거나 collaborator로 등록되어 있는 경우에 가능

   - master에 직접 개발하는 것이 아니라, 기능별로 브랜치를 만들어 따로 개발

   - Pull request를 같이 사용하여 팀원 간 변경 내용에 대한 소통 진행

   - 진행순서

     (1) 소유권이 있는 원격 저장소를 로컬 저장소로 `clone`

     ```bash
     $git clone <주소>
     ```

     (2) 자신이 작업할 기능에 대한 __브랜치 생성__ 및 __기능구현__

     ```bash
     $git switch -c <브랜치명>
     ```

     (3) 기능구현이 완료되면, 원격 저장소에 해당 브랜치를 `push`

     ```bash
     $git push origin <브랜치명>
     ```

     (4) 원격 저장소에서 master와 각 기능의 브랜치 반영 확인

     (5) Pull Request를 통해 master에 브랜치 반영 요청

     ​	(팀원들과 코드 리뷰를 통해 소통 가능)

     (6) 원격저장소에 merge가 완료된 브랜치는 불필요하므로 삭제

     (7) merge가 완료되면 로컬에서 master 브랜치로 이동

     ```bash
     $git switch master
     ```

     (8) 변경된 원격 저장소의 master 내용을 로컬에 받아옴

     ```bash
     $git pull origin master
     ```

     (9) 로컬 브랜치 삭제

     ```bash
     $git branch -d <브랜치명>
     ```

     (10) 새로운 기능 추가를 위해 새로운 브랜치를 생성하며 위 과정 반복