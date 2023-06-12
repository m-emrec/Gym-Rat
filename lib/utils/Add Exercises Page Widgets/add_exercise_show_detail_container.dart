import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../constants.dart';
import '../../enums/exercises_collection_enum.dart';
import '../../models/exercise_model.dart';
import '../../provider/exercises_provider.dart';
import '../shared/Tile Widgets/exercise_tile.dart';
import 'exercise_instructor_container.dart';
import 'exercises_props_dropdown.dart';

class AddExerciseDetailContainer extends StatelessWidget {
  AddExerciseDetailContainer({
    super.key,
    required this.exerciseData,
    required this.func,
  });
  final Map exerciseData;
  final Function func;
  final TextEditingController _repController = TextEditingController();
  final TextEditingController _setController = TextEditingController();
  final TextEditingController _restController = TextEditingController();
  final TextEditingController _rpeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return AlertDialog(
      elevation: 3,
      scrollable: true,
      insetPadding: EdgeInsets.zero,
      titleTextStyle: Theme.of(context).textTheme.labelLarge,
      title: Column(
        children: [
          // Info Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// Exercise Type
              Text(
                exerciseData[ExerciseApiKeys.type.name],
              ),

              /// Execise Difficulty
              Text(
                exerciseData[ExerciseApiKeys.difficulty.name],
              ),

              /// Exercise Equipment
              Text(
                exerciseData[ExerciseApiKeys.equipment.name],
              ),
            ],
          ),
          const Divider(),
        ],
      ),
      content: SizedBox(
        height: size.height * 0.15,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Instructions of the exercise
              ExerciseInstructionContainer(
                instructions: exerciseData[ExerciseApiKeys.instructions.name],
              ),

              ///
              SizedBox(
                height: size.height * 0.3,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: size.width * 0.2,
                    childAspectRatio: 16 / 6,
                  ),
                  children: [
                    /// Set entry
                    ExercisePropsDropdown(
                      label: "Set",
                      controller: _setController,
                      values: List.generate(10, (index) => index + 1),
                    ),

                    /// Rep enrty
                    ExercisePropsDropdown(
                      label: "Rep",
                      controller: _repController,
                      values: List.generate(20, (index) => index + 1),
                    ),

                    /// Rest Entry
                    ExercisePropsDropdown(
                      label: "Rest",
                      controller: _restController,
                      values: List.generate(20, (index) => (index + 1) * 30),
                      trailing: "sec",
                    ),

                    /// Rpe Entry
                    ExercisePropsDropdown(
                      label: "Rpe",
                      controller: _rpeController,
                      values: List.generate(10, (index) => ((index) / 2) + 5.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        /// Cancel Button
        TextButton(
          onPressed: () => func(),
          style: Theme.of(context).textButtonTheme.style!.copyWith(
                foregroundColor: MaterialStatePropertyAll(AppColors.kRedCollor),
              ),
          child: const Text("Cancel"),
        ),

        /// Add Exercise button.
        TextButton(
          onPressed: () {
            final id = const Uuid().v4();

            Provider.of<ExerciseProvider>(context, listen: false)
                .addExerciseToWorkout(
              ExerciseModel(
                id: id,
                exerciseName: exerciseData[ExerciseApiKeys.name.name],
                numberOfReps: int.parse(_repController.text),
                numberOfSets: int.parse(_setController.text),
                rest: int.parse(_restController.text),
                rpe: double.parse(_rpeController.text),
              ),
            );
            func();
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
