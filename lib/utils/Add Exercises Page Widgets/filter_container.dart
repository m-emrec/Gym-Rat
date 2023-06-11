import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/utils/shared/customTitle.dart';
import 'package:gym_rat_v2/utils/shared/filters.dart';

import 'filters_row.dart';

class FilterContainer extends StatefulWidget {
  const FilterContainer({super.key});

  @override
  State<FilterContainer> createState() => _FilterContainerState();
}

class _FilterContainerState extends State<FilterContainer> {
  String byTypeControllerText = "";
  String byMuscleControllerText = "";
  String byDifficultyControllerText = "";

  void _setByType(String val) {
    byTypeControllerText = val;
  }

  void _setByMuscle(String val) {
    byMuscleControllerText = val;
  }

  void _setByDifficulty(String val) {
    byDifficultyControllerText = val;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filter",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Divider(),
        ],
      ),
      content: AspectRatio(
        aspectRatio: 24 / 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterRow(
              label: "by Type",
              values: byType.values,
              controller: _setByType,
            ),
            FilterRow(
              label: "by Muscle",
              values: byMuscle.values,
              controller: _setByMuscle,
            ),
            FilterRow(
              label: "by Difficulty",
              values: byDifficulty.values,
              controller: _setByDifficulty,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          style: const ButtonStyle().copyWith(
            foregroundColor: MaterialStatePropertyAll(AppColors.kRedCollor),
          ),
          child: const Text("Cancel"),
        ),
        TextButton(
          style: const ButtonStyle().copyWith(
            foregroundColor:
                const MaterialStatePropertyAll(AppColors.kButtonColor),
          ),
          onPressed: () {},
          child: const Text("Filter"),
        ),
      ],
    );
  }
}
