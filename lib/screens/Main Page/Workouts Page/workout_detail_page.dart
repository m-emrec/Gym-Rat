import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/provider/exercises_provider.dart';
import 'package:gym_rat_v2/screens/Main%20Page/Workouts%20Page/edit_workout_screen.dart';
import 'package:gym_rat_v2/utils/Workouts%20Detail%20Page%20Widgets/empty_exercise_container.dart';
import 'package:provider/provider.dart';

import '../../../utils/Workouts Detail Page Widgets/workout_detail_page_exercise_list.dart';

class WorkoutDetailPage extends StatelessWidget {
  static const routeName = "workout-detail-page";
  const WorkoutDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.height;
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    Provider.of<ExerciseProvider>(context).setCurrentWorkoutId(data["id"]);
    return Scaffold(
      backgroundColor: context.theme.canvasColor,
      appBar: AppBar(
        centerTitle: true,
        leading: TextButton(
          onPressed: () => context.navPop(),
          child: Text(
            "Back",
            style: context.textTheme.labelLarge!.copyWith(
              color: AppColors.kRedCollor,
            ),
          ),
        ),
        title: Text(
          data["name"],
          style: context.textTheme.titleLarge!.copyWith(
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              //* Navigates to @[EditWorkoutScreen]
              Navigator.of(context)
                  .pushNamed(EditWorkoutScreen.routeName, arguments: data);
            },
            child: Text(
              "Edit",
              style: context.textTheme.labelLarge,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.kButtonColor,
        child: Icon(
          Icons.play_arrow,
          color: context.theme.primaryColor,
        ),
      ),
      body: SizedBox(
        // height: height,
        width: width,
        child: Consumer<ExerciseProvider>(
          builder: (context, value, child) => FutureBuilder(
            future: value.getExerciseOfWorkout(
              data["id"],
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.docs.isNotEmpty) {
                  return WorkoutDetailPageExerciseList(
                    exerciseData: snapshot.data!.docs,
                  );
                } else {
                  return const EmptyExerciseContainer();
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
