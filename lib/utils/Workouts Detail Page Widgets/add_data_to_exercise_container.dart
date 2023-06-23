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
  final List<List<Map<String, Widget>>> _dataRowList = [];

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
    //TODO: Add Date selection.
    for (var i = 0; i < widget.exercise["numberOfSets"]; i++) {
      _dataRowList.add([]);
      final TextEditingController _noteController = TextEditingController();
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

          ///* NOTE
          "note": TextField(
            decoration: const InputDecoration(
              icon: Icon(
                Icons.sticky_note_2_outlined,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            controller: _noteController,
            textCapitalization: TextCapitalization.sentences,
          ),

          "note2": IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Note",
                        style: context.textTheme.titleLarge,
                      ),
                      const Divider()
                    ],
                  ),
                  actions: [
                    //*/ Cancel Button
                    OutlinedButton(
                      style: context.theme.outlinedButtonTheme.style!.copyWith(
                        fixedSize: MaterialStatePropertyAll(
                          Size.fromWidth(context.mediaQuerySize.width * 0.3),
                        ),
                      ),
                      onPressed: () {
                        _noteController.clear();
                        context.navPop();
                      },
                      child: Text(
                        "Cancel",
                        style: context.textTheme.labelLarge!
                            .copyWith(color: AppColors.kRedCollor),
                      ),
                    ),
                    //*/ Done Button
                    OutlinedButton(
                      style: context.theme.outlinedButtonTheme.style!.copyWith(
                        fixedSize: MaterialStatePropertyAll(
                          Size.fromWidth(context.mediaQuerySize.width * 0.3),
                        ),
                      ),
                      onPressed: () => context.navPop(),
                      child: Text("Done", style: context.textTheme.labelLarge),
                    ),
                  ],
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AspectRatio(
                          aspectRatio: 2 / 1,
                          child: TextField(
                            controller: _noteController,
                            maxLines: null,
                            minLines: null,
                            expands: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.sticky_note_2_outlined,
            ),
          ),
        }, //// end of Map
      ); //// end of .add()
    }
  }

  void _saveDataToDatabase() {
    final List<Map> data = [];
    //TODO : After adding dataSelection add a checker which warn the user when he tries to add second data for the same date.
    try {
      for (var row in _dataRowList) {
        final repField = row[1] as ExercisePropsDropdown;
        final weightField = row[2] as TextField;
        final rpeField = row[3] as ExercisePropsDropdown;
        final noteField = row[4] as TextField;

        data.add({
          "rep": int.parse(repField.controller.text),
          "weight": double.parse(weightField.controller!.text),
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
                    final TextField noteField = dataRow[0]["note"] as TextField;
                    final IconButton noteWidget =
                        dataRow[0]["note2"] as IconButton;

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
