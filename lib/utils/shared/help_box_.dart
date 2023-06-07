import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';

class HelpBox extends StatelessWidget {
  final String helpText;

  const HelpBox({
    super.key,
    required this.helpText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const CircleAvatar(
        backgroundColor: AppColors.kPrimary,
        foregroundColor: AppColors.kButtonColor,
        child: Icon(Icons.question_mark),
      ),
      content: Text(helpText),
    );
  }
}
