import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/utils/Workouts%20Page%20Widgets/archive.dart';
import 'package:gym_rat_v2/utils/Workouts%20Page%20Widgets/workouts_container.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/customTitle.dart';

import '../utils/Workouts Page Widgets/hello_widget.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  static const routeName = "workouts-main-page";
  @override
  Widget build(BuildContext context) {
    //* contains New Cycle and New Workout buttons
    Widget buttonContainer = Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //* add new workout Cycle button
          Tooltip(
            message: "Click to add new Cycle",
            child: OutlinedButton(
              onPressed: () => {},
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: AppColors.kIconColor,
                  ),
                  Text(
                    "New Cycle",
                  ),
                ],
              ),
            ),
          ),
          // Just for some spacing
          const SizedBox(
            width: 10,
          ),

          //*  add new workout button
          Tooltip(
            message: "Click to add new Workout",
            child: OutlinedButton(
              onPressed: () => {},
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: AppColors.kIconColor,
                  ),
                  Text(
                    "New Workout",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HelloWidget(),
        buttonContainer,
        Divider(
          indent: 15,
          endIndent: 15,
          color: Theme.of(context).primaryColor,
          thickness: 3,
        ),
        const Flexible(
          // ? buradaki flex değerini değiştir sonradan
          flex: 5,
          child: WorkoutsBox(),
        ),
        const Flexible(
          child: ArchiveBox(),
        ),
      ],
    );
  }
}
