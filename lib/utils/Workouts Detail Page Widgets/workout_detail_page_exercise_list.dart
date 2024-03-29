import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/logger.dart';

import '../../screens/Exercise Screens.dart/add_exercise_to_workout_page.dart';
import '../../screens/Main Page/Workouts Page/workout_detail_page.dart';
import 'exercise_tile.dart';

class WorkoutDetailPageExerciseList extends StatelessWidget {
  const WorkoutDetailPageExerciseList({
    super.key,
    required this.exerciseData,
    required this.scaffoldKey,
  });
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> exerciseData;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: ListView.builder(
        itemCount: exerciseData.length + 1,
        itemBuilder: (context, index) {
          if (index < exerciseData.length) {
            final Map exercise = exerciseData[index].data();
            return ExerciseTile(
              exercise: exercise,
              scaffoldKey: scaffoldKey,
            );
          } else {
            return OutlinedButton(
              onPressed: () => context.navPushNamed(
                AddExerciseToWorkoutPage.routeName,
              ),
              child: const Text("Add Exercise"),
            );
          }
        },
      ),
    );
  }
}
