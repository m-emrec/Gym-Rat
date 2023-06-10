import 'package:flutter/material.dart';

import '../../../constants.dart';

class WorkoutTile extends StatelessWidget {
  /*
    * A widget to create workout tiles.

    * It takes workoutname<String> and exercises<List> as parameters.
  */

  const WorkoutTile({
    super.key,
    required this.workoutName,
    required this.exercises,
    required this.onTap,
  });

  final String workoutName;
  final List exercises;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // * Title and popMenu button
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // * Workout name
                Text(
                  workoutName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                // * menu button
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: AppColors.kButtonColor,
                  ),
                )
              ],
            ),
          ),
          // * Divider below the Workout name
          SizedBox(
            width: 140,
            child: Divider(
              thickness: 2,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
      // * Sneak peak of the exercise list
      subtitle: Text(
        exercises.toString(),
        style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 12),
      ),
    );
  }
}
