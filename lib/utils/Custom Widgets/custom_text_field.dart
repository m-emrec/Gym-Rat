import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/logger.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    required this.textController,
    super.key,
    this.isEmailField = false,
    required this.label,
    this.isPassword = false,
    this.goToNextTextField = false,
    this.validator,
  });

  final TextEditingController textController;
  final bool isEmailField;
  final bool isPassword;
  final String label;
  final bool goToNextTextField;
  final Function? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: TextFormField(
        validator: (String? val) => validator!(val),
        controller: textController,
        keyboardType:
            isEmailField ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
        ),
        obscureText: isPassword,
        cursorColor: AppColors.kButtonColor,
        textInputAction:
            goToNextTextField ? TextInputAction.next : TextInputAction.done,
      ),
    );
  }
}
