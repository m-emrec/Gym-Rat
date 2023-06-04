import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/customTitle.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/custom_buton.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/custom_text_field.dart';

class ResetPasswordForm extends StatelessWidget {
  ResetPasswordForm({super.key});

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const CustomTitle(title: "Reset Password"),
            ),
            CustomTextFormField(
              textController: _controller,
              label: "Email",
              keyboardType: TextInputType.emailAddress,
            ),
            CustomButton(
              text: "Send",
              onTap: () => {
                if (EmailValidator.validate(_controller.text))
                  {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _controller.text)
                        .then(
                          (value) => Navigator.of(context).pop(),
                        ),
                  }
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
