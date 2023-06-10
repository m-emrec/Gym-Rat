class ExerciseModel {
  final String id;
  final String exerciseName;
  final int numberOfReps;
  final int numberOfSets;
  final int rest;
  final double rpe;
  final String muscle;
  final String type;
  final String instructions;

  ExerciseModel({
    required this.instructions,
    required this.id,
    required this.exerciseName,
    required this.numberOfReps,
    required this.numberOfSets,
    required this.rest,
    required this.rpe,
    required this.muscle,
    required this.type,
  });
}