import 'package:flutter/material.dart';

import '../shared/custom_text_field.dart';

class SignInFormField extends StatelessWidget {
  SignInFormField({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final GlobalKey<FormState> formKey;

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
            keyboardType: TextInputType.emailAddress,
            goToNextTextField: true,
          ),
          // Password Field
          CustomTextFormField(
            textController: passwordController,
            label: "Password",
            isPassword: true,
          ),
        ],
      ),
    );
  }
}
