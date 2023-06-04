import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/empth_padding_extension.dart';

import '../constants.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.label,
    this.radius = 50,
    this.labelColor = AppColors.kButtonColor,
    required this.onTap,
    this.labelSize = 16,
  });
  final String label;
  final double radius;
  final double labelSize;
  final Color labelColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: labelColor,
                  fontSize: labelSize,
                ),
          ),
          8.pw(),
          Container(
            width: radius,
            height: radius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: AppColors.kButtonColor,
              ),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.navigate_next,
                color: AppColors.kButtonColor,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
