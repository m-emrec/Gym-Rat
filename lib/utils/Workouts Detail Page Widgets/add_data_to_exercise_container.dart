import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/logger.dart';

import '../../models/exercise_data_model.dart';
import '../Add Exercises Page Widgets/exercises_props_dropdown.dart';

class AddDataToExerciseContainer extends StatefulWidget {
  const AddDataToExerciseContainer({super.key, required this.exercise});

  final Map exercise;

  @override
  State<AddDataToExerciseContainer> createState() =>
      _AddDataToExerciseContainerState();
}

class _AddDataToExerciseContainerState
    extends State<AddDataToExerciseContainer> {
  final List<List<Widget>> _dataRowList = [];

  void _createDataRowList() {
    for (var i = 0; i < widget.exercise["numberOfSets"]; i++) {
      _dataRowList.add([]);

      /// Set number
      _dataRowList[i].add(
        Text(
          "${i + 1}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.kButtonColor,
          ),
        ),
      );

      /// Rep
      _dataRowList[i].add(
        ExercisePropsDropdown(
          label: "Rep",
          controller: TextEditingController(),
          values: List.generate(20, (index) => index + 1),
        ),
      );

      /// Weight
      _dataRowList[i].add(
        TextField(
          decoration: const InputDecoration(
            label: FittedBox(fit: BoxFit.contain, child: Text("Weight")),
            suffixText: "Kg",
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          keyboardType: TextInputType.number,
          controller: TextEditingController(),
          onTapOutside: (event) {
            // logger.i(event);
            // final currentFocus = FocusScope.of(context);
            // currentFocus.unfocus();
          },
        ),
      );

      /// Rpe
      _dataRowList[i].add(
        ExercisePropsDropdown(
          label: "Rpe",
          controller: TextEditingController(),
          values: List.generate(10, (index) => ((index) / 2) + 5.5),
        ),
      );

      /// Note
      _dataRowList[i].add(
        TextField(
          decoration: const InputDecoration(
            icon: Icon(
              Icons.sticky_note_2_outlined,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          controller: TextEditingController(),
          textCapitalization: TextCapitalization.sentences,
        ),
      );
    }
  }

  void _saveDataToDatabase() {
    final List<Map> data = [];

    for (var row in _dataRowList) {
      final repField = row[1] as ExercisePropsDropdown;
      final weightField = row[2] as TextField;
      final rpeField = row[3] as ExercisePropsDropdown;
      final noteField = row[4] as TextField;
      data.add({
        "rep": int.parse(repField.controller.text),
        "weight": int.parse(weightField.controller!.text),
        "rpe": double.parse(rpeField.controller.text),
        "note": noteField.controller!.text
      });
    }
    final ExerciseData exerciseData = ExerciseData(
      date: DateTime.now(),
      data: data,
    );
    context.exerciseProv
        .addExerciseData(exerciseId: widget.exercise["id"], data: exerciseData);
  }

  @override
  void initState() {
    super.initState();
    _createDataRowList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _dataRowList.length,
                  itemBuilder: (context, index) {
                    // logger.d(index);

                    final dataRow = _dataRowList[index];
                    final Text setNumber = dataRow[0] as Text;
                    final ExercisePropsDropdown repWidget =
                        dataRow[1] as ExercisePropsDropdown;
                    final TextField weightWidget = dataRow[2] as TextField;
                    final ExercisePropsDropdown rpeWidget =
                        dataRow[3] as ExercisePropsDropdown;
                    final TextField noteWidget = dataRow[4] as TextField;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(child: setNumber),
                            Flexible(child: repWidget),
                            Flexible(child: weightWidget),
                            Flexible(child: rpeWidget),
                          ],
                        ),
                        noteWidget,
                      ],
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: () =>
                    logger.wtf(_dataRowList.length), //_saveDataToDatabase(),
                child: const Text("Save"),
              )
            ],
          ),
        );
      },
    );
  }
}
