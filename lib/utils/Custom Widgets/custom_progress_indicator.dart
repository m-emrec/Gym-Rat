import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomProgressIndicator {
  Widget customProgressInd = const CircularProgressIndicator(
    color: AppColors.kPrimary,
    backgroundColor: AppColors.kButtonColor,
  );

  void showProgressIndicator(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (_) => Center(
        child: customProgressInd,
      ),
    );
  }
}
