import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/models/exercise_model.dart';
import 'package:gym_rat_v2/provider/exercises_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../enums/exercises_collection_enum.dart';

class ExerciseTile extends StatefulWidget {
  const ExerciseTile({
    super.key,
    required this.leading,
    required this.exercise,
  });

  final Widget leading;
  final Map exercise;

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  late String muscle;

  bool _showAddExerciseContainer = false;

  /// This getter turns the first letter of the muscle name to capital letter.
  String get muscleName {
    String firstLetter = muscle[0].toUpperCase();
    String name = muscle.replaceRange(0, 1, firstLetter);
    return name;
  }

  // ExerciseModel get _collectData {
  @override
  Widget build(BuildContext context) {
    final String title = widget.exercise[ExerciseApiKeys.name.name];
    muscle = widget.exercise[ExerciseApiKeys.muscle.name];
    //add exercise to workout
    return Column(
      children: [
        ListTile(
          leading: widget.leading,
          title: Text(
            title,
            style:
                Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14),
          ),
          trailing: GestureDetector(
            onTap: () => setState(() {
              _showAddExerciseContainer = !_showAddExerciseContainer;
            }),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: IconButton(
                onPressed: null,
                icon: _showAddExerciseContainer
                    ? const Icon(Icons.minimize)
                    : const Icon(Icons.add),
              ),
            ),
          ),
          subtitle: Text(
            muscleName,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          isThreeLine: true,
        ),
        Visibility(
          visible: _showAddExerciseContainer,
          child: AddExerciseDetailContainer(
            exerciseData: widget.exercise,
          ),
        ),
      ],
    );
  }
}

class AddExerciseDetailContainer extends StatelessWidget {
  AddExerciseDetailContainer({super.key, required this.exerciseData});
  final Map exerciseData;
  final TextEditingController _repController = TextEditingController();
  final TextEditingController _setController = TextEditingController();
  final TextEditingController _restController = TextEditingController();
  final TextEditingController _rpeController = TextEditingController();

  void _addDataToDatabase() {}

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                exerciseData[ExerciseApiKeys.type.name],
              ),
              Text(
                exerciseData[ExerciseApiKeys.difficulty.name],
              ),
              Text(
                exerciseData[ExerciseApiKeys.equipment.name],
              ),
            ],
          ),
          const Divider(),
        ],
      ),
      content: SizedBox(
        height: size.height * 0.3,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ExerciseInstructionContainer(
                instructions: exerciseData[ExerciseApiKeys.instructions.name],
              ),
              ExercisePropsDropdown(
                label: "Set",
                controller: _setController,
                values: List.generate(10, (index) => index + 1),
              ),
              ExercisePropsDropdown(
                label: "Rep",
                controller: _repController,
                values: List.generate(20, (index) => index + 1),
              ),
              ExercisePropsDropdown(
                label: "Rest",
                controller: _restController,
                values: List.generate(20, (index) => (index + 1) * 30),
                trailing: "sec",
              ),
              ExercisePropsDropdown(
                label: "RPE",
                controller: _rpeController,
                values: List.generate(10, (index) => (index / 2) + 5.5),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // logger.i(controller.text);
            final id = const Uuid().v4();

            Provider.of<ExerciseProvider>(context, listen: false)
                .addExerciseToWorkout(ExerciseModel(
              id: id,
              exerciseName: exerciseData[ExerciseApiKeys.name.name],
              numberOfReps: int.parse(_repController.text),
              numberOfSets: int.parse(_setController.text),
              rest: int.parse(_restController.text),
              rpe: double.parse(_rpeController.text),
            ));
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}

class ExercisePropsDropdown extends StatefulWidget {
  const ExercisePropsDropdown({
    super.key,
    required this.label,
    required this.controller,
    required this.values,
    this.trailing,
  });
  final String label;
  final String? trailing;
  final TextEditingController controller;
  final List values;
  @override
  State<ExercisePropsDropdown> createState() => _ExercisePropsDropdownState();
}

class _ExercisePropsDropdownState extends State<ExercisePropsDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownMenu(
        trailingIcon: Text(
          widget.trailing ?? "",
          style: Theme.of(context).textTheme.labelSmall,
        ),
        controller: widget.controller,
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        menuStyle: const MenuStyle(
          maximumSize: MaterialStatePropertyAll(
            Size.fromHeight(150),
          ),
        ),
        label: Text(widget.label),
        dropdownMenuEntries: [
          ...widget.values.map(
            (e) => DropdownMenuEntry(value: e.toString(), label: e.toString()),
          ),
        ],
      ),
    );
  }
}

class ExerciseInstructionContainer extends StatefulWidget {
  const ExerciseInstructionContainer({super.key, required this.instructions});
  final String instructions;

  @override
  State<ExerciseInstructionContainer> createState() =>
      _ExerciseInstructionContainerState();
}

class _ExerciseInstructionContainerState
    extends State<ExerciseInstructionContainer> {
  bool _showText = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() {
            _showText = !_showText;
          }),
          child: Row(
            children: [
              _showText
                  ? const Icon(
                      Icons.arrow_drop_up_sharp,
                      color: AppColors.kButtonColor,
                    )
                  : const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: AppColors.kButtonColor,
                    ),
              Align(
                child: Text(
                  "Show Instructions",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: _showText,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.instructions,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ),
      ],
    );
  }
}
