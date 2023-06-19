class ExerciseData {
  final DateTime date;
  final List<Map> data;

  /// data =
  /// [ {
  ///     rpe:8.5,
  ///     weight:130,
  ///     },
  ///   {
  ///     rpe:8.5,
  ///     weight:130,
  ///     "rep": 10
  ///   }
  ///     ]
  final String? note;

  ExerciseData({
    required this.date,
    required this.data,
    this.note,
  });
}
