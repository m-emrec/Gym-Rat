import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile(
      {super.key,
      required this.title,
      required this.muscle,
      required this.leading});

  final String title;
  final String muscle;
  final Widget leading;
  String get muscleName {
    String firstLetter = muscle[0].toUpperCase();
    //TODO:
    String name = firstLetter + muscle[0];
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 14),
      ),
      trailing: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: IconButton(
          onPressed: null,
          icon: Icon(Icons.add),
        ),
      ),
      subtitle: Text(
        muscle,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }
}

/*
 "name": "Incline Hammer Curls",
    "type": "strength",
    "muscle": "biceps",
    "equipment": "dumbbell",
    "difficulty": "beginner",
    "instructions": "Seat yourself on a

*/
