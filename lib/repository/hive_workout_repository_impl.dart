import 'package:hive/hive.dart';
import '../model/workout.dart';
import 'workout_repository.dart';

class HiveWorkoutRepositoryImpl implements WorkoutRepository {
  static const _boxName = 'workoutBox';

  @override
  Future<void> saveWorkout(Workout workout) async {
    final box = await Hive.openBox<Workout>(_boxName);
    await box.add(workout);
  }

  @override
  Future<List<Workout>> getTodayWorkouts(String uid) async {
    final box = await Hive.openBox<Workout>(_boxName);
    final today = DateTime.now();
    return box.values
        .where(
          (w) =>
              w.uid == uid &&
              w.date.year == today.year &&
              w.date.month == today.month &&
              w.date.day == today.day,
        )
        .toList();
  }

}
