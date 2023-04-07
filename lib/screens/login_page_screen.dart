import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/screens/sign_up_page.dart';
import 'package:gym_rat_v2/utils/customSnackBar.dart';
import 'package:gym_rat_v2/utils/customTitle.dart';

import '../utils/custom_buton.dart';
import '../utils/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static const routeName = "login-page";

  void signInUSer(BuildContext ctx) {
    // logger.i("Email : ${passWordController.text}");
    final snack = customSnackBar(message: "Snack Bar Test").createSnackBar();
    ScaffoldMessenger.of(ctx).showSnackBar(snack);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // This container contains --or-- text and below that a row with Google and Facebook Sıng in in it.
    var alternativeSignInContainer = Container(
      margin: const EdgeInsets.only(bottom: 20),
      alignment: Alignment.center,
      width: 150,
      child: Column(
        children: [
          // --- or --- text
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    color: AppColors.kTextColor,
                    thickness: 2,
                  ),
                ),
              ),
              Text(
                "or",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    color: AppColors.kTextColor,
                    thickness: 2,
                  ),
                ),
              ),
            ],
          ),

          // Sign in with Google and Facebook Row
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    "lib/assets/images/GoogleLogo.webp",
                    height: 32,
                    width: 32,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    "lib/assets/images/FacebookLogo.webp",
                    height: 32,
                    width: 32,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
    //final snackBar = ModalRoute.of(context)?.settings.arguments as SnackBar;
    
    var signUpText = Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have an account ?"),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(
              SignUpPage.routeName,
            ),
            child: const Text(
              "Sign Up!",
              style: TextStyle(
                color: AppColors.kTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return Scaffold(
      backgroundColor: AppColors.kSignInPagebgColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: AppColors.kPrimary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sign In title
                const CustomTitle(
                  title: "Sign In",
                  withDivider: true,
                  dividerColor: AppColors.kTextColor,
                ),

                // Email Field
                CustomTextField(
                  textController: emailController,
                  isEmailField: true,
                  label: "Email",
                ),
                // Password Field
                CustomTextField(
                  textController: passwordController,
                  label: "Password",
                  isPassword: true,
                ),
                // Continue Button
                CustomButton(
                  onTap: ()=> signInUSer(context),
                  text: "Continue",
                ),
                // Don't have an Account ? Sign Up(Text button)
                signUpText,

                // or seperator
                alternativeSignInContainer,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
