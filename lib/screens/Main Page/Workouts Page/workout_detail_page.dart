import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/provider/exercises_provider.dart';
import 'package:gym_rat_v2/utils/Workouts%20Detail%20Page%20Widgets/empty_exercise_container.dart';
import 'package:provider/provider.dart';

class WorkoutDetailPage extends StatelessWidget {
  static const routeName = "workout-detail-page";
  const WorkoutDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.height;
    final double height = MediaQuery.of(context).size.height;
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    Provider.of<ExerciseProvider>(context).setCurrentWorkoutId(data["id"]);
    return Scaffold(
        appBar: AppBar(
          leading: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "Back",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: AppColors.kRedCollor,
                  ),
            ),
          ),
          title: Text(
            data["name"],
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 18,
                  color: AppColors.kButtonColor,
                ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: height - 60,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<ExerciseProvider>(
                  builder: (context, value, child) => FutureBuilder(
                    future: value.getExerciseOfWorkout(
                      data["id"],
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data!.docs.isNotEmpty) {
                          return Text("data");
                        } else {
                          return const EmptyExerciseContainer();
                        }
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
