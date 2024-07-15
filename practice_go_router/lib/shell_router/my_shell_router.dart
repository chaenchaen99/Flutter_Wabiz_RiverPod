import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';

/*
GoRouter에서 GlobalKey를 사용하여 네비게이션 상태를 관리하는 이유는 네비게이션 트리를 명확하게 제어하고,
특히 중첩된 네비게이터 구조를 사용할 때 유연하게 네비게이션 동작을 관리하기 위함입니다.
GlobalKey를 사용하면 특정 네비게이터에 접근하여 네비게이션 작업을 수행할 수 있습니다. 
*/

GlobalKey<NavigatorState> _rootNavKey = GlobalKey();
GlobalKey<NavigatorState> _shellNavKey = GlobalKey();

final shellRouter = GoRouter(
  navigatorKey: _rootNavKey,
  initialLocation: "/user",
  routes: [
    ShellRoute(
        navigatorKey: _shellNavKey,
        routes: [
          GoRoute(
            path: "/user",
            builder: (context, state) => const UserScreen(),
          ),
          GoRoute(
            path: "/login",
            builder: (context, state) => const LoginScreen(),
          ),
        ],
        builder: (context, state, child) {
          return HomeScreen(
            child: child,
          );
        })
  ],
);
