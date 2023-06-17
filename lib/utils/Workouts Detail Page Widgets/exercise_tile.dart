import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/utils/Add%20Exercises%20Page%20Widgets/exercises_props_dropdown.dart';

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

  bool _isEditing = false;

  void _openExerciseHistory() {
    setState(() {
      _showExerciseHistory = !_showExerciseHistory;
    });
  }

  void _editFeatures() {
    setState(() {
      _isEditing = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var infoRow = Padding(
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
    );
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

                        onTap: () => _editFeatures(),
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
              ///
              subtitle: _isEditing
                  ? EditExerciseTileRow(
                      exercise: widget.exercise,
                    )
                  : infoRow,
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

class EditExerciseTileRow extends StatefulWidget {
  EditExerciseTileRow({super.key, required this.exercise});

  final Map exercise;

  @override
  State<EditExerciseTileRow> createState() => _EditExerciseTileRowState();
}

class _EditExerciseTileRowState extends State<EditExerciseTileRow> {
  int value = 0;
  late final Map exercise;

  final TextEditingController _setController = TextEditingController();
  final TextEditingController _repController = TextEditingController();
  final TextEditingController _restController = TextEditingController();
  final TextEditingController _rpeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    exercise = widget.exercise;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 1,
                child: ExercisePropsDropdown(
                  label: "Set",
                  controller: _setController,
                  values: List.generate(10, (index) => index + 1),
                ),
              ),
              Flexible(
                flex: 1,
                child: ExercisePropsDropdown(
                  label: "Rep",
                  controller: _repController,
                  values: List.generate(20, (index) => index + 1),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: ExercisePropsDropdown(
                  label: "Rest",
                  controller: _restController,
                  values: List.generate(20, (index) => (index + 1) * 30),
                ),
              ),
              Flexible(
                child: ExercisePropsDropdown(
                  label: "Rpe",
                  controller: _rpeController,
                  values: List.generate(10, (index) => ((index) / 2) + 5.5),
                ),
              ),
            ],
          ),
          OutlinedButton(
            onPressed: () =>
                context.exerciseProv.updateExercise(exercise["id"], {
              ExercisesCollection.numberOfReps.name:
                  _repController.text.isEmpty ? null : _repController.text,
              ExercisesCollection.numberOfSets.name:
                  _setController.text.isEmpty ? null : _setController.text,
              ExercisesCollection.rest.name:
                  _restController.text.isEmpty ? null : _restController.text,
              ExercisesCollection.rpe.name:
                  _rpeController.text.isEmpty ? null : _rpeController.text,
            }),
            child: const Text("Done"),
          )
        ],
      ),
    );
  }
}
