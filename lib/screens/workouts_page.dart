import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/utils/Workouts%20Page%20Widgets/archive.dart';
import 'package:gym_rat_v2/utils/Workouts%20Page%20Widgets/workouts_container.dart';
import 'package:gym_rat_v2/utils/shared/customTitle.dart';

import '../utils/Workouts Page Widgets/hello_widget.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});

  static const routeName = "workouts-main-page";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HelloWidget(),
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
