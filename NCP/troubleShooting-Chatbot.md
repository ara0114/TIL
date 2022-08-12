> <h2>챗봇 답변 입력 후 빌드 및 배포할 때</h2>

**문제발생**

- 브라우저에 줄바꿈이 되지 않음

![image](https://user-images.githubusercontent.com/103404127/184349110-cf6ae418-932f-4d0f-ae87-657399d96907.png)

![image](https://user-images.githubusercontent.com/103404127/184347435-7470df12-54f7-451e-933b-76c68a64db7d.png)

- 엔터 대신 `\n` 입력후 빌드 및 배포해보았으나 텍스트로 반영되어 줄바꿈이 되지 않음

![image](https://user-images.githubusercontent.com/103404127/184348932-3a3a86f9-6fb2-419f-a79b-f15a93fa1871.png)

![image](https://user-images.githubusercontent.com/103404127/184347511-a54abdca-0994-4459-a428-73a74dbb8196.png)

**해결**

- `<br>`태그 입력하여 빌드 후 배포

![image](https://user-images.githubusercontent.com/103404127/184348666-1b33cd6f-db41-423a-9054-99bee0ae7cde.png)



![image](https://user-images.githubusercontent.com/103404127/184348506-6e5f9eb8-421e-477a-912c-3a0d517b7868.png)

---



> <h2>https인증 서버에 배포했을때</h2>

**문제발생**

- http 로컬에서 작동하던 챗봇이 https 인증 서버에 올라간 후, 검색버튼 비활성화되는 문제(질문선택후 검색불가)

**해결**

- WebSocketConfig.java

![image](https://user-images.githubusercontent.com/103404127/184350224-eec47f49-cba8-4770-b730-33faa5968aeb.png)

registry.addEndpoint("/ws")를 registry.addEndpoint("/wss")로 변경

setAllowedOriginPatterns("*")추가

- app.js

![image](https://user-images.githubusercontent.com/103404127/184350411-ffed41b6-3625-4da3-81f9-d1e78398a109.png)

socket = new SockJS('/ws')를 socket = new SockJS('/wss')로 변경

