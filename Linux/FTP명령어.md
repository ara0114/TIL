# FTP명령어

## 1) 일반 명령어
- help 또는 ? : 명령어 보기.
- ls : 파일 및 디렉토리 목록 보기. shell에서 ls와 같다.
- dir : 파일 및 디렉토리의 접근 권한과 목록을 자세히 출력. 유닉스쉘에서 ls -al과 같은 효과.
- pwd : 현재 디렉토리 위치 확인.
- cd : Remote System에서 디렉토리 이동.
- lcd : Local System의 디렉토리 변경. 파일 수신시 보관하려는 디렉토리를 변경할 때 사용.
- close : ftp> 프롬프트에서 원격지 시스템의 연결을 끝낸다. ftp 프로그램은 종료하지 않는다.
- disconnect : 원격지 시스템의 접속 종료. ftp 프로그램은 종료하지 않는다.
- quit 또는 bye : 원격지 시스템의 접속을 종료하고 쉘상태로 복귀한다.
## 2) 환경 설정 명령어
- bin 또는 binary : binary 파일을 전송하기 위한 세팅.
- ascii : text 파일을 전송하기 위한 세팅.
- prompt : mput 또는 mget 명령시 대화형식 처리를 무시.
- hash : 파일의 전송상황 표시. #로 표시.
## 3) 파일 전송 명령어
- get : 하나의 파일을 Remote System에서 Local System으로 가져 온다.
- mget : 여러 개의 Local System으로 가져 온다.
- put : 하나의 파일을 Local System에서 Remote System으로 올린다.
- mput : 여러 개의 파일을 Remote System으로 올린다.
## 4) 기타 명령
- ! : 쉘로 잠시 나가 쉘명령을 수행.
- append : Local 시스템에서 원격시스템으로 파일의 전송시 이어받기.
- bell : 명령어 수행 후 벨소리 On/Off.
- case : 파일 전송시 대,소문자 구분을 변환.
- cdup : 상위 디렉토리로 이동.
- cr : 텍스트 파일 전송시 엔터코드(Carriage Return) 유무를 조정.
- delete : 파일 삭제.
- mdelete : 여러 파일 삭제.
- mode : 파일 전송 모드 선택.
- proxy : 지정된 명령어들을 선택적으로 사용.
- recv : 지정한 파일을 Local 시스템으로 전송받는다.
- remotehelp : 원격시스템의 도움말 출력.
- rename : 파일 이름 변경.
- reset : 지정한 환경을 모두 해제.
- rmdir : 디렉토리 삭제.
- send : 원격시스템으로 파일을 전송한다.
- struct : 전송할 파일의 구조를 지정.
- status : 지정한 환경 선택사항의 현재 상태 표시.
- trace : 패킷라인 검사.
- type : 파일 전송 모드 지정.
- user : 사용자 이름(Name:)과 암호 설정.
