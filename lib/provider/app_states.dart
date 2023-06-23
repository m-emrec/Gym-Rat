import 'package:flutter/material.dart';

enum StateControllers {
  showAddDataController,
}

class AppStates extends ChangeNotifier {
  /// This Map contains states of the app.
  final Map _stateControllers = {
    StateControllers.showAddDataController.name: false,
  };
  Map get stateControllers => _stateControllers;

  bool get showAddDataController =>
      _stateControllers[StateControllers.showAddDataController.name];
  void resetState(StateControllers controller) {
    _stateControllers[controller.name] = false;
    notifyListeners();
  }

  showAddDataContainer() {
    _stateControllers[StateControllers.showAddDataController.name] =
        !_stateControllers[StateControllers.showAddDataController.name];
    notifyListeners();
  }
}
