import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';

import 'exercise_history_table.dart';

class ExerciseDataHistory extends StatelessWidget {
  const ExerciseDataHistory({
    super.key,
    required this.exerciseId,
  });

  final String exerciseId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 3, color: context.theme.primaryColor),
        ),
      ),
      height: 250,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: FutureBuilder(
          future: context.exerciseProv.getExerciseHistory(exerciseId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList =
                  snapshot.data!.docs;
              if (dataList.isNotEmpty) {
                return ExerciseHistoryTable(dataList: dataList);
              } else {
                return const Center(
                  child: Text("No Data"),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
