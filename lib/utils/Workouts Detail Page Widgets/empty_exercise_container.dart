import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/empth_padding_extension.dart';
import 'package:gym_rat_v2/screens/Exercise%20Screens.dart/add_exercise_to_workout_page.dart';

class EmptyExerciseContainer extends StatelessWidget {
  const EmptyExerciseContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "You don't have any exercise.\nLet's add some",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontSize: 16),
            ),
            16.ph(),
            OutlinedButton(
              onPressed: () => Navigator.of(context)
                  .pushNamed(AddExerciseToWorkoutPage.routeName),
              child: Text("Add Exercise"),
              style: ButtonStyle().copyWith(
                fixedSize: MaterialStatePropertyAll(
                  Size.fromWidth(width * 0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
