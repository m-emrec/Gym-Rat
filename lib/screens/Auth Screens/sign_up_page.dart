import 'package:flutter/material.dart';

import '../../utils/SignUpWidgets/sign_up_container.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const routeName = "sign-up-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Opacity(
            opacity: 0.5,
            child: Image.asset(
              "lib/assets/images/Sign up page bg.webp",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          SignUpPageContainer(),
        ],
      ),
    );
  }
}
