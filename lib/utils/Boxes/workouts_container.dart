import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/logger.dart';

import '../Tile Widgets/workout_tile.dart';

/*
  * This widget used to contain Workouts.

*/

class WorkoutsBox extends StatelessWidget {
  const WorkoutsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: constraints.maxHeight,
            child: ListView.separated(
              itemBuilder: (context, index) {
                return WorkoutTile(workoutName: "Workout Name", exercises: [
                  "Exercise 1",
                  "Exercise 2 ",
                  "Exercise 3",
                  "Exercise 4"
                ]);
              },
              separatorBuilder: (context, index) => Divider(
                thickness: 2,
                color: Theme.of(context).primaryColor,
              ),
              itemCount: 4,
            ),
          ),
        );
      },
    );
  }
}
