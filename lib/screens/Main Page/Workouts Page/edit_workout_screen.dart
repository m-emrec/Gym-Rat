import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/screens/Main%20Page/Workouts%20Page/workout_detail_page.dart';
import 'package:gym_rat_v2/utils/Workouts%20Detail%20Page%20Widgets/exercise_tile.dart';
import 'package:provider/provider.dart';

import '../../../enums/workouts_collection_enum.dart';
import '../../../provider/exercises_provider.dart';
import '../../../utils/Workouts Detail Page Widgets/empty_exercise_container.dart';
import '../../../utils/Workouts Detail Page Widgets/workout_detail_page_exercise_list.dart';

class EditWorkoutScreen extends StatelessWidget {
  const EditWorkoutScreen({super.key});

  static const routeName = "edit-workout-screen";

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: TextButton(
          onPressed: () => context.navPop(),
          child: Text(
            "Cancel",
            style: context.textTheme.labelLarge!.copyWith(
              color: AppColors.kRedCollor,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          data["name"],
          style: context.textTheme.titleLarge!.copyWith(
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).popAndPushNamed(
              WorkoutDetailPage.routeName,
              arguments: {
                "name": data["name"],
                "id": data["id"],
              },
            ),
            child: Text(
              "Done",
              style: context.textTheme.labelLarge,
            ),
          ),
        ],
      ),
      body: SizedBox(
        // height: height,
        width: context.mediaQuerySize.width,
        child: Consumer<ExerciseProvider>(
          builder: (context, value, child) => FutureBuilder(
            future: value.getExerciseOfWorkout(
              data["id"],
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.docs.isNotEmpty) {
                  return EditWorkoutDetailPageList(
                    exerciseData: snapshot.data!.docs,
                  );

                  // WorkoutDetailPageExerciseList(
                  //   exerciseData: snapshot.data!.docs,
                  // );
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

class EditWorkoutDetailPageList extends StatefulWidget {
  const EditWorkoutDetailPageList({super.key, required this.exerciseData});
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> exerciseData;

  @override
  State<EditWorkoutDetailPageList> createState() =>
      _EditWorkoutDetailPageListState();
}

class _EditWorkoutDetailPageListState extends State<EditWorkoutDetailPageList> {
  late final List<QueryDocumentSnapshot<Map<String, dynamic>>> exerciseData;

  @override
  void initState() {
    super.initState();
    exerciseData = widget.exerciseData;
  }

  Map selectedExercise = {};
  Map newExercise = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ReorderableListView.builder(
        itemCount: exerciseData.length,
        itemBuilder: (context, index) {
          return ExerciseTile(
            key: ValueKey(index),
            leading: const Icon(Icons.reorder_outlined),
            exercise: widget.exerciseData[index].data(),
          );
        },
        onReorder: (oldIndex, newIndex) {
          late bool goingUp;
          setState(() {
            if (newIndex > oldIndex) newIndex -= 1;

            selectedExercise = exerciseData[oldIndex].data();
            newExercise = exerciseData[newIndex].data();

            final item = exerciseData.removeAt(oldIndex);
            exerciseData.insert(newIndex, item);
            if (newIndex > oldIndex) {
              goingUp = false;
            } else if (newIndex < oldIndex) {
              goingUp = true;
            }
            context.exerciseProv.updateWorkoutExerciseOrder(
              movingItemId: selectedExercise["id"],
              id2: newExercise["id"],
              goingUp: goingUp,
              oldIndex: oldIndex,
              newIndex: newIndex,
            );
          });
        },
      ),
    );
  }
}

/*
if(i < oldIndex and i > newIndex) nothing
*/
