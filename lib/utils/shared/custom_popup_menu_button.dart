import 'package:flutter/material.dart';
import 'package:gym_rat_v2/extensions/context_extenions.dart';

import '../../constants.dart';

class CustomPopMenuButton extends StatelessWidget {
  const CustomPopMenuButton({
    super.key,
    this.icon,
    required this.items,
  });

  final IconData? icon;
  final List<PopupMenuItem> items;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      icon: Icon(
        icon ?? Icons.more_horiz,
        color: AppColors.kButtonColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: context.theme.primaryColor,
      itemBuilder: (ctx) => items,
    );
  }
}
