import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/provider/app_states.dart';
import 'package:gym_rat_v2/utils/snackbars.dart';

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
    //TODO: Add Date selection.
    for (var i = 0; i < widget.exercise["numberOfSets"]; i++) {
      _dataRowList.add([]);

      /// Set number 0
      _dataRowList[i].add(
        Text(
          "${i + 1}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.kButtonColor,
          ),
        ),
      );

      /// Rep 1
      _dataRowList[i].add(
        ExercisePropsDropdown(
          label: "Rep",
          controller: TextEditingController(),
          values: List.generate(20, (index) => index + 1),
        ),
      );

      /// Weight 2
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
            final currentFocus = FocusScope.of(context);
            currentFocus.unfocus();
          },
        ),
      );

      /// Rpe 3
      _dataRowList[i].add(
        ExercisePropsDropdown(
          label: "Rpe",
          controller: TextEditingController(),
          values: List.generate(10, (index) => ((index) / 2) + 5.5),
        ),
      );

      ///Date 4
      _dataRowList[i].add(
          IconButton(onPressed: () {}, icon: Icon(Icons.date_range_outlined)));

      /// Note 5
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
    //TODO : After adding dataSelection add a checker which warn the user when he tries to add second data for the same date.
    try {
      for (var row in _dataRowList) {
        final repField = row[2] as ExercisePropsDropdown;
        final weightField = row[3] as TextField;
        final rpeField = row[4] as ExercisePropsDropdown;
        final noteField = row[5] as TextField;

        data.add({
          "rep": int.parse(repField.controller.text),
          "weight": int.parse(weightField.controller!.text),
          "rpe": double.parse(rpeField.controller.text),
          "note": noteField.controller!.text
        });
      }
      final ExerciseData exerciseData = ExerciseData(
        //TODO : Change this one also;
        date: DateTime.now(),
        data: data,
      );
      context.exerciseProv.addExerciseData(
          exerciseId: widget.exercise["id"], data: exerciseData);

      //* Show Saved snack
      ScaffoldMessenger.of(context).showSnackBar(
        Snack(
          context: context,
          label: " Saved !",
          snackType: SnackType.info,
          sDuration: const Duration(seconds: 1),
        ),
      );
      context.appStates.resetState(StateControllers.showAddDataController);
    } on FormatException catch (_) {
      /// if the user leaves some fields blank , show this [Snack]
      ScaffoldMessenger.of(context).showSnackBar(
        Snack(
          context: context,
          label: "You must fill the blank fields !",
          snackType: SnackType.error,
          sDuration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      /// if there is another error then call this.
      logger.e(e);
      ScaffoldMessenger.of(context).showSnackBar(
        Snack(
          context: context,
          label: "An error occuried ! Please try again.",
          snackType: SnackType.error,
        ),
      );
    }
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
                    final dataRow = _dataRowList[index];

                    final dateWidget = dataRow[4];
                    final Text setNumber = dataRow[0] as Text;
                    final ExercisePropsDropdown repWidget =
                        dataRow[1] as ExercisePropsDropdown;
                    final TextField weightWidget = dataRow[2] as TextField;
                    final ExercisePropsDropdown rpeWidget =
                        dataRow[3] as ExercisePropsDropdown;
                    final TextField noteWidget = dataRow[5] as TextField;

                    //* Set the default values for the controllers

                    repWidget.controller.text =
                        widget.exercise["numberOfReps"].toString();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: dateWidget,
                              flex: 1,
                              fit: FlexFit.tight,
                            ),
                            Flexible(child: setNumber, flex: 3),
                            Flexible(child: repWidget, flex: 3),
                            Flexible(child: weightWidget, flex: 3),
                            Flexible(child: rpeWidget, flex: 3),
                          ],
                        ),
                        noteWidget,
                      ],
                    );
                  },
                ),
              ),

              //* Buton Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // *Cancel Button.
                  /// If user taps this. [AddDataContainer] will be closed and [ExerciseistoryTable] will be shown.
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStatePropertyAll(AppColors.kRedCollor),
                    ),
                    onPressed: () => context.appStates.showAddDataContainer(),
                    child: const Text("Cancel"),
                  ),
                  //*Save Button
                  TextButton(
                    onPressed: () {
                      _saveDataToDatabase();
                    },
                    child: const Text("Save"),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
