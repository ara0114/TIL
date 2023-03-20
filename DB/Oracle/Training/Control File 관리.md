
## Control File 관리하기

### Control File 확인
- cd /u01/app/oracle/oradata/ORCL로 이동<br>
- vi control01.ctl 하면 Binary File임을 확인할 수 있다.<br>
<img src="https://user-images.githubusercontent.com/103404127/226248136-972280bb-9b21-4f5c-b348-5b81531b9a92.png">

### Spfile일 경우 다중화
- 현재 상태 및 spfile확인
<img src="https://user-images.githubusercontent.com/103404127/226248246-26790ca8-4280-4894-8726-9ffeb1358d94.png">

#### 1. 현재 Control file 조회
<img src="https://user-images.githubusercontent.com/103404127/226248903-e6bbfd08-7701-4479-92c9-b960577bf81e.png">

#### 2. Spfile의 내용(Control File의 위치)을 변경하고 인스턴스 종료
<img src="https://user-images.githubusercontent.com/103404127/226248963-8d55d3ae-ad5d-42fa-b73c-3793f3e66d66.png">

#### 3. 대상 디렉토리를 생성하고 해당 위치로 파일을 복사(다중화)
<img src="https://user-images.githubusercontent.com/103404127/226248994-5766e702-50b9-479e-9518-bc9e3164c4f0.png">

#### 4. 인스턴스 오픈하여 확인
<img src="https://user-images.githubusercontent.com/103404127/226249000-156cdf66-ce4a-478e-8513-ac3e253fac04.png">
정상적으로 인스턴스가 오픈되고 복사한 컨트롤 파일들을 확인할 수 있다.<br>

### Pfile일 경우 다중화
- 현재 Spfile이므로 Spfile에서 Pfile을 생성한 후 Spfile을 삭제
- $ORACLE_HOME/dbs는 spfile과 pfile의 기본 경로로 파일을 확인해 볼 수 있다.
<img src="https://user-images.githubusercontent.com/103404127/226249122-5a86906b-1407-439e-bd37-a7035df82c75.png">

- 인스턴스를 재시작하여 파라미터를 조회한다
<img src="https://user-images.githubusercontent.com/103404127/226249185-79b2bd6c-c7f7-4af1-94d1-d198ffc89d6e.png">
재시작 후 pfile을 조회했을 때 VALUE값에 아무것도 안나오므로 pfile을 사용중임을 알 수 있다.<br>

#### 1. 현재 사용중인 Control file 조회
<img src="https://user-images.githubusercontent.com/103404127/226249304-5c677776-1b96-4cb7-91f4-f9ef133c67ae.png">
현재 사용중인 컨트롤 파일을 조회하면 위에서 다중화해둔 컨트롤 파일들을 확인할 수 있다.<br>

#### 2. 인스턴스 종료
<img src="https://user-images.githubusercontent.com/103404127/226249339-99689ddc-2b3a-4bd9-aefa-084a78e957a0.png">

#### 3. pfile의 Control File 경로를 수정한 후 저장
<img src="https://user-images.githubusercontent.com/103404127/226249369-59d31b3d-d30b-46e6-95dc-eba34184ad00.png">
<img src="https://user-images.githubusercontent.com/103404127/226249375-80c18f49-ada8-433e-831a-9b6201b92b6d.png">
기존 Control File의 경로<br>
‘/home/oracle/disk1/control01.ctl’,‘/home/oracle/disk2/control02.ctl’,‘/home/oracle/disk3/control03.ctl’에서<br>
‘/home/oracle/disk4/control01.ctl’,‘/home/oracle/disk5/control02.ctl’,‘/home/oracle/disk6/control03.ctl’으로 변경해준다.<br>

#### 4. 대상 디렉토리를 생성하고 해당 위치로 파일을 복사(다중화)
<img src="https://user-images.githubusercontent.com/103404127/226249419-31f9b14d-de9c-46dd-bd87-870a313e0a46.png">

#### 5. 인스턴스 오픈하여 확인
<img src="https://user-images.githubusercontent.com/103404127/226249429-1d24fe4f-3421-4281-b3ad-c7c84cca5a31.png">
정상적으로 인스턴스가 오픈되고 복사한 컨트롤 파일들을 확인할 수 있다.
