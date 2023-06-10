import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/provider/auth_provider.dart';
import 'package:gym_rat_v2/screens/Auth%20Screens/sign_up_page.dart';
import 'package:gym_rat_v2/utils/shared/customTitle.dart';
import 'package:gym_rat_v2/utils/Forms/reset_password_form.dart';
import 'package:gym_rat_v2/utils/Forms/sign_up_form_field.dart';
import 'package:provider/provider.dart';

import '../../utils/Custom Widgets/custom_buton.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  static const routeName = "login-page";

  void signInUSer({
    required BuildContext ctx,
    required String email,
    required String password,
  }) {
    Provider.of<AuthProvider>(ctx, listen: false)
        .signIn(ctx: ctx, email: email, password: password);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> sigInFormKey = GlobalKey<FormState>();

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
          const Row(
            children: [
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
                  onTap: () => Provider.of<AuthProvider>(context, listen: false)
                      .googleSignIn(context)
                      .onError((error, stackTrace) => logger.e(error))
                      .then(
                        (value) =>
                            Navigator.of(context).pushReplacementNamed("/"),
                      ),
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
            onPressed: () => Navigator.of(context).pushReplacementNamed(
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
      // backgroundColor: AppColors.kSignInPagebgColor,
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
                ),
                SignFormField(
                  emailController: emailController,
                  passwordController: passwordController,
                  formKey: sigInFormKey,
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
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => ResetPasswordForm(),
                  ),
                  child: const Text(
                    "Forget my password.",
                    // style: TextStyle(color: AppColors.kButtonColor),
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
