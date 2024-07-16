import 'package:flutter/material.dart';
import 'package:flutter_wadiz_riverpod/views/category/category_page.dart';
import 'package:flutter_wadiz_riverpod/views/home/home_page.dart';
import 'package:flutter_wadiz_riverpod/views/wabiz_app_shell.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/home",
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return WabizAppShell(
          currentIndex: 0,
          child: child,
        );
      },
      routes: [
        GoRoute(
            path: "/home",
            parentNavigatorKey: _shellNavigatorKey,
            builder: (context, state) => const HomePage(),
            routes: [
              GoRoute(
                  path: "category/:id",
                  builder: (context, state) {
                    final id = state.pathParameters['id'];
                    return CategoryPage(categoryId: id ?? "0");
                  })
            ]),
      ],
    ),
  ],
);
