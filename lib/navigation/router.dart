import 'package:csen268_final_phase01/bloc/authentication_bloc.dart';
import 'package:csen268_final_phase01/model/workout.dart';
import 'package:csen268_final_phase01/page/home_page.dart';
import 'package:csen268_final_phase01/page/log_page.dart';
import 'package:csen268_final_phase01/page/start_workout_page.dart';
import 'package:csen268_final_phase01/utilities/stream_to_listenable.dart';
import 'package:csen268_final_phase01/widgets/scaffold_with_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../page/login_page.dart';
import '../page/signup_page.dart';

import '../page/end_workout_page.dart';

class RouteName {
  static const home = 'home';
  static const main = 'main';
  static const log = 'log';
  static const startWorkout = 'startWorkout';
  static const endWorkout = 'endWorkout';
  static const signup = 'signup';
  static const login = 'login';
}

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "Root",
);
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: "Shell",
);

GoRouter router(dynamic authenticationBloc) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    // TODO: Change initial location to login after development
    initialLocation: '/home',
    refreshListenable: StreamToListenable([authenticationBloc.stream]),
    redirect: (context, state) async {
      if (authenticationBloc.state is AuthenticationLoggedOut &&
          (!(state.fullPath?.startsWith("/login") ?? false))) {
        return "/login";
      } else {
        if ((state.fullPath?.startsWith("/login") ?? false) &&
            authenticationBloc.state is AuthenticationLoggedIn) {
          return "/home";
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: RouteName.login,
        builder: (context, state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: '/',
        name: RouteName.main,
        builder: (context, state) {
          return const HomePage();
        },
        routes: [
          ShellRoute(
            navigatorKey: shellNavigatorKey,
            builder: (context, state, child) {
              return ScaffoldWithNavBar(child: child);
            },
            routes: <RouteBase>[
              GoRoute(
                path: 'home',
                name: RouteName.home,
                builder: (context, state) => const HomePage(),
                routes: [
                  GoRoute(
                    path: 'startWorkout',
                    name: RouteName.startWorkout,
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final Workout? workout = state.extra as Workout?;
                      if (workout == null) {
                        print("No workout");
                      }
                      return StartWorkoutPage(workout: workout!);
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'log',
                name: RouteName.log,
                builder: (context, state) => const LogPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
