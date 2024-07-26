import 'package:flutter/material.dart';
import 'package:flutter_wadiz_riverpod/views/category/category_page.dart';
import 'package:flutter_wadiz_riverpod/views/favorite/favorite_page.dart';
import 'package:flutter_wadiz_riverpod/views/home/home_page.dart';
import 'package:flutter_wadiz_riverpod/views/login/sign_in_page.dart';
import 'package:flutter_wadiz_riverpod/views/login/sign_up_page.dart';
import 'package:flutter_wadiz_riverpod/views/my/my_page.dart';
import 'package:flutter_wadiz_riverpod/views/project/add_project_page.dart';
import 'package:flutter_wadiz_riverpod/views/project/add_reward_page.dart';
import 'package:flutter_wadiz_riverpod/views/project/project_detail_page.dart';
import 'package:flutter_wadiz_riverpod/views/wabiz_app_shell.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: "/home",
  routes: [
    GoRoute(
      path: "/sign-in",
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return const SingInPage();
      },
    ),
    GoRoute(
      path: "/sign-up",
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return const SignUpPage();
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return WabizAppShell(
          currentIndex: switch (state.uri.path) {
            var p when p.startsWith("my") => 3,
            var p when p.startsWith("favorite") => 2,
            _ => 0,
          },
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
        GoRoute(
          path: "/favorite",
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const FavoritePage(),
        ),
        GoRoute(
          path: "/my",
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const MyPage(),
        ),
      ],
    ),
    GoRoute(
      path: "/add",
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AddProjectPage(),
      routes: [
        GoRoute(
          path: "reward/:id",
          builder: (context, state) {
            final projectId = state.pathParameters['id']!;
            return AddRewardPage(projectId: projectId);
          },
        )
      ],
    ),
    GoRoute(
      path: "/detail",
      builder: (context, state) {
        final project = state.extra as String;
        return ProjectDetailPage(
          project: project,
        );
      },
    ),
  ],
);
