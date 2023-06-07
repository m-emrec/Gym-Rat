import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../shared/custom_text_field.dart';

class SignFormField extends StatelessWidget {
  SignFormField({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final GlobalKey<FormState> formKey;

  String? _validateEmail(String? val) {
    if (!EmailValidator.validate(val!)) {
      return "Enter a valid email.\nEx : mail@hotmail.com";
    }

    return null;
  }

  String? _validatePassword(String val) {
    if (val.length < 8) {
      return "Your password shoud be longer then 8 characters.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Sign Up title

          // Email Field
          CustomTextFormField(
            textController: emailController,
            label: "Email",
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            goToNextTextField: true,
          ),
          // Password Field
          CustomTextFormField(
            textController: passwordController,
            label: "Password",
            validator: _validatePassword,
            isPassword: true,
          ),
        ],
      ),
    );
  }
}
