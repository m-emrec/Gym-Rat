import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/authService.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/provider/user_provider.dart';
import 'package:gym_rat_v2/screens/sign_up_page.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/customSnackBar.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/customTitle.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/custom_progress_indicator.dart';
import 'package:provider/provider.dart';

import '../utils/Custom Widgets/custom_buton.dart';
import '../utils/Custom Widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static const routeName = "login-page";

  void onError(BuildContext ctx, var error) {
    logger.e(error.code);
    Map errorMap = {
      "user-not-found":
          "User not found ! Please check your e-mail address and try again.",
      "wrong-password":
          "Wrong Password ! Please check your password and try again. If you forget your password click Forget my password.",
      "invalid-email": "Invalid email ! PLease check your email address."
    };
    final snackBar =
        customSnackBar(message: errorMap[error.code]).createSnackBar();
    ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
  }

  void signInUSer({
    required BuildContext ctx,
    required String email,
    required String password,
  }) {
    Provider.of<UserProvider>(ctx, listen: false)
        .signIn(ctx: ctx, email: email, password: password);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // This container contains --or-- text and below that a row with Google and Facebook Sıng in in it.
    Widget alternativeSignInContainer = Container(
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
                // Google Sign in
                GestureDetector(
                  onTap: () => Provider.of<UserProvider>(context,listen: false).googleSignIn(context),
                  child: Image.asset(
                    "lib/assets/images/GoogleLogo.webp",
                    height: 32,
                    width: 32,
                  ),
                ),
                // Facebook Sign in
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

    var signUpText = Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
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
                  goToNextTextField: true,
                ),
                // Password Field
                CustomTextField(
                  textController: passwordController,
                  label: "Password",
                  isPassword: true,
                ),
                // Continue Button
                CustomButton(
                  onTap: () => signInUSer(
                      ctx: context,
                      email: emailController.text,
                      password: passwordController.text),
                  text: "Continue",
                ),
                TextButton(
                  //TODO: Add Forget my password function.
                  onPressed: () {},
                  child: const Text(
                    "Forget my password.",
                    style: TextStyle(color: AppColors.kButtonColor),
                  ),
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
