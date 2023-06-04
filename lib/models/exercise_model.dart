class ExerciseModel {
  final String exerciseName;
  final String id;
  final String? note;
  final int numberOfReps;
  final int numberOfSets;
  final int rest;
  final double rpe;

  ExerciseModel({
    required this.exerciseName,
    required this.id,
    this.note,
    required this.numberOfReps,
    required this.numberOfSets,
    required this.rest,
    required this.rpe,
  });
}
