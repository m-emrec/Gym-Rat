import 'package:flutter/material.dart';
import 'package:gym_rat_v2/utils/snackbars.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/provider/app_states.dart';

import '../../constants.dart';
import '../../enums/exercises_collection_enum.dart';
import '../../logger.dart';
import 'edit_exercise_tile_row.dart';
import 'exercise_history_container.dart';

class ExerciseTile extends StatefulWidget {
  const ExerciseTile({
    super.key,
    required this.exercise,
    this.leading,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  final Map exercise;
  final Widget? leading;
  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  bool _showExerciseHistory = false;

  bool _isEditing = false;
  bool _showAddDataContainerController = false;

  void _openExerciseHistory() {
    setState(() {
      _showExerciseHistory = !_showExerciseHistory;
    });
  }

  void _editFeatures() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _showAddDataContainer() {
    setState(() {
      _showAddDataContainerController = true;
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
              leading: widget.leading,

              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///* Exercise Name
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: context.mediaQuerySize.width * 0.5,
                    ),
                    child: Text(
                      widget.exercise[ExercisesCollection.exerciseName.name]
                      // +
                      //     " " +
                      //     "{ Index : " +
                      //     widget.exercise["exerciseIndex"].toString() +
                      // " }"
                      ,
                      overflow: TextOverflow.fade,
                      style: context.textTheme.labelLarge!.copyWith(
                        fontSize: 16,
                        color: AppColors.kTextColor.withOpacity(0.8),
                      ),
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
                    itemBuilder: (ctx) => [
                      /// Add data
                      PopupMenuItem(
                        // height: 10,
                        child: Text(
                          "Add Data",
                          style: context.textTheme.labelLarge!.copyWith(),
                        ),

                        // onTap: () => context.appStates
                        //     .changeState(AppStatesEnum.addExerciseData),
                      ),

                      const PopupMenuItem(height: 10, child: Divider()),

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
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            Snack(
                              snackType: SnackType.warning,
                              context: context,
                              content: const SizedBox(),
                              label:
                                  "Are yo Sure to Delete ${widget.exercise["exerciseName"]}",
                              declineLabel: "No",
                              disposeFunction: () =>
                                  context.exerciseProv.deleteExercise(
                                widget.exercise["id"],
                              ),
                              acceptLabel: "Delete",
                              acceptFunc: () {},
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
              subtitleTextStyle: context.textTheme.labelLarge,

              /// Infos Section
              ///
              subtitle: _isEditing

                  ///* if the user wants to edit the exercise then show @[EditExerciseTileRow]
                  ///* otherwise show @[infoRow]
                  ? EditExerciseTileRow(
                      exercise: widget.exercise,
                      cancelEdit: _editFeatures,
                    )
                  : infoRow,
            ),

            /// Exercise History Container
            Visibility(
              visible: _showExerciseHistory,
              child: ExerciseDataHistory(
                exercise: widget.exercise,
              ),
            )
          ],
        ),
      ),
    );
  }
}
