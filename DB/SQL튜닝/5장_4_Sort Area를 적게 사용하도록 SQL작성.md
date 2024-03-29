## 소트 데이터 줄이기

- 레코드당 바이트로 가공한 결과집합 sort area에 담는 경우 vs SQL을 가공하지 않은 상태로 정렬 완료 후 최종 출력시 가공 ⇒ 후자가 sort area 적게 사용
- 출력하는 컬럼 수에 따라 full scan해서 읽은 데이터량은 같지만 소트한 데이터량이 다르므로 성능 다름

## Top N 쿼리의 소트 부하 경감 원리

- 인덱스로 소트 연산을 생략할 수 없을 때 Top N쿼리의 작동
- TOP N 소트 알고리즘
    - 모든 데이터 집합
    - 큰 순서대로 N개 정렬
    - 나머지를 N개와 비교하며 재정렬하는 과정 반복
- 실행계획에 SORT ORDER BY STOPKEY로 나타나는 경우
    - 소트연산은 하지만 TOP N소트 알고리즘 작동
    - 소트연산(값 비교)횟수와 SORT AREA사용량 최소화

## Top N쿼리가 아닐 때 발생하는 소트 부하

- TOP N소트 알고리즘이 작동할 경우 메모리 내에서 정렬을 완료하지만 작동하지 않는경우 디스크를 이용해야함 ⇒ Temp TBS이용

## 분석함수에서의 Top N 소트

- RANK나 ROW_NUMBER함수는 MAX함수보다 소트 부하가 적음
    - TOP N소트 알고리즘이 작동하므로
