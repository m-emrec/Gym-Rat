// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/enums/exercises_collection_enum.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/models/exercise_model.dart';
import 'package:gym_rat_v2/provider/workout_provider.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ExerciseProvider extends ChangeNotifier {
  // ignore: constant_identifier_names
  static const String API_KEY = "3QiuXduPluL6XSoZaJ/LjA==wu6tKTBupAQ6KLxs";

  late String currentWorkoutId;
  int _exerciseOffset = 0;
  int get exerciseOffset => _exerciseOffset;
  set exerciseOffset(int offset) {
    _exerciseOffset = offset;
  }

  List _exerciseData = [];
  List get exerciseData => _exerciseData;
  set exerciseData(List val) {
    _exerciseData = val;
  }

  void setExerciseOffset({required int offset}) {
    _exerciseOffset += offset;
    notifyListeners();
  }

  /// Get's the current workout's ID
  setCurrentWorkoutId(String id) {
    currentWorkoutId = id;
  }

  Future<DocumentReference<Map<String, dynamic>>> getCurrentWorkoutDoc() async {
    final userWorkouts = await WorkoutProvider().getUserWorkouts();

    final selectedWorkout = userWorkouts.docs
        .firstWhere((doc) => doc.id == currentWorkoutId)
        .reference;
    return selectedWorkout;
  }

  Future<List> fetchExerciseData() async {
    final baseUrl = Uri.parse(
        "https://api.api-ninjas.com/v1/exercises?offset=$exerciseOffset");
    final Map<String, String> headers = {'X-Api-Key': API_KEY};
    final response = await http.get(baseUrl, headers: headers);

    if (response.statusCode == 200) {
      _exerciseData += (json.decode(response.body));
      final data = _exerciseData;
      // logger.d(_exerciseOffset);
      return data;
    }
    return [];
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getExerciseOfWorkout(
      String workoutId) async {
    final userWorkouts = await WorkoutProvider().getUserWorkouts();

    final selectedWorkout = await getCurrentWorkoutDoc();

    final exerciseCollection = selectedWorkout.collection("Exercises");

    return await exerciseCollection.get();
  }

  addExerciseToWorkout(ExerciseModel data) async {
    final currentWorkout = await getCurrentWorkoutDoc();
    final id = Uuid().v4();
    await currentWorkout.collection("Exercises").doc(id).set({
      ExercisesCollection.id.name: id,
      ExercisesCollection.exerciseName.name: data.exerciseName,
      ExercisesCollection.rest.name: data.rest,
      ExercisesCollection.numberOfReps.name: data.numberOfReps,
      ExercisesCollection.numberOfSets.name: data.numberOfSets,
      ExercisesCollection.rpe.name: data.rpe,
    });
  }

//* Filters

  // filter by Muscle

  // filter by Type

  // filter by Difficulty

//// end of filters

  ////
}
