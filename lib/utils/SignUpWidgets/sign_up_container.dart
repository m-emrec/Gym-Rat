import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_rat_v2/screens/login_page_screen.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../provider/auth_provider.dart';
import '../Custom Widgets/customTitle.dart';
import '../Custom Widgets/custom_buton.dart';
import '../Forms/sign_up_form_field.dart';
import '../terms_and_privacy_popup.dart';

class SignUpPageContainer extends StatelessWidget {
  SignUpPageContainer({super.key});

  void signUpUser({
    required String email,
    required String password,
    required BuildContext ctx,
  }) {
    Provider.of<AuthProvider>(ctx, listen: false)
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
    Widget termsAndPrivacyPolicyText = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10),
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
    return Center(
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

                /// All ready have an account. Navigate to Login Page
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushReplacementNamed(LoginPage.routeName),
                  child: const Text("Already Have an Account ?"),
                ),
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
    );
  }
}
