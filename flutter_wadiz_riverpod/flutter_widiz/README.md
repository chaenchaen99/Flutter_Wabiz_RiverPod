# 프로젝트 소개
크라우드 펀딩 앱

## 폴더 구조 설계

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


# 라우터 구조 설계

| 홈 | /home | initialLocation | ShellRoute |
| 로그인   | /login |   |  |
| 회원가입  | /sign-up | 로그인 화면에서 이동  | push |
| 즐겨찾기(구독)  | /favorite |   |   |
| 마이페이지  | /my |   |   |
| 프로젝트 추가  | /add |   |   |
| 리워드  | /add/reward/:id | 마이페이지에서 이동 | push |
| 프로젝트 상세  | /detail |   |   |
| 카테고리  | /home/category/:id |   |   |