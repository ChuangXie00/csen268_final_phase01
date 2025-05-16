
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'page/login_page.dart';
import 'page/signup_page.dart';

// welcome
import 'package:flutter_bloc/flutter_bloc.dart'; // BlocProvider
import 'cubit/user_info_cubit.dart';             // Cubit


import 'page/welcome_page.dart';
import 'page/start_workout_page.dart';
import 'page/end_workout_page.dart';
// 引入AppShell容器
import 'page/app_shell.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
  path: '/welcome',
  builder: (context, state) => BlocProvider(
    create: (_) => UserInfoCubit(),
    child: const WelcomePage(),
  ),
),

    // ✅ Day04 修改：将 HomePage 替换为 AppShell 入口
    GoRoute(
      path: '/home',
      builder: (context, state) => const AppShell(),
    ),
    // GoRoute(
    //   path: '/start',
    //   builder: (context, state) => const StartWorkoutPage(),
    // ),
    // GoRoute(
    //   path: '/end',
    //   builder: (context, state) => const EndWorkoutPage(),
    // ),


    // GoRoute(path: '/log', builder: (context, state) => LogPage()),
    // GoRoute(path: '/info', builder: (context, state) => PersonalInfoPage()),
    // GoRoute(path: '/start', builder: (context, state) => StartWorkoutPage()),
    // GoRoute(path: '/end', builder: (context, state) => EndWorkoutPage()),
  ],
);
