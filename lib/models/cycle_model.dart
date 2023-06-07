class CycleModel {
  final String cycleName;
  final String id;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final int numberOfWeeks;
  final String goal;

  String printData() {
    return "ID : $id\nCycle Name : $cycleName\nGoal : $goal\nIs Active : $isActive\nWeeks : $numberOfWeeks\nStart Date : $startDate";
  }

  CycleModel({
    required this.cycleName,
    required this.id,
    required this.startDate,
    this.endDate,
    required this.isActive,
    required this.numberOfWeeks,
    required this.goal,
  });
}
