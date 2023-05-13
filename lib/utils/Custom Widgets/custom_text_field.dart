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
    this.keyboardType = KeyboardType.text,
    this.suffixText,
  });

  final TextEditingController textController;
  final String label;
  final bool goToNextTextField;
  final Function? validator;
  final KeyboardType keyboardType;
  final String? suffixText;

  TextInputType _setKeyboardType() {
    switch (keyboardType) {
      case KeyboardType.email:
        return TextInputType.emailAddress;
      case KeyboardType.number:
        return const TextInputType.numberWithOptions();
      case KeyboardType.numberWithDecimals:
        return TextInputType.number;
      case KeyboardType.phone:
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: TextFormField(
        validator: (String? val) => validator!(val),
        controller: textController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: _setKeyboardType(),
        inputFormatters: [
          _setKeyboardType() == TextInputType.number
              ? FilteringTextInputFormatter.digitsOnly
              : FilteringTextInputFormatter.deny(""),
        ],
        decoration: InputDecoration(
          labelText: label,
          suffixText: suffixText,
        ),
        obscureText: keyboardType == KeyboardType.password,
        cursorColor: AppColors.kButtonColor,
        textInputAction:
            goToNextTextField ? TextInputAction.next : TextInputAction.done,
      ),
    );
  }
}
