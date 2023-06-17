// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/enums/exercises_collection_enum.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/models/exercise_model.dart';
import 'package:gym_rat_v2/provider/workout_provider.dart';
import 'package:http/http.dart' as http;

class ExerciseProvider extends ChangeNotifier {
  // ignore: constant_identifier_names
  static const String API_KEY = "3QiuXduPluL6XSoZaJ/LjA==wu6tKTBupAQ6KLxs";

  late String currentWorkoutId;

  /// @[exerciseOffset]
  int _exerciseOffset = 0;
  int get exerciseOffset => _exerciseOffset;
  set exerciseOffset(int offset) {
    _exerciseOffset = offset;
  }

  void setExerciseOffset({required int offset}) {
    _exerciseOffset += offset;
    notifyListeners();
  }
  ////

  /// @[exerciseData]
  List _exerciseData = [];
  List get exerciseData => _exerciseData;
  set exerciseData(List val) {
    _exerciseData = val;
  }
  ////

  ///
  /// @[filters]
  Map _filters = {};
  set filters(Map filterBy) {
    _filters = filterBy;
  }

  Map get filters => _filters;

  void setFilters(Map filterBy) {
    _filters.addAll(filterBy);
    _exerciseData = [];
    _exerciseOffset = 0;
    notifyListeners();
  }

  ////

  /// @[searchName]

  String _searchName = "";
  String get searchName => _searchName;
  set searchName(String name) {
    _searchName = name;
  }

  void searchByName(String name) {
    _searchName = name;
    _exerciseData = [];
    _exerciseOffset = 0;
    logger.d(_searchName);
    notifyListeners();
  }

  /// resets the value of the variables.
  resetData() {
    _exerciseData = [];
    _exerciseOffset = 0;
    _searchName = "";
    _filters = {};
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

  Future<List> fetchExerciseData({List<String>? filters}) async {
    final baseUrl = Uri.parse(
      "https://api.api-ninjas.com/v1/exercises?&name=$_searchName&muscle=${_filters["byMuscle"] ?? ""}&type=${_filters["byType"] ?? ""}&difficulty=${_filters["byDiff"] ?? ""}&offset=$exerciseOffset",
    );
    final Map<String, String> headers = {'X-Api-Key': API_KEY};
    final response = await http.get(baseUrl, headers: headers);

    if (response.statusCode == 200) {
      _exerciseData += (json.decode(response.body));
      final data = _exerciseData;
      // logger.d(data);
      return data;
    }
    return [];
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getExerciseOfWorkout(
      String workoutId) async {
    final selectedWorkout = await getCurrentWorkoutDoc();

    final exerciseCollection =
        selectedWorkout.collection("Exercises").orderBy("exerciseIndex");

    return await exerciseCollection.get();
  }

  /// Database CRUD operations
  addExerciseToWorkout(ExerciseModel data) async {
    final currentWorkout = await getCurrentWorkoutDoc();
    int index;
    index = await currentWorkout
        .collection("Exercises")
        .get()
        .then((value) => value.docs.length);
    await currentWorkout.collection("Exercises").doc(data.id).set({
      ExercisesCollection.id.name: data.id,
      ExercisesCollection.exerciseName.name: data.exerciseName,
      ExercisesCollection.rest.name: data.rest,
      ExercisesCollection.numberOfReps.name: data.numberOfReps,
      ExercisesCollection.numberOfSets.name: data.numberOfSets,
      ExercisesCollection.rpe.name: data.rpe,
      ExercisesCollection.exerciseIndex.name: index + 1,
    });
  }

  deleteExercise(String exerciseId) async {
    final currentWorkout = await getCurrentWorkoutDoc();

    currentWorkout.collection("Exercises").doc(exerciseId).delete();
    notifyListeners();
  }

  updateExercise() {}
  ////
  ///

  Future<QuerySnapshot<Map<String, dynamic>>> getExerciseHistory(
      String exerciseId) async {
    final selectedWorkout = await getCurrentWorkoutDoc();

    final exercsieCollection = selectedWorkout.collection("Exercises");

    final selectedExercise = exercsieCollection.doc(exerciseId);
    final historyOfTheExercise = await selectedExercise
        .collection("ExerciseData")
        .orderBy("date", descending: true)
        .get();
    return historyOfTheExercise;
  }
}
