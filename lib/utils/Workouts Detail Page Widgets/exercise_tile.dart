import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/logger.dart';

import '../../constants.dart';
import '../../enums/exercises_collection_enum.dart';
import 'exercise_history_container.dart';

class ExerciseTile extends StatefulWidget {
  const ExerciseTile({
    super.key,
    required this.exercise,
  });

  final Map exercise;

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  bool _showExerciseHistory = false;

  void _openExerciseHistory() {
    setState(() {
      _showExerciseHistory = !_showExerciseHistory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 3,
        child: Column(
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///* Exercise Name
                  Text(
                    widget.exercise[ExercisesCollection.exerciseName.name],
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
                    color: context.theme.primaryColor,
                    itemBuilder: (context) => [
                      /// Edit
                      PopupMenuItem(
                        // height: 10,
                        child: Text(
                          "Edit",
                          style: context.textTheme.labelLarge!.copyWith(),
                        ),

                        /// Call the Delete function from Exercise Proivder.
                        // onTap: () => context.exerciseProv.deleteExercise(
                        //   widget.exercise["id"],
                        // ),
                      ),

                      /// Divider
                      const PopupMenuItem(height: 10, child: Divider()),

                      /// Delete
                      PopupMenuItem(
                        // height: 10,
                        child: Text(
                          "Delete",
                          style: context.textTheme.labelLarge!.copyWith(
                            color: AppColors.kRedCollor,
                          ),
                        ),

                        /// Call the Delete function from Exercise Proivder.
                        onTap: () => context.exerciseProv.deleteExercise(
                          widget.exercise["id"],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              subtitleTextStyle: context.textTheme.labelLarge,

              /// Infos Section
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///* Set x Rep

                    Text(
                      "${widget.exercise[ExercisesCollection.numberOfSets.name]} x ${widget.exercise[ExercisesCollection.numberOfReps.name]}",
                      style: context.textTheme.labelLarge,
                    ),

                    ///* RPE

                    Text(
                      widget.exercise[ExercisesCollection.rpe.name].toString(),
                      style: context.textTheme.labelLarge,
                    ),

                    ///* Rest
                    Text(
                      "${widget.exercise[ExercisesCollection.rest.name]} sec",
                      style: context.textTheme.labelLarge,
                    ),

                    ///* Show Exercise Data
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        color: AppColors.kButtonColor,
                        iconSize: 32,
                        onPressed: () => _openExerciseHistory(),
                        icon: Icon(_showExerciseHistory
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Exercise History Container
            Visibility(
              visible: _showExerciseHistory,
              child: ExerciseDataHistory(
                exerciseId: widget.exercise["id"],
              ),
            )
          ],
        ),
      ),
    );
  }
}
