import 'package:csen268_final_phase01/cubit/user_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'page/login_page.dart';
import 'page/signup_page.dart';
import 'page/welcome_page.dart';
import 'page/home_page.dart';
import 'page/log_page.dart';
import 'page/personal_info_page.dart';
import 'page/start_workout_page.dart';
import 'page/end_workout_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginPage()),
    GoRoute(path: '/signup', builder: (context, state) => SignupPage()),
    GoRoute(
      path: '/welcome',
      builder:
          (context, state) => BlocProvider(
            create: (_) => UserInfoCubit(),
            child: const WelcomePage(),
          ),
    ),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    // GoRoute(path: '/log', builder: (context, state) => LogPage()),
    // GoRoute(path: '/info', builder: (context, state) => PersonalInfoPage()),
    // GoRoute(path: '/start', builder: (context, state) => StartWorkoutPage()),
    // GoRoute(path: '/end', builder: (context, state) => EndWorkoutPage()),
  ],
);
