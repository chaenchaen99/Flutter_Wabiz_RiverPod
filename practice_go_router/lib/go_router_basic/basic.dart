import 'package:go_router/go_router.dart';

import '../main.dart';

final routerBasic = GoRouter(
  routes: [
    GoRoute(
        path: "/",
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: "user",
            builder: (context, state) => const UserScreen(),
          )
        ]),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginScreen(),
    ),
    // GoRoute(
    //   path: "/user",
    //   builder: (context, state) => const UserScreen(),
    // ),
  ],
);
