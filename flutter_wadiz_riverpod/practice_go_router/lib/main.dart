import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_go_router/go_router_builder/builder_router.dart';

import 'go_router_basic/basic.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final _router = GoRouter(routes: $appRoutes);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Home Screen 입니다."),
            TextButton(
              onPressed: () {
                // GoRouter.of(context).go("/login");

                // context.go("/login");
                LoginRoute("").go(context);
              },
              child: const Text("로그인 페이지 이동"),
            ),
            TextButton(
              onPressed: () {
                // context.push("/user");
                UserRoute("10").push(context);
              },
              child: const Text("사용자 페이지로 이동"),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: const Center(
        child: Text("로그인 화면"),
      ),
    );
  }
}

class UserScreen extends StatelessWidget {
  const UserScreen({
    super.key,
    this.userId,
  });

  final String? userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Screen"),
      ),
      body: Center(
        child: Text("User $userId"),
      ),
    );
  }
}
