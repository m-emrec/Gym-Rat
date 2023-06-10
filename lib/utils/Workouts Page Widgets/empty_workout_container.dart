import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/empth_padding_extension.dart';
import 'package:gym_rat_v2/screens/Main%20Page/Workouts%20Page/start_new_cycle_screen.dart';
import 'package:gym_rat_v2/utils/shared/circle_button.dart';
import 'package:gym_rat_v2/utils/shared/help_box_.dart';

class EmptyWorkoutContainer extends StatelessWidget {
  /// DEFINITON: If there is no workout to show , this Widget will be used.
  const EmptyWorkoutContainer({super.key});

  void _showHelpText(BuildContext ctx, String helpText) {
    showDialog(
      context: ctx,
      builder: (_) => HelpBox(helpText: helpText),
    );
  }

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
                // Title
                Text(
                  "You don't have any workout now.\nLet's Add some.",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                16.ph(),
                // * Buttons Column
                SizedBox(
                  width: constraints.maxWidth * 0.6,
                  child: Column(
                    children: [
                      //* Add new workout button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            style: const ButtonStyle().copyWith(
                              fixedSize: MaterialStatePropertyAll(
                                Size.fromWidth(
                                  constraints.maxWidth * 0.5,
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text("Add New Workout"),
                          ),
                          //* Help button
                          CircleButton(
                            label: "",
                            onTap: () =>
                                _showHelpText(context, "Add new Workout Help"),
                            radius: 16,
                            icon: Icons.question_mark,
                          ),
                        ],
                      ),
                      16.ph(),
                      //* Start new cycle button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            style: const ButtonStyle().copyWith(
                              fixedSize: MaterialStatePropertyAll(
                                Size.fromWidth(
                                  constraints.maxWidth * 0.5,
                                ),
                              ),
                            ),
                            onPressed: () => Navigator.of(context)
                                .pushNamed(StartNewCyclePage.routeName),
                            child: const Text("Start New Cycle"),
                          ),
                          // Help button
                          CircleButton(
                            label: "",
                            onTap: () => _showHelpText(context,
                                "If you want to create a new cycle , use this option."),
                            radius: 16,
                            icon: Icons.question_mark,
                          ),
                        ],
                      ),
                    ],
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
