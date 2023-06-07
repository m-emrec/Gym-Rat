import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/enums/workouts_collection_enum.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/provider/cycle_provider.dart';
import 'package:gym_rat_v2/utils/shared/custom_progress_indicator.dart';
import 'package:gym_rat_v2/utils/Workouts%20Page%20Widgets/empty_workout_container.dart';
import 'package:provider/provider.dart';

import '../Tile Widgets/workout_tile.dart';

/*
  * This widget used to contain Workouts.

*/

class WorkoutsBox extends StatefulWidget {
  const WorkoutsBox({super.key});

  @override
  State<WorkoutsBox> createState() => _WorkoutsBoxState();
}

class _WorkoutsBoxState extends State<WorkoutsBox> {
  a() async {
    await Provider.of<CycleProvider>(context).getWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            height: constraints.maxHeight,
            child: FutureBuilder(
              future: Provider.of<CycleProvider>(context).getWorkouts(),
              builder: (context, snapshot) {
                // * if connection is done then show data
                if (snapshot.connectionState == ConnectionState.done) {
                  // if there is data show workouts in list view
                  if (snapshot.hasData) {
                    return ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final workout = snapshot.data!.docs[index];
                        return WorkoutTile(
                          workoutName:
                              workout[WorkoutsCollection.workoutName.name],
                          exercises: [
                            "Exercise 1",
                            "Exercise 2 ",
                            "Exercise 3",
                            "Exercise 4"
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Divider(
                        thickness: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                    // if there is no data then show add cycle box.
                  } else {
                    return EmptyWorkoutContainer();
                  }
                }
                // if connection is loading show circular indicator.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        );
      },
    );
  }
}
