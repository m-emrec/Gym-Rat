import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/extensions/empth_padding_extension.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/provider/exercises_provider.dart';
import 'package:gym_rat_v2/provider/workout_provider.dart';
import 'package:provider/provider.dart';

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

  void getOldData() {
    _setController.value = TextEditingValue(
        text: exercise[ExercisesCollection.numberOfSets.name].toString());
    _repController.value = TextEditingValue(
        text: exercise[ExercisesCollection.numberOfReps.name].toString());
    _rpeController.value = TextEditingValue(
        text: exercise[ExercisesCollection.rpe.name].toString());
    _restController.value = TextEditingValue(
        text: exercise[ExercisesCollection.rest.name].toString());
  }

  @override
  void initState() {
    super.initState();
    exercise = widget.exercise;
    getOldData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              // * Set Dropdown
              Flexible(
                flex: 1,
                child: ExercisePropsDropdown(
                  label: "Set",
                  controller: _setController,
                  values: List.generate(10, (index) => index + 1),
                ),
              ),
              //* Rep Dropdown
              Flexible(
                flex: 1,
                child: ExercisePropsDropdown(
                  label: "Rep",
                  controller: _repController,
                  values: List.generate(20, (index) => index + 1),
                ),
              ),
              //* Rest Dropdown
              Flexible(
                fit: FlexFit.tight,
                child: ExercisePropsDropdown(
                  label: "Rest",
                  controller: _restController,
                  values: List.generate(20, (index) => (index + 1) * 30),
                ),
              ),
              //* Rpe Dropdown
              Flexible(
                child: ExercisePropsDropdown(
                  label: "Rpe",
                  controller: _rpeController,
                  values: List.generate(10, (index) => ((index) / 2) + 5.5),
                ),
              ),
            ],
          ),
          //* Buttons Row
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

              /// Done Button
              Flexible(
                child: OutlinedButton(
                  //* Call updateExercise Func
                  onPressed: () => context.exerciseProv.updateExercise(
                    exercise["id"],
                    {
                      ExercisesCollection.numberOfReps.name:
                          _repController.text.isEmpty
                              ? null
                              : int.parse(_repController.text),
                      ExercisesCollection.numberOfSets.name:
                          _setController.text.isEmpty
                              ? null
                              : int.parse(_setController.text),
                      ExercisesCollection.rest.name:
                          _restController.text.isEmpty
                              ? null
                              : int.parse(_restController.text),
                      ExercisesCollection.rpe.name: _rpeController.text.isEmpty
                          ? null
                          : double.parse(_rpeController.text),
                    },
                  ),
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
