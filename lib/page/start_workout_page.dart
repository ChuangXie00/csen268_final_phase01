import 'package:csen268_final_phase01/model/workout.dart';
import 'package:csen268_final_phase01/widgets/workout_detail.dart';
import 'package:flutter/material.dart';

class StartWorkoutPage extends StatelessWidget {
  const StartWorkoutPage({super.key, required this.workout});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    // TODO: Add the play / pause button.
    return Scaffold(
      appBar: AppBar(title: Text(workout.title), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: WorkoutDetail(workout: workout),
        ),
      ),
    );
  }
}
