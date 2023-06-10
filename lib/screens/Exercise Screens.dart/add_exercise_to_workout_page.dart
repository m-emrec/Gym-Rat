import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/enums/exercises_collection_enum.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/provider/exercises_provider.dart';
import 'package:gym_rat_v2/utils/shared/Tile%20Widgets/exercise_tile.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class AddExerciseToWorkoutPage extends StatefulWidget {
  AddExerciseToWorkoutPage({super.key});
  static const routeName = "add-exercise-to-workout";

  final ScrollController _scrollController = ScrollController();

  @override
  State<AddExerciseToWorkoutPage> createState() =>
      _AddExerciseToWorkoutPageState();
}

class _AddExerciseToWorkoutPageState extends State<AddExerciseToWorkoutPage> {
  @override
  void initState() {
    Provider.of<ExerciseProvider>(context, listen: false).exerciseOffset = 0;
    Provider.of<ExerciseProvider>(context, listen: false).exerciseData = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "Back",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.kRedCollor,
                ),
          ),
        ),
        title: Text(
          "Add Exercise",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 18,
                color: AppColors.kButtonColor,
              ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: width,
        child: Consumer<ExerciseProvider>(
          builder: (context, value, child) => Column(
            children: [
              // Search Bar, Filter etc.
              // Container(
              //   height: 100,
              //   width: double.infinity,
              // ),
              // Exercise List
              FutureBuilder(
                future: value.fetchExerciseData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final exercise = snapshot.data![index];
                          return ExerciseTile(
                            title: exercise[ExerciseApiKeys.name.name],
                            muscle: exercise[ExerciseApiKeys.muscle.name],
                            leading: Text(
                              index.toString(),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
              // TextButton(
              //   onPressed: () => value.setExerciseOffset(offset: 10),
              //   child: Text("See more..."),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
