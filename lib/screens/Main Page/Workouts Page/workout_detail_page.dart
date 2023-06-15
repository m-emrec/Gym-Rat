import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/enums/exercises_collection_enum.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/provider/exercises_provider.dart';
import 'package:gym_rat_v2/screens/Exercise%20Screens.dart/add_exercise_to_workout_page.dart';
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
      backgroundColor: context.theme.canvasColor,
      appBar: AppBar(
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
            color: AppColors.kButtonColor,
          ),
        ),
        centerTitle: true,
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
        height: height,
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
                      return Expanded(
                        child: WorkoutDetailPageExerciseList(
                          exerciseData: snapshot.data!.docs,
                        ),
                      );
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
    );
  }
}

class WorkoutDetailPageExerciseList extends StatelessWidget {
  const WorkoutDetailPageExerciseList({
    super.key,
    required this.exerciseData,
  });
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> exerciseData;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: exerciseData.length,
              itemBuilder: (context, index) {
                final Map exercise = exerciseData[index].data();
                return ExerciseTile(exercise: exercise);
              },
            ),
            OutlinedButton(
              onPressed: () => context.navPushNamed(
                AddExerciseToWorkoutPage.routeName,
              ),
              child: const Text("Add Exercise"),
            )
          ],
        ),
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    super.key,
    required this.exercise,
  });

  final Map exercise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        elevation: 5,
        shadowColor: context.theme.primaryColor,
        child: ListTile(
          shape: BorderDirectional(
            bottom: BorderSide(
              color: context.theme.primaryColor,
              width: 3,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///* Exercise Name
              Text(
                exercise[ExercisesCollection.exerciseName.name],
                style: context.textTheme.labelLarge!.copyWith(
                  fontSize: 16,
                  color: AppColors.kTextColor.withOpacity(0.8),
                ),
              ),

              ///* Settings buttons
              PopupMenuButton(
                position: PopupMenuPosition.under,
                icon: const Icon(
                  Icons.more_horiz,
                  color: AppColors.kButtonColor,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: AppColors.kRedCollor,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(
                      "Delete",
                      style: context.textTheme.labelLarge!
                          .copyWith(color: context.theme.canvasColor),
                    ),

                    /// Call the Delete function from Exercise Proivder.
                    onTap: () => context.exerciseProv.deleteExercise(
                      exercise["id"],
                    ),
                  ),
                ],
              )
            ],
          ),
          subtitleTextStyle: context.textTheme.labelLarge,

          /// Infos Section
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///* Set x Rep

                Text(
                  "${exercise[ExercisesCollection.numberOfSets.name]} x ${exercise[ExercisesCollection.numberOfReps.name]}",
                  style: context.textTheme.labelLarge,
                ),

                ///* RPE

                Text(
                  exercise[ExercisesCollection.rpe.name].toString(),
                  style: context.textTheme.labelLarge,
                ),

                ///* Rest
                Text(
                  "${exercise[ExercisesCollection.rest.name]} sec",
                  style: context.textTheme.labelLarge,
                ),

                ///* Show Exercise Data
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    color: AppColors.kButtonColor,
                    iconSize: 32,
                    onPressed: () {},
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
