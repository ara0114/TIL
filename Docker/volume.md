## volume

컨테이너를 삭제하면 데이터들이 같이 사라지게 되는데

이런점을 해결하는 방법중 하나가 볼륨을 이용하는 것



호스트와 볼륨을  공유하면 

=> 컨테이너를 삭제하더라도 호스트에 있는 폴더는 보존

호스트와 볼륨을 연결하면

=> 여러개 컨테이너에 공유되어 볼륨을 컨테이너처럼 사용가능



볼륨 생성

- `docker volume create [볼륨이름]`

볼륨 확인

- `docker volume ls`

호스트어느경로에 만들어졌는지 확인

- `docker volume inspect [볼륨이름]`

볼륨 삭제

- `docker volume rm [볼륨이름]`

사용되지 않는 방치된 볼륨 한번에 삭제

- `docker volume prune`

