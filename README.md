## ⎷ 프로젝트 소개
크라우드 펀딩 앱 - 구현 이미지

<p>
    <img src="https://github.com/user-attachments/assets/02944d15-467c-4333-8108-44f97f213015" alt="Screenshot_1722262705" style="width:30%;"/>
    <img src="https://github.com/user-attachments/assets/87459c6f-8580-4fd9-9db0-f8c871f1c654" alt="Screenshot_1722262736" style="width:30%;"/>
    <img src="https://github.com/user-attachments/assets/1a81eadb-53b8-42d6-b7fe-a12aa6e187a2" alt="Screenshot_1722262764" style="width:30%;"/>
    <img src="https://github.com/user-attachments/assets/a2ea98fa-0997-48ac-92e6-dea60bfd55c9" alt="Screenshot_1722262780" style="width:30%;"/>
</p>

</br>

## ⎷ 폴더 구조 설계

계층기반: 계층 내 Feature가 포함된 방식

```
    - lib
        - enum
        - model
        - common
            - response_model.dart
        - provider
            - network_provider.dart
        - repository
            - home
                - home_repository.dart
        - service
            - project
                - project_api.dart
                - project_api_service.dart
        - view_model
            - project
                - project_view_model.dart
        - views
            - project
                - project_detail_page.dart
            - wadiz_app_shell.dart
        - main.dart
        - theme.dart

```


## ⎷ 라우터 구조 설계

| 홈 | /home | initialLocation | ShellRoute | </br>
| 로그인   | /login | </br>
| 회원가입  | /sign-up | </br>
| 즐겨찾기(구독)  | /favorite | </br> 
| 마이페이지  | /my |  </br>
| 프로젝트 추가  | /add | </br>
| 리워드  | /add/reward/:id | </br>
| 프로젝트 상세  | /detail |  </br>
| 카테고리  | /home/category/:id | </br>
