import 'package:flutter/material.dart';
import 'package:gym_rat_v2/logger.dart';

import '../../enums/exercises_collection_enum.dart';
import '../shared/Tile Widgets/exercise_tile.dart';

class ExerciseList extends StatefulWidget {
  const ExerciseList({
    super.key,
    required this.scrollController,
    required this.exerciseData,
  });

  final ScrollController scrollController;
  final List exerciseData;

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  bool _isExtended = false;

  void _changeItemExtent() {
    setState(() {
      _isExtended = !_isExtended;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: widget.scrollController,
        itemCount: widget.exerciseData.length,
        itemBuilder: (context, index) {
          final Map exercise = widget.exerciseData[index];
          if (index + 1 == widget.exerciseData.length) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return ExerciseTile(
            exercise: exercise,
            leading: Text(
              index.toString(),
            ),
            changeItemExtent: _changeItemExtent,
          );
        },
      ),
    );
  }
}
