import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../model/workout.dart';
import '../repository/workout_repository.dart';
import '../repository/user_repository.dart';
import '../repository/hive_user_repository_impl.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  final WorkoutRepository workoutRepository;
  final UserRepository userRepository;
  final String workoutType;

  Timer? _timer;
  int _seconds = 30; // 默认 30 秒倒计时
  int _elapsed = 0;

  WorkoutCubit({
    required this.workoutRepository,
    required this.userRepository,
    required this.workoutType,
  }) : super(WorkoutInitial());

  void startWorkout() {
    _timer?.cancel();
    emit(WorkoutRunning(_seconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds <= 0) {
        _finishWorkout();
        timer.cancel();
        return;
      }
      _seconds--;
      _elapsed++;
      emit(WorkoutRunning(_seconds));
    });
  }

  void pauseWorkout() {
    _timer?.cancel();
    emit(WorkoutPaused(_seconds));
  }

  void resumeWorkout() {
    startWorkout();
  }

  void quitWorkout() {
    _timer?.cancel();
    _finishWorkout();
  }

  void _finishWorkout() async {
    final calories = _elapsed * 5; // mock的卡路里

    final currentUser = await userRepository.getCurrentUser();
    if (currentUser == null) {
      emit(WorkoutCompleted(totalDuration: _elapsed, calories: calories));
      return;
    }

    final workout = Workout(
      uid: currentUser.email, // 以email区分用户（在login时保存了currentUserEmail）
      type: workoutType,
      durationMinutes: (_elapsed / 60).ceil(),
      calories: calories,
      date: DateTime.now(),
    );
    await workoutRepository.saveWorkout(workout);
    emit(WorkoutCompleted(totalDuration: _elapsed, calories: calories));
  }
}
