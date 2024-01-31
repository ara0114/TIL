# top
- 현재 리눅스 운영체제에서 실행중인 프로세스와 시스템 자원 사용량을 실시간으로 모니터링 할 수 있도록 도와줌
- 시스템 상태를 전반적으로 빠르게 파악 가능(CPU, Memory, Process)
- 상단에 요약정보, 하단에 상세정보가 표시
<img  width="600" alt="image" src="https://github.com/ara0114/TIL/assets/103404127/e76c4046-d26b-42ae-9197-d332e7d3f01c"/>

## 요약정보
- 시스템 현재시간, OS가 살아있는 시간, 현재 접속중인 유저 세션 수
- Load Average: CPU Load의 이동평균(1분, 5분, 15분에 대한 평균값)
  - CPU Load: CPU가 수행하는 작업량. 실행되거나 대기중인 프로세스 평균
- Tasks: 현재 프로세스들의 상태
- %Cpu(s): CPU 사용률
  - us: 사용자 프로세스가 사용하는 CPU 사용률
  - sy: 시스템 프로세스가 사용하는 CPU 사용률
  - ni: 높은 우선순위로 실행되는 프로세스가 사용하는 CPU 사용률
  - id: 사용하고 있지 않는 비율(유휴비율)
  - wa: IO가 완료될때까지 기다리고 있는 CPU 비율
  - hi: 하드웨어 인터럽트에 사용되는 CPU 사용률
  - si: 소프트웨어 인터럽트에 사용되는 CPU 사용률
  - st: CPU를 VM에서 사용하여 대기하는 CPU 비율
- 메모리영역(Mem/Swap): RAM의 메모리영역과 Disk를 메모리처럼 이용하는 Swap영역
  - total: 총 메모리양
  - free: 사용가능 메모리양
  - used: 사용중인 메모리양
  - buff/cache: IO와 관련되어 사용되는 버퍼에 사용되는 메모리크기
    - buffers: 커널 버퍼에 사용되는 메모리
    - cache: disck의 페이지 캐시
  - avail Mem: Swap메모리를 사용하지않고 사용할 수 있는 메모리크기
## 상세정보
- PID: 프로세스ID. 프로세스 식별하는데 사용
- USER: 해당 프로세스를 실행한 사용자
- PR: 우선순위
- NI: 우선순위에 영향을 주는 값(nice)
- 현재 프로세스가 사용하고 있는 메모리. 누수체크 가
  - VIRT: 프로세스가 사용하고 있는 가상메모리의 전체 용량. Swap+RES 
  - RES: 현재 프로세스가 사용하고 있는 물리 메모리양.
  - SHR: 다른 프로세스와 공유하고 있는 Shared Memory양
- S: 프로세스 상태
  - S: Sleeping
  - D: Uninterruptable Sleep
  - R: Running
  - I: Idle
  - T: 작업 제어신호에 의해 중지
  - t: Trace중 디버거에 의해 중지
  - Z: Zombie
- 사용률
  - %CPU: CPU 사용률
  - %MEM: Memory 사용률
- Time+: 누적 CPU 사용시간
- Command: 프로세스를 실행한 명령어 또는 프로그램
