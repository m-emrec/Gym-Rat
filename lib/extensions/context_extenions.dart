import 'package:flutter/material.dart';
import 'package:gym_rat_v2/provider/app_states.dart';
import 'package:gym_rat_v2/provider/exercises_provider.dart';
import 'package:provider/provider.dart';

extension ContextExtension on BuildContext {
  /// Theme gettters
  TextTheme get textTheme => Theme.of(this).textTheme;
  ButtonStyle? get elevatedButtonTheme =>
      Theme.of(this).elevatedButtonTheme.style;
  ThemeData get theme => Theme.of(this);

  /// MediaQuery Getters
  Size get mediaQuerySize => MediaQuery.of(this).size;

  /// Navigator
  navPushNamed(String routeName) => Navigator.of(this).pushNamed(routeName);
  navPush(Widget route) => Navigator.of(this).push(
        MaterialPageRoute(builder: (_) => route),
      );
  navPop() => Navigator.of(this).pop();

  /// Provider getters
  /// @[ExerciseProvider] getters

  /// Listten = false
  ExerciseProvider get exerciseProv =>
      Provider.of<ExerciseProvider>(this, listen: false);

  /// Listen = true
  ExerciseProvider get exerciseProvL => Provider.of<ExerciseProvider>(this);

  /// @[AppStates] getters
  AppStates get appStates => Provider.of<AppStates>(this, listen: false);
  AppStates get appStatesL => Provider.of<AppStates>(this);

  ////
}
