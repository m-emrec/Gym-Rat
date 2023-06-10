import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:http/http.dart' as http;

import '../models/workout_model.dart';
import 'cycle_provider.dart';

class WorkoutProvider extends ChangeNotifier {
  /// Get the current user's workouts from the database
  Future<QuerySnapshot<Map<String, dynamic>>> getUserWorkouts() async {
    // logger.v("get workouts");
    final DocumentReference<Map<String, dynamic>> activeCycle =
        await CycleProvider().getActiveCycle();
    final userWorkouts = activeCycle.collection("Workouts").get();
    return userWorkouts;
  }

  /// add new workout data to database
  Future addWorkoutToDatabase({
    required String cycleID,
    required List<WorkoutModel> data,
  }) async {
    /// Find the cycle which user tries to create.
    final cycle =
        await CycleProvider().getCycles().then((value) => value.doc(cycleID));

    final workoutCollection = cycle.collection("Workouts");

    /// add data to the @[workoutCollection] collection
    for (var element in data) {
      workoutCollection.doc(element.id).set(
        {"workoutName": element.name},
      );
    }
    // workoutCollection.doc()
  }

  deleteWorkout() {}

  updateWorkout() {}

  addExerciseToWorkout() {}

  ////////////
}
