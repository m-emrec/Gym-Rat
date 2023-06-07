import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/empth_padding_extension.dart';

import '../../constants.dart';

enum CircleButtonAligment {
  label_icon,
  icon_label,
}

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.label,
    this.radius = 50,
    this.labelColor = AppColors.kButtonColor,
    required this.onTap,
    this.labelSize = 16,
    this.icon = Icons.navigate_next_rounded,
    this.aligment = CircleButtonAligment.label_icon,
  });
  final String label;
  final double radius;
  final double labelSize;
  final Color labelColor;
  final VoidCallback onTap;
  final IconData icon;

  final CircleButtonAligment aligment;

  @override
  Widget build(BuildContext context) {
    final List<Widget> widget = [
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
        child: Align(
          alignment: Alignment.center,
          child: Icon(
            icon,
            color: AppColors.kButtonColor,
            size: radius * 0.9,
          ),
        ),
      ),
    ];
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: aligment == CircleButtonAligment.label_icon
            ? widget
            : widget.reversed.toList(),
      ),
    );
  }
}
