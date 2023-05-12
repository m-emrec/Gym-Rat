import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/provider/user_provider.dart';
import 'package:gym_rat_v2/utils/terms_and_privacy_popup.dart';
import 'package:provider/provider.dart';

import '../utils/Custom Widgets/customTitle.dart';
import '../utils/Custom Widgets/custom_buton.dart';
import '../utils/Custom Widgets/custom_text_field.dart';
import '../utils/Forms/sign_up_form_field.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  static const routeName = "sign-up-page";

  // Sign up function.
  void signUpUser({
    required String email,
    required String password,
    required BuildContext ctx,
  }) {
    Provider.of<UserProvider>(ctx, listen: false)
        .signUp(email: email, password: password, ctx: ctx);
  }

  void showTermsofServiceAndPrivacyPolicy(BuildContext ctx) {
    // Shows the Terms and pravicy popup widget
    showDialog(
      context: ctx,
      builder: (_) => const TermsAndPrivacy(),
    );
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // termsAndPrivacy Text
    Widget termsAndPrivacyPolicyText = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 30),
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: -5,
        children: [
          const Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 12),
              children: [
                TextSpan(text: "By selecting "),
                TextSpan(
                  text: "Agree and Continue ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: "below,I agree to"),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              showTermsofServiceAndPrivacyPolicy(context);
            },
            child: const Text(
              "Terms of Service and Privacy Policy.",
              style: TextStyle(
                color: AppColors.kTextColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        ],
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.kCanvasColor,
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
          Center(
            child: SingleChildScrollView(
              // I use BackDropFilter to give blur effect
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.kPrimary.withOpacity(0.5),
                          offset: const Offset(0, 3),
                          spreadRadius: 5,
                          blurRadius: 10),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Sign Up title

                      const CustomTitle(
                        title: "Sign Up",
                        withDivider: true,
                      ),
                      SignFormField(
                        formKey: _signUpFormKey,
                        emailController: emailController,
                        passwordController: passwordController,
                      ),

                      termsAndPrivacyPolicyText,
                      // Sign Up Button
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60.0),
                        child: CustomButton(
                          onTap: () => {
                            if (_signUpFormKey.currentState!.validate())
                              {
                                signUpUser(
                                  ctx: context,
                                  email: emailController.text,
                                  password: passwordController.text,
                                )
                              },
                          },
                          text: "Agree and Continue",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
