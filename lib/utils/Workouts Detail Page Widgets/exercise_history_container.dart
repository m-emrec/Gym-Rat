import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/extensions/empth_padding_extension.dart';

import 'add_data_to_exercise_container.dart';
import 'exercise_history_table.dart';

class ExerciseDataHistory extends StatefulWidget {
  const ExerciseDataHistory({
    super.key,
    required this.exercise,
  });

  final Map exercise;
  @override
  State<ExerciseDataHistory> createState() => _ExerciseDataHistoryState();
}

class _ExerciseDataHistoryState extends State<ExerciseDataHistory> {
  bool _showAddExerciseDataContainer = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: context.mediaQuerySize.height * 0.3,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 3, color: context.theme.primaryColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: FutureBuilder(
          future:
              context.exerciseProv.getExerciseHistory(widget.exercise["id"]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final List<QueryDocumentSnapshot<Map<String, dynamic>>> dataList =
                  snapshot.data!.docs;

              /// if showAddExerciseDataContaner is true.
              if (_showAddExerciseDataContainer) {
                return AddDataToExerciseContainer(
                  exercise: widget.exercise,
                );
              }
              if (dataList.isNotEmpty) {
                return ExerciseHistoryTable(dataList: dataList);
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "There is nothing to show here.",
                        style: context.textTheme.labelMedium,
                      ),
                    ),
                    16.ph(),
                    OutlinedButton(
                      style: context.theme.outlinedButtonTheme.style!.copyWith(
                        fixedSize: MaterialStatePropertyAll(
                          Size.fromWidth(
                            context.mediaQuerySize.width * 0.5,
                          ),
                        ),
                      ),
                      onPressed: () => setState(() {
                        _showAddExerciseDataContainer = true;
                      }),
                      child: const Text("Add Data"),
                    )
                  ],
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
