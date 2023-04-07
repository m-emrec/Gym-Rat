import 'package:gym_rat_v2/models/exercises_model.dart';

class WorkoutModel {
  final String name;
  final List<Exercises> exerciseList;
  WorkoutModel({
    required this.name,
    required this.exerciseList,
  });
}
