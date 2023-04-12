import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';

class customSnackBar {
  final String message;

  SnackBar createSnackBar() {
    return SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: AppColors.kTextColor),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.kPrimary,
      margin: const EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 10.0),
    );
  }

  customSnackBar({
    required this.message,
  });
}
