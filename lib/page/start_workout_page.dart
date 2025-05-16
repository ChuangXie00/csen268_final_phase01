import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/workout_cubit.dart';
import '../repository/workout_repository.dart';
import '../repository/user_repository.dart';
import '../repository/hive_workout_repository_impl.dart';
import '../repository/hive_user_repository_impl.dart';

class StartWorkoutPage extends StatelessWidget {
  const StartWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WorkoutCubit(
        workoutRepository: HiveWorkoutRepositoryImpl(),
        userRepository: HiveUserRepositoryImpl(),
        workoutType: 'push-ups', // 你可改为动态参数
      )..startWorkout(), // 页面加载即启动计时
      child: const StartWorkoutView(),
    );
  }
}

class StartWorkoutView extends StatelessWidget {
  const StartWorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkoutCubit>();
    final workoutType = cubit.workoutType;

    return Scaffold(
      appBar: AppBar(
        title: Text(workoutType[0].toUpperCase() + workoutType.substring(1)),
      ),
      body: BlocBuilder<WorkoutCubit, WorkoutState>(
        builder: (context, state) {
          int secondsLeft = 0;
          if (state is WorkoutRunning) {
            secondsLeft = state.secondsLeft;
          } else if (state is WorkoutPaused) {
            secondsLeft = state.secondsLeft;
          }

          if (state is WorkoutCompleted) {
            Future.microtask(() {
              context.go('/end', extra: {
                'duration': state.totalDuration,
                'calories': state.calories,
              });
            });
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Start Block
                  _sectionTitle('Start'),
                  _grayBox('Start Position'),

                  _sectionTitle('End'),
                  _grayBox('End Position'),

                  _sectionTitle('Description'),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '1: Keep your body straight\n'
                      '2: Lower your chest\n'
                      '3: Push up with arms\n'
                      '4: Exhale on upward\n'
                      '5: Repeat for 30s\n'
                      'Good Luck!',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Text('$secondsLeft s', style: const TextStyle(fontSize: 32)),

                  const SizedBox(height: 12),
                  _circleControlButton(context, state),

                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => cubit.quitWorkout(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Quit'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String title) => Align(
        alignment: Alignment.centerLeft,
        child: Text(title,
            style: const TextStyle(fontSize: 18, color: Colors.orange)),
      );

  Widget _grayBox(String label) => Container(
        height: 150,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 16, top: 8),
        color: Colors.grey[400],
        alignment: Alignment.center,
        child: Text(label),
      );

  Widget _circleControlButton(BuildContext context, WorkoutState state) {
    final cubit = context.read<WorkoutCubit>();
    final isPaused = state is WorkoutPaused;

    return GestureDetector(
      onTap: () {
        isPaused ? cubit.resumeWorkout() : cubit.pauseWorkout();
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isPaused ? Icons.play_arrow : Icons.pause,
          color: Colors.black,
          size: 32,
        ),
      ),
    );
  }
}
