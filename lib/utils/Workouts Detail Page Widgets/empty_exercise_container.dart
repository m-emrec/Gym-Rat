import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/empth_padding_extension.dart';
import 'package:gym_rat_v2/screens/Exercise%20Screens.dart/add_exercise_to_workout_page.dart';

class EmptyExerciseContainer extends StatelessWidget {
  const EmptyExerciseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "You don't have any exercise.\nLet's add some",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16),
        ),
        16.ph(),
        OutlinedButton(
          onPressed: () => Navigator.of(context)
              .pushNamed(AddExerciseToWorkoutPage.routeName),
          style: const ButtonStyle().copyWith(
            fixedSize: MaterialStatePropertyAll(
              Size.fromWidth(width * 0.6),
            ),
          ),
          child: const Text("Add Exercise"),
        ),
      ],
    );
  }
}
