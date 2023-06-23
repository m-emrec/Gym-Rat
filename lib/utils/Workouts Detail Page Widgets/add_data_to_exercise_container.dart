import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/provider/app_states.dart';
import 'package:gym_rat_v2/utils/snackbars.dart';
import 'package:intl/intl.dart';

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
  final List<List<Map<String, Widget>>> _dataRowList = [];
  final TextEditingController noteController = TextEditingController();
  DateTime? selectedDate;
  /*
    [
      [
        {"set":[Text]},
        {"rpe":[ExercisePropsDropdown]},
        {"rep":[ExercisePropsDropdown]},
      ],
      [],
      [],

    ]
  */

  void _createDataRowList() {
    for (var i = 0; i < widget.exercise["numberOfSets"]; i++) {
      _dataRowList.add([]);
      _dataRowList[i].add(
        {
          //*/Set
          "set": Text(
            "${i + 1}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.kButtonColor,
            ),
          ),
          //*/ Rep
          "rep": ExercisePropsDropdown(
            label: "Rep",
            controller: TextEditingController(),
            values: List.generate(20, (index) => index + 1),
          ),
          //*/ Weight
          "weight": TextField(
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
          //*/ Rpe
          "rpe": ExercisePropsDropdown(
            label: "Rpe",
            controller: TextEditingController(),
            values: List.generate(10, (index) => ((index) / 2) + 5.5),
          ),
        }, //// end of Map
      ); //// end of .add()
    }
  }

  void _saveDataToDatabase() {
    final List<Map> data = [];

    try {
      for (var row in _dataRowList) {
        final ExercisePropsDropdown repField =
            row[0]["rep"] as ExercisePropsDropdown;
        final TextField weightField = row[0]["weight"] as TextField;
        final ExercisePropsDropdown rpeField =
            row[0]["rpe"] as ExercisePropsDropdown;

        data.add({
          "rep": int.parse(repField.controller.text),
          "weight": double.parse(weightField.controller!.text),
          "rpe": double.parse(rpeField.controller.text),
        });
      }
      final ExerciseData exerciseData = ExerciseData(
        date: selectedDate ?? DateTime.now(),
        data: data,
        note: noteController.text,
      );

      /// TODO: Add checker for the date.
      context.exerciseProv.addExerciseData(
          exerciseId: widget.exercise["id"], data: exerciseData);

      context.appStates.resetState(StateControllers.showAddDataController);

      //* Show Saved snack
      ScaffoldMessenger.of(context).showSnackBar(
        Snack(
          context: context,
          label: " Saved !",
          snackType: SnackType.info,
          sDuration: const Duration(seconds: 1),
        ),
      );
    } on FormatException catch (_) {
      logger.e(_);

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

  Future pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2053),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
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
              //* List of inpıut fields
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _dataRowList.length,
                  itemBuilder: (context, index) {
                    //*/ This is row of the set.
                    ///* each row represents one set.
                    final dataRow = _dataRowList[index];

                    //*/ Define the items inside the row.
                    final Text setNumber = dataRow[0]["set"] as Text;
                    final ExercisePropsDropdown repWidget =
                        dataRow[0]["rep"] as ExercisePropsDropdown;
                    final TextField weightWidget =
                        dataRow[0]["weight"] as TextField;
                    final ExercisePropsDropdown rpeWidget =
                        dataRow[0]["rpe"] as ExercisePropsDropdown;

                    //* Set the default values for the controllers

                    repWidget.controller.text =
                        widget.exercise["numberOfReps"].toString();

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
                      ],
                    );
                  },
                ),
              ),
              //* Date Picker and Note
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /// Add Not Button
                  IconButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Note",
                              style: context.textTheme.titleLarge,
                            ),
                            const Divider(),
                          ],
                        ),
                        content: AspectRatio(
                          aspectRatio: 2 / 1,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: context.mediaQuerySize.height * 0.3,
                                  child: TextField(
                                    controller: noteController,
                                    expands: true,
                                    maxLines: null,
                                    minLines: null,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          ///* Cancel button
                          OutlinedButton(
                            style: context.theme.outlinedButtonTheme.style!
                                .copyWith(
                              fixedSize: MaterialStatePropertyAll(
                                Size.fromWidth(
                                    context.mediaQuerySize.width * 0.3),
                              ),
                            ),
                            onPressed: () {
                              noteController.clear();
                              context.navPop();
                            },
                            child: Text(
                              "Cancel",
                              style: context.textTheme.labelLarge!
                                  .copyWith(color: AppColors.kRedCollor),
                            ),
                          ),

                          ///* Done Button
                          OutlinedButton(
                            style: context.theme.outlinedButtonTheme.style!
                                .copyWith(
                              fixedSize: MaterialStatePropertyAll(
                                Size.fromWidth(
                                    context.mediaQuerySize.width * 0.3),
                              ),
                            ),
                            onPressed: () => context.navPop(),
                            child: Text(
                              "Done",
                              style: context.textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    icon: const Icon(
                      Icons.note_add_outlined,
                      color: AppColors.kButtonColor,
                    ),
                  ),

                  /// Select Date button
                  Column(
                    children: [
                      IconButton(
                        onPressed: () => pickDate(),
                        icon: const Icon(Icons.date_range_outlined,
                            color: AppColors.kButtonColor),
                      ),
                      Text(
                        selectedDate == null
                            ? DateFormat.MMMMd().format(DateTime.now())
                            : DateFormat.MMMMd().format(selectedDate!),
                        style: context.textTheme.labelLarge,
                      )
                    ],
                  ),
                ],
              ),
              //* Cancel and Save buttons
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
