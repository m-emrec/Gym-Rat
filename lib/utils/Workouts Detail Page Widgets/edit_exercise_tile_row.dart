import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/extensions/empth_padding_extension.dart';

import '../../enums/exercises_collection_enum.dart';
import '../Add Exercises Page Widgets/exercises_props_dropdown.dart';

class EditExerciseTileRow extends StatefulWidget {
  EditExerciseTileRow(
      {super.key, required this.exercise, required this.cancelEdit});

  final Map exercise;
  final Function cancelEdit;
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
          Row(
            children: [
              /// Cancel Button
              Flexible(
                child: OutlinedButton(
                  style: context.theme.outlinedButtonTheme.style!.copyWith(
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.kRedCollor),
                    foregroundColor:
                        const MaterialStatePropertyAll(AppColors.kCanvasColor),
                  ),
                  onPressed: () => widget.cancelEdit(),
                  child: const Text("Cancel"),
                ),
              ),
              8.pw(),

              /// Done Butto
              Flexible(
                child: OutlinedButton(
                  onPressed: () =>
                      context.exerciseProv.updateExercise(exercise["id"], {
                    ExercisesCollection.numberOfReps.name:
                        _repController.text.isEmpty
                            ? null
                            : _repController.text,
                    ExercisesCollection.numberOfSets.name:
                        _setController.text.isEmpty
                            ? null
                            : _setController.text,
                    ExercisesCollection.rest.name: _restController.text.isEmpty
                        ? null
                        : _restController.text,
                    ExercisesCollection.rpe.name: _rpeController.text.isEmpty
                        ? null
                        : _rpeController.text,
                  }),
                  child: const Text("Done"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
