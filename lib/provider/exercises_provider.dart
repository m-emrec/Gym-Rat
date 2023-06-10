// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/provider/workout_provider.dart';
import 'package:http/http.dart' as http;

class ExerciseProvider extends ChangeNotifier {
  static const String API_KEY = "3QiuXduPluL6XSoZaJ/LjA==wu6tKTBupAQ6KLxs";

  late String currentWorkoutId;
  int _exerciseOffset = 0;
  int get exerciseOffset => _exerciseOffset;
  set exerciseOffset(int offset) {
    _exerciseOffset = offset;
    // notifyListeners();
    // logger.i(_exerciseOffset);
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

  Future<List> fetchExerciseData() async {
    final baseUrl = Uri.parse(
        "https://api.api-ninjas.com/v1/exercises?offset=$exerciseOffset");
    final Map<String, String> headers = {'X-Api-Key': API_KEY};
    final response = await http.get(baseUrl, headers: headers);

    if (response.statusCode == 200) {
      _exerciseData += (json.decode(response.body));
      final data = _exerciseData;
      logger.d(_exerciseOffset);
      return await data;
    }
    return [];
  }

  getCurrentWorkout(String id) {
    currentWorkoutId = id;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getExerciseOfWorkout(
      String workoutId) async {
    final userWorkouts = await WorkoutProvider().getUserWorkouts();

    final selectedWorkout = userWorkouts.docs
        .firstWhere((doc) => doc.id == currentWorkoutId)
        .reference;
    final exerciseCollection = selectedWorkout.collection("Exercises");

    return await exerciseCollection.get();
  }

  ////
}
