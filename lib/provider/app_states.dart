import 'package:flutter/material.dart';

enum AppStatesEnum {
  none,
  addExerciseData,
}

class AppStates extends ChangeNotifier {
  AppStatesEnum _appState = AppStatesEnum.none;
  AppStatesEnum get appState => _appState;

  void changeState(AppStatesEnum newState) {
    _appState = AppStatesEnum.addExerciseData;
    notifyListeners();
  }
}
