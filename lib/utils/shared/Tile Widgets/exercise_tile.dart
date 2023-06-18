import 'package:flutter/material.dart';
import 'package:gym_rat_v2/logger.dart';

import '../../../enums/exercises_collection_enum.dart';
import '../../Add Exercises Page Widgets/add_exercise_show_detail_container.dart';

class ExerciseTile extends StatefulWidget {
  const ExerciseTile({
    super.key,
    required this.leading,
    required this.exercise,
    required this.changeItemExtent,
  });

  final Widget leading;
  final Map exercise;
  final Function changeItemExtent;
  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  late String muscle;

  bool _showAddExerciseContainer = false;

  void _showAddExerciseBox() {
    setState(() {
      _showAddExerciseContainer = !_showAddExerciseContainer;
    });
    widget.changeItemExtent();
  }

  /// This getter turns the first letter of the muscle name to capital letter.
  String get muscleName {
    String firstLetter = muscle[0].toUpperCase();
    String name = muscle.replaceRange(0, 1, firstLetter);
    return name;
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.exercise[ExerciseApiKeys.name.name];
    muscle = widget.exercise[ExerciseApiKeys.muscle.name];
    return Column(
      children: [
        ListTile(
          // leading: widget.leading,
          title: Text(
            title,
            style:
                Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14),
          ),
          trailing: GestureDetector(
            onTap: () => _showAddExerciseBox(),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: IconButton(
                onPressed: null,
                icon: _showAddExerciseContainer
                    ? const Icon(Icons.remove)
                    : const Icon(Icons.add),
              ),
            ),
          ),
          subtitle: Text(
            muscleName,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          // isThreeLine: true,
        ),
        Visibility(
          visible: _showAddExerciseContainer,
          child: AddExerciseDetailContainer(
            exerciseData: widget.exercise,
            func: _showAddExerciseBox,
          ),
        ),
      ],
    );
  }
}
