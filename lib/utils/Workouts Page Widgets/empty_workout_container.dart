import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/empth_padding_extension.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/custom_buton.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/circle_button.dart';

class EmptyWorkoutContainer extends StatelessWidget {
  const EmptyWorkoutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.all(32.0),
        child: SizedBox(
          width: constraints.maxWidth,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You don't have any workout.\n Add some.",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                16.ph(),
                SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Add New Workout"),
                  ),
                ),
                16.ph(),
                SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text("Start New Cycle"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
