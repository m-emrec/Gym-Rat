import 'package:flutter/material.dart';
import 'package:gym_rat_v2/models/exercise_model.dart';
import 'package:gym_rat_v2/provider/exercises_provider.dart';
import 'package:provider/provider.dart';

import '../../../enums/exercises_collection_enum.dart';

class ExerciseTile extends StatelessWidget {
  ExerciseTile({
    super.key,
    required this.leading,
    required this.exercise,
  });

  final Widget leading;
  final Map exercise;
  late String muscle;

  /// This getter turns the first letter of the muscle name to capital letter.
  String get muscleName {
    String firstLetter = muscle[0].toUpperCase();
    String name = muscle.replaceRange(0, 1, firstLetter);
    return name;
  }

  // ExerciseModel get _collectData {
  //   final data = ExerciseModel(
  //     instructions: exercise[ExerciseApiKeys.instructions.name],
  //     id: "id",
  //     exerciseName:exercise[ExerciseApiKeys.name.name] ,
  //     numberOfReps: exercise[ExerciseApiKeys] ,
  //     numberOfSets: numberOfSets,
  //     rest: rest,
  //     rpe: rpe,
  //     muscle: muscle,
  //     type: type,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final String title = exercise[ExerciseApiKeys.name.name];
    muscle = exercise[ExerciseApiKeys.muscle.name];
    //add exercise to workout
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14),
      ),
      trailing: GestureDetector(
        // onTap: () => Provider.of<ExerciseProvider>(context).addExerciseToWorkout(),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: const IconButton(
            onPressed: null,
            icon: Icon(Icons.add),
          ),
        ),
      ),
      subtitle: Text(
        muscleName,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      isThreeLine: true,
    );
  }
}
