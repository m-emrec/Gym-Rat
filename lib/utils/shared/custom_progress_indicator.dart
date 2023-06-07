import 'package:flutter/material.dart';
import 'package:gym_rat_v2/utils/shared/loading_indicator.dart';

import '../../constants.dart';

class CustomProgressIndicator {
  Widget customProgressInd = const CircularProgressIndicator(
    color: AppColors.kPrimary,
    backgroundColor: AppColors.kButtonColor,
  );

  void showProgressIndicator(BuildContext ctx) {
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (_) => const LoadingIndicator(),
    );
  }
}
