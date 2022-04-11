

# Git & Git hub

## 1. Git 설치

- [Git 사이트에 접속](https://git-scm.com/)

  - `Downloads` 에서 사양에 맞는 파일 선택하여 다운로드
  - 설치파일 더블클릭하여 실행
  

- 설치확인
  * 시작 - `Git Bash` 검색하여 실행
  * 터미널 창에서 `git --version`입력하여 설치된 버전 정보가 잘 나오는지 확인



## 2. Git 초기 설정

  > 최초 한번만 설정

  1. 누가 커밋 기록을 남겼는지 확인할 수 있도록 이름과 이메일을 설정.

     작성자를 수정하고 싶을 때에는 이름, 메일 주소만 다르게 하여 동일하게 입력.

     ```bash
     $git config --global user.name "이름"
     $git config --global user.email "메일주소"
     ```
     
  2. 작성자가 올바르게 설정되었는지 확인하기.

     ```bash
     $git config --global -l
     또는
     $git config --global --list
     ```



## 3. Git

* Git이란?

  * 분산 버전 관리 시스템.

  * __Working Directory → Staging Area → Repository__ 의 과정으로 버전 관리 수행

    * `Working Directory(=Working Tree)` : 사용자의 일반적인 작업이 일어나는 곳

    * `Staging Area(=Index)` : 사용자의 일반적인 작업이 일어나는 곳

    * `Repository` : 사용자의 일반적인 작업이 일어나는 곳

- Git 명령어

  1. git init

     - 현재 작업중인 디렉토리를 Git으로 관리하겠다.
  
     ```bash
     $git init
     ```
  
     - `.git`이라는 숨김 폴더를 생성하고, 터미널에는  `(master)`로 표기

     - 절대로 홈 디렉토리에서 git init ❌ (터미널의 경로가 `~` 인지 확인)

  
  
  2. git status
  
     - Working Directory와 Staging Area에 있는 파일의 현재 상태를 알려주는 명령어.
  
     ```bash
     $git status
     
     #상태
      ‣ Untracked: Git이 관리하지 않는 파일(한번도 Staging Area에 올라간적 없는 파일)
      ‣ Tracked: Git이 관리하는 파일
     	- Unmodified: 최신상태
     	- Modified: 수정되었지만 아직 Staging Area에 반영하지 않은 상태
     	- Staged: Staging Area에 올라간 상태
     ```
  
     - 어떤 작업을 하기전에 수시로 확인하면 좋다.
  
     
  
  3. git add
  
     - Working Directory에 있는 파일을 Staging Area로 올리는 명령어.
  
     ```bash
     #특정 파일
     $git add a.txt
     
     #특정 폴더
     $git add my_folder/
     
     #현재 디렉토리에 속한 파일/폴더 전부
     $git add .
     ```
  
     - Git이 해당 파일을 추적(관리)할 수 있도록 만들어줌.
  
     - `Untracked, Modified` 에서 `Staged` 로 상태 변경.
  
  
  
  4. git commit
  
     - Staging Area에 올라온 파일의 변경사항을 하나의 버전(커밋)으로 저장하는 명령어.
  
     ```bash
     $git commit -m "커밋메세지"
     ```
  
     - `커밋메세지`는 현재 변경사항들을 잘 나타낼 수 있도록 __의미있게__ 작성하는 것을 권장.
  
     - 각각의 커밋은 고유의 해시값을 ID로 가짐.
  
     - `(root -commit)` 은 해당 커밋이 최초의 커밋일 때만 표시됌.
  
  
  
  5. git log
  
     - 커밋의 내역(ID, 작성자, 시간, 메세지 등)을 조회할 수 있는 명령어.
  
     ```bash
     $git log
     
     #옵션
      ‣ --oneline: 한줄로 축약해서 보여줌
     ```
  



## 4. Github

- 로컬저장소 → 원격저장소

  1. git remote

     - 로컬 저장소에 원격 저장소를 `등록, 조회, 삭제` 할 수 있는 명령어
     
     
     - 원격 저장소 등록
     
     ```bash
     $git remote add origin https://github.com/ara0114/TIL.git
        
     # `git remote add 이름 주소` 형식으로 작성.
     ```
     
     - 원격 저장소 조회
     
     ```bash
     $git remote -v
     ```
     
     - 원격 저장소 연결 삭제
     
     > 로컬과 원격저장소의 연결을 끊는 것(저장소 자체를 삭제하는게 아님)
     
     ```bash
     $git remote rm origin
     $git remote remove origin
     
     #`git remote rm 이름` 또는 `git remote remove 이름` 형식으로 작성
     ```
     
     
  
- 원격저장소에 업로드
  
     1. git push
     
        - 로컬 저장소의 커밋을 원격 저장소에 업로드하는 명령어.
     
        ```bash
        $git push origin master
        
        #`git push 저장소이름 브랜치이름` 형식으로 작성
        ```
     
        
