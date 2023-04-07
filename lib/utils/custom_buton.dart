import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kButtonColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
              color: AppColors.kButtonColor,
              offset: Offset(0, 5),
              spreadRadius: 1,
              blurRadius: 5)
        ],
      ),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: double.infinity,
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            splashColor: Colors.white54, //AppColors.kButtonColor,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
