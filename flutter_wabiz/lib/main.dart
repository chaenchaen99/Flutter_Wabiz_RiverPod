import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wadiz_riverpod/router.dart';
import 'package:flutter_wadiz_riverpod/theme.dart';
import 'package:flutter_wadiz_riverpod/views/home/home_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "wabiz",
      theme: wabizDefaultTheme,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      themeAnimationStyle: AnimationStyle(
        curve: Curves.easeInCirc,
        duration: const Duration(
          milliseconds: 350,
        ),
      ),
      routerConfig: router,
    );
  }
}
