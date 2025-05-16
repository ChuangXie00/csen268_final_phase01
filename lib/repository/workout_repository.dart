import '../model/workout.dart';

abstract class WorkoutRepository {
  Future<void> saveWorkout(Workout workout);
  Future<List<Workout>> getTodayWorkouts(String uid);
}
