## 크라우드 펀딩 앱

<p>
    <img src="https://github.com/user-attachments/assets/02944d15-467c-4333-8108-44f97f213015" alt="Screenshot_1722262705" style="width:30%;"/>
    <img src="https://github.com/user-attachments/assets/87459c6f-8580-4fd9-9db0-f8c871f1c654" alt="Screenshot_1722262736" style="width:30%;"/>
    <img src="https://github.com/user-attachments/assets/1a81eadb-53b8-42d6-b7fe-a12aa6e187a2" alt="Screenshot_1722262764" style="width:30%;"/>
    <img src="https://github.com/user-attachments/assets/a2ea98fa-0997-48ac-92e6-dea60bfd55c9" alt="Screenshot_1722262780" style="width:30%;"/>
</p>

이 앱은 개인이나 기업이 프로젝트, 제품, 서비스 등을 개발하기 위해 대중으로부터 소액의 자금을 모을 수 있도록 돕는 크라우드 펀딩 플랫폼을 클론 코딩하여 만든 앱입니다. 상태관리를 위해 Riverpod을 사용하였으며, figma 디자인 가이드를 따라 작업하였습니다.
</br>


📅 **프로젝트 개요**  
- **개발 기간:** 2024.07  

### 사용 기술
- Flutter
- Dart
- Riverpod
- Riverpod Annotation
- freezed
- retrofit
- go_router
- Figma

🚀 **주요 기능**
- 메인화면 : 크라우드 펀딩 프로젝트 목록 가시화
- 카테고리 화면 : 카테고리별 프로젝트 타입 필터링, 프로젝트 목록의 아이템 정보 표시(이미지, 제목, 생성자, 참여 수, 금액)
- 마이페이지 화면 : 로그인 여부에 따라 다른 화면 표시(로그인되어있는 경우 프로젝트 추가화면으로 이동, 그렇지 않은 경우 로그인 필요를 안내)
- 프로젝트 추가 화면 : 카테고리선택, 프로젝트 유형, 목표 금액, 프로젝트 제목, 이미지, 종료일, 요약, 저장하기 버튼 위젯 표시 및 기능 연동
- 로그인 화면 : 이메일, 회원가입 텍스트 입력창 표시, 회원가입 버튼 표시 및 기능 연동
- 회원가입 화면 : 닉네임, 이메일, 비밀번호 입력창, 약관 동의 버튼 표시 및 기능 연동


🛠️ **주요 업무**
- 디자인 화면 UI 퍼블리싱
- 아키텍처 설계 및 각 기능과 관심사에 대한 구현 처리
- freezed를 활용한 데이터 모델 생성
- 라우팅 처리
- 서버와 API 규격에 맞게 통신 로직 작성


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
