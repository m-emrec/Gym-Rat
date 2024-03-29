// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/enums/exercises_collection_enum.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/models/exercise_data_model.dart';
import 'package:gym_rat_v2/models/exercise_model.dart';
import 'package:gym_rat_v2/provider/workout_provider.dart';
import 'package:gym_rat_v2/utils/shared/custom_progress_indicator.dart';
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
    _addExerciseToWorkoutList.clear();
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
  ///
  ///
  final List<ExerciseModel> _addExerciseToWorkoutList = [];
  addExerciseToList(ExerciseModel model) {
    _addExerciseToWorkoutList.add(model);
    logger.i(_addExerciseToWorkoutList);
  }

  addExerciseToWorkout() async {
    logger.wtf("message");
    final currentWorkout = await getCurrentWorkoutDoc();
    int index;
    logger.e("1");
    try {
      index = await currentWorkout
          .collection("Exercises")
          .orderBy("exerciseIndex")
          .get()
          .then((value) => value.docs.last["exerciseIndex"]);
    } catch (e) {
      index = 0;
    }

    logger.e("2");

    for (var data in _addExerciseToWorkoutList) {
      index++;
      logger.d(data);
      await currentWorkout.collection("Exercises").doc(data.id).set({
        ExercisesCollection.id.name: data.id,
        ExercisesCollection.exerciseName.name: data.exerciseName,
        ExercisesCollection.rest.name: data.rest,
        ExercisesCollection.numberOfReps.name: data.numberOfReps,
        ExercisesCollection.numberOfSets.name: data.numberOfSets,
        ExercisesCollection.rpe.name: data.rpe,
        ExercisesCollection.exerciseIndex.name: index,
      });
    }
    notifyListeners();
  }

  deleteExercise(String exerciseId) async {
    final currentWorkout = await getCurrentWorkoutDoc();

    currentWorkout.collection("Exercises").doc(exerciseId).delete();
    notifyListeners();
  }

  updateExercise(String exerciseId, Map data) async {
    final currentWorkout = await getCurrentWorkoutDoc();

    final DocumentReference<Map<String, dynamic>> selectedExercise =
        currentWorkout.collection("Exercises").doc(exerciseId);

    final oldDataGet = await selectedExercise.get();
    final Map<String, dynamic> oldData = oldDataGet.data()!;
    selectedExercise.update({
      ExercisesCollection.id.name: oldData["id"],
      ExercisesCollection.exerciseIndex.name:
          oldData[ExercisesCollection.exerciseIndex.name],
      ExercisesCollection.exerciseName.name:
          oldData[ExercisesCollection.exerciseName.name],
      ExercisesCollection.note.name: oldData[ExercisesCollection.note.name],
      ExercisesCollection.numberOfReps.name:
          data[ExercisesCollection.numberOfReps.name] ??
              oldData[ExercisesCollection.numberOfReps.name],
      ExercisesCollection.numberOfSets.name:
          data[ExercisesCollection.numberOfSets.name] ??
              oldData[ExercisesCollection.numberOfSets.name],
      ExercisesCollection.rest.name: data[ExercisesCollection.rest.name] ??
          oldData[ExercisesCollection.rest.name],
      ExercisesCollection.rpe.name: data[ExercisesCollection.rpe.name] ??
          oldData[ExercisesCollection.rpe.name]
    });

    notifyListeners();
  }

  final List<Map> _reorderList = [
    /*
    
    {
      "id": ExerciseId,
      "newIndex" : exerciseIndex,
    },
    {
      "id": ExerciseId,
      "newIndex" : exerciseIndex,
    },
    ...
    */
  ];
  updateWorkoutExerciseOrder(
      {required String movingItemId,
      required String id2,
      required bool goingUp,
      required int newIndex,
      required int oldIndex}) async {
    _reorderList.clear();
    final currentWorkout = await getCurrentWorkoutDoc();

    final List<QueryDocumentSnapshot<Map<String, dynamic>>> exerciseDocs =
        await currentWorkout
            .collection("Exercises")
            .orderBy("exerciseIndex")
            .get()
            .then((value) => value.docs);

    final DocumentReference<Map<String, dynamic>> selectedExercise =
        currentWorkout.collection("Exercises").doc(movingItemId);
    final DocumentReference<Map<String, dynamic>> exercise2 =
        currentWorkout.collection("Exercises").doc(id2);
    final exercise2Data = await exercise2.get();
    if (goingUp) {
      for (var i = 0; i < exerciseDocs.length; i++) {
        _reorderList.add({
          "id": selectedExercise.id,
          "newIndex": exercise2Data["exerciseIndex"],
        });
        if (i < oldIndex && i >= newIndex) {
          _reorderList.add({
            "id": exerciseDocs[i].reference.id,
            "newIndex": exerciseDocs[i].data()["exerciseIndex"] + 1,
          });
        }
      }
    } else {
      _reorderList.add({
        "id": selectedExercise.id,
        "newIndex": exercise2Data["exerciseIndex"],
      });
      for (var i = 0; i < exerciseDocs.length; i++) {
        if (i > oldIndex && i <= newIndex) {
          _reorderList.add({
            "id": exerciseDocs[i].reference.id,
            "newIndex": exerciseDocs[i].data()["exerciseIndex"] - 1,
          });
        }
      }
    }
  }

  Future comleteUpdateWorkoutExerciseOrder() async {
    final currentWorkout = await getCurrentWorkoutDoc();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> exerciseDocs =
        await currentWorkout
            .collection("Exercises")
            .orderBy("exerciseIndex")
            .get()
            .then((value) => value.docs);
    for (var i = 0; i < _reorderList.length; i++) {
      try {
        await currentWorkout
            .collection("Exercises")
            .doc(_reorderList[i]["id"])
            .update({"exerciseIndex": _reorderList[i]["newIndex"]});
      } catch (e) {}
    }
    notifyListeners();
  }

  ////

  /// *  Exercise History Features

  ///Gets the selected Exercise's data history.
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

  addExerciseData(
      {required String exerciseId, required ExerciseData data}) async {
    final selectedWorkout = await getCurrentWorkoutDoc();

    final exercsieCollection = selectedWorkout.collection("Exercises");

    final selectedExercise = exercsieCollection.doc(exerciseId);
    var itemLength = await selectedExercise
        .collection("ExerciseData")
        .doc(data.date.toString())
        .get();
    if (itemLength.data() != null) {
      logger.wtf("message");
      return true;
    } else {
      // logger.i(data);
      selectedExercise
          .collection("ExerciseData")
          .doc(data.date.toString())
          .set({
        "date": data.date,
        "note": data.note,
        "data": data.data,
      }).onError((error, stackTrace) => logger.e(error));
    }
  }

////
}
