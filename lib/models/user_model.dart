class UserModel {
  final String userName;

  final String? uid;

  final String gender;
  final DateTime birthDate;
  final double length;
  final double weight;

  UserModel({
    required this.userName,
    required this.uid,
    required this.gender,
    required this.birthDate,
    required this.length,
    required this.weight,
  });
}
