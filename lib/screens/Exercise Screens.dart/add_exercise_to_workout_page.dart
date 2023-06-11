import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/enums/exercises_collection_enum.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/provider/exercises_provider.dart';
import 'package:gym_rat_v2/utils/shared/Tile%20Widgets/exercise_tile.dart';
import 'package:gym_rat_v2/utils/shared/custom_text_field.dart';
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
    Provider.of<ExerciseProvider>(context, listen: false).exerciseOffset = 0;
    Provider.of<ExerciseProvider>(context, listen: false).exerciseData = [];
    _isLoading = false;
    _scrollListener();
    super.initState();
  }

  void _scrollListener() {
    widget._scrollController.addListener(
      () {
        // logger.i(_isLoading);
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
    // TODO: implement dispose
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
                  return const Center(
                    child: CircularProgressIndicator(),
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
