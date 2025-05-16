part of 'workout_cubit.dart';

abstract class WorkoutState {}

class WorkoutInitial extends WorkoutState {}

class WorkoutRunning extends WorkoutState {
  final int secondsLeft;
  WorkoutRunning(this.secondsLeft);
}

class WorkoutPaused extends WorkoutState {
  final int secondsLeft;
  WorkoutPaused(this.secondsLeft);
}

class WorkoutCompleted extends WorkoutState {
  final int totalDuration;
  final int calories;
  WorkoutCompleted({required this.totalDuration, required this.calories});
}
