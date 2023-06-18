import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';
import 'package:gym_rat_v2/provider/exercises_provider.dart';
import 'package:gym_rat_v2/screens/Main%20Page/Workouts%20Page/workout_detail_page.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../utils/Add Exercises Page Widgets/exercise_list.dart';
import '../../utils/Add Exercises Page Widgets/filter_and_search_bar.dart';

class AddExerciseToWorkoutPage extends StatefulWidget {
  AddExerciseToWorkoutPage({super.key});
  static const routeName = "add-exercise-to-workout";

  final ScrollController _scrollController = ScrollController();

  @override
  State<AddExerciseToWorkoutPage> createState() =>
      _AddExerciseToWorkoutPageState();
}

class _AddExerciseToWorkoutPageState extends State<AddExerciseToWorkoutPage> {
  late bool _isLoading;

  @override
  void initState() {
    context.exerciseProv.resetData();
    _isLoading = false;
    _scrollListener();
    super.initState();
  }

  void _scrollListener() {
    widget._scrollController.addListener(
      () {
        if (widget._scrollController.position.pixels ==
            widget._scrollController.position.maxScrollExtent) {
          if (!_isLoading) {
            _isLoading = true;
            Provider.of<ExerciseProvider>(context, listen: false)
                .setExerciseOffset(offset: 10);
          }
        } else {
          // logger.e("else");
          // _isLoading = false;
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget._scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // logger.d(Provider.of<ExerciseProvider>(context).currentWorkoutId);
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
        actions: [
          TextButton(
            onPressed: () {
              context.exerciseProv.addExerciseToWorkout();
              Navigator.of(context)
                  .popUntil(ModalRoute.withName(WorkoutDetailPage.routeName));
            },
            child: const Text("Done"),
          )
        ],
        centerTitle: true,
      ),
      body: Consumer<ExerciseProvider>(
        builder: (context, value, child) => Column(
          children: [
            // Search Bar, Filter etc.
            FilterAndSearchBar(),
            // Exercise List
            FutureBuilder(
              future: value.fetchExerciseData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done ||
                    _isLoading) {
                  _isLoading = false;
                  return ExerciseList(
                    exerciseData: value.exerciseData,
                    scrollController: widget._scrollController,
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
