import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_rat_v2/constants.dart';

enum KeyboardType {
  email,
  number,
  text,
  phone,
  password,
  numberWithDecimals,
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.textController,
    super.key,
    required this.label,
    this.goToNextTextField = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.suffixText,
    this.isPassword = false,
    this.startWithCapital = false,
    this.suffixWidget,
  });

  final TextEditingController textController;
  final String label;
  final bool goToNextTextField;
  final Function? validator;
  final TextInputType keyboardType;
  final String? suffixText;
  final bool isPassword;
  final bool startWithCapital;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: TextFormField(
        validator: (String? val) => validator!(val),
        controller: textController,
        textCapitalization: startWithCapital
            ? TextCapitalization.sentences
            : TextCapitalization.none,
        keyboardType: keyboardType,
        inputFormatters: [
          keyboardType == TextInputType.number
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.deny(""),
        ],
        decoration: InputDecoration(
          labelText: label,
          suffixText: suffixText,
          suffix: suffixWidget,
        ),
        obscureText: isPassword,
        cursorColor: AppColors.kButtonColor,
        textInputAction:
            goToNextTextField ? TextInputAction.next : TextInputAction.done,
      ),
    );
  }
}
