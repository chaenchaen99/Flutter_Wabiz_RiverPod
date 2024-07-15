import 'package:flutter/material.dart';

final ThemeData wabizDefaultTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white, //앱의 기본 배경 색상
  fontFamily: "Pretendard", //앱의 기본 글꼴
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      //하단 네비게이션 바 테마
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed, //고정타입
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey),
  primaryColor: AppColors.primary, //기본 색상
  appBarTheme: const AppBarTheme(
    //앱 바의 테마 설정
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    surfaceTintColor: Colors.white,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    //외곽선 버튼의 테마 설정
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      side: BorderSide(
        //외곽선 색상 및 너비 설정
        color: AppColors.wabizGray[200]!,
      ),
      foregroundColor: Colors.black,
      textStyle: const TextStyle(fontSize: 16),
      minimumSize: const Size(64, 50),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    // 입력 필드의 테마 설정
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        //외곽선 색상 및 너비 설정
        color: Color(0xffd4d4d4),
        width: 1.0,
      ),
    ),
    outlineBorder: const BorderSide(
      //외곽선 색상 설정
      color: AppColors.primary,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), //기본 외곽선 설정
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: 1.0,
      ),
    ),
    hintStyle: TextStyle(
      // 힌트 텍스트 스타일
      fontSize: 16,
      color: AppColors.wabizGray[400],
      fontWeight: FontWeight.w500,
    ),
  ),
  dialogTheme: DialogTheme(
    // 대화 상자 테마 설정
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

class AppColors extends Color {
  AppColors(super.value);

  static const Color scaffoldBackgroundColor = Color(0xfff2f4f6);
  static const Color primary = Color(0xff03c3c4);
  static const Color secondary = Color(0xffe2f9f9);
  static const Color white = Colors.white;
  static const Color bg = Color(0xfff2f2f7);
  static const Color newBg = Color(0xfff2f4f6);
  static const int grayPrimaryValue = 0xff848487;
  static const MaterialColor wabizGray =
      MaterialColor(grayPrimaryValue, <int, Color>{
    50: Color(0xffffebee),
    100: Color(0xffe5e5ea),
    200: Color(0xffd4d4d4),
    300: Color(0xffaeaeb2),
    400: Color(0xff828293),
    500: Color(grayPrimaryValue),
    600: Color(0xff646464),
    700: Color(0xff4a4a4a),
    800: Color(0xff303030),
    900: Color(0xff242424),
  });
}
