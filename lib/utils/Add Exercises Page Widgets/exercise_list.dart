import 'package:flutter/material.dart';
import 'package:gym_rat_v2/logger.dart';

import '../../enums/exercises_collection_enum.dart';
import '../shared/Tile Widgets/exercise_tile.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({
    super.key,
    required this.scrollController,
    required this.exerciseData,
  });

  final ScrollController scrollController;
  final List exerciseData;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemExtent: 80,
        controller: scrollController,
        itemCount: exerciseData.length,
        itemBuilder: (context, index) {
          final Map exercise = exerciseData[index];
          if (index + 1 == exerciseData.length) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ExerciseTile(
            exercise: exercise,
            leading: Text(
              index.toString(),
            ),
          );
        },
      ),
    );
  }
}
