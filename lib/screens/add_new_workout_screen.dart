import 'package:flutter/material.dart';
import 'package:gym_rat_v2/utils/shared/circle_button.dart';

import '../constants.dart';

class AddNewWorkoutPage extends StatelessWidget {
  static const routeName = "add-new-workout-page";

  const AddNewWorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          style: const ButtonStyle().copyWith(
            foregroundColor: MaterialStatePropertyAll(
              Colors.red.shade800,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Back"),
        ),
        title: Text(
          "Add Workout",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 16,
                color: AppColors.kButtonColor,
              ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: CircleButton(
        label: "Done",
        onTap: () {},
        icon: Icons.done,
        radius: 32,
      ),
      body: Column(
        children: [
          Text("Add Workout"),
        ],
      ),
    );
  }
}
