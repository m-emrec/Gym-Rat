import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.textController,
    super.key,
    this.isEmailField = false,
    required this.label,
    this.isPassword = false,
    this.goToNextTextField = false,
  });

  final TextEditingController textController;
  final bool isEmailField;
  final bool isPassword;
  final String label;
  final bool goToNextTextField;
  final OutlineInputBorder _border = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.black,
      width: 1.5,
    ),
    borderRadius: BorderRadius.circular(5),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: TextField(
        controller: textController,
        keyboardType:
            isEmailField ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
          labelStyle: const TextStyle(color: AppColors.kTextColor),
          floatingLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.kTextColor),
        ),
        obscureText: isPassword,
        cursorColor: AppColors.kButtonColor,
        textInputAction: goToNextTextField ? TextInputAction.next : TextInputAction.done,
      ),
    );
  }
}
