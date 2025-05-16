import 'package:hive/hive.dart';

part 'workout.g.dart';

@HiveType(typeId: 1)
class Workout extends HiveObject {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final int durationMinutes;

  @HiveField(3)
  final int calories;

  @HiveField(4)
  final DateTime date;

  @HiveField(5)
  final bool completed;

  Workout({
    required this.uid,
    required this.type,
    required this.durationMinutes,
    required this.calories,
    required this.date,
    this.completed = true,
  });
}
