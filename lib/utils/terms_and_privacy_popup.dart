import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gym_rat_v2/constants.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/customTitle.dart';

class TermsAndPrivacy extends StatefulWidget {
  const TermsAndPrivacy({super.key});

  @override
  State<TermsAndPrivacy> createState() => _TermsAndPrivacyState();
}

class _TermsAndPrivacyState extends State<TermsAndPrivacy> {
  @override
  Widget build(BuildContext context) {
    return const Dialog(
      backgroundColor: AppColors.kCanvasColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTitle(title: "Terms of Service"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Welcome to our gym tracker app. By accessing or using the app, you agree to be bound by these terms and conditions. If you disagree with any part of the terms, you may not use the app."
                "Use of App: The app is provided on an 'as is' and 'as available' basis. We reserve the right to modify, suspend, or discontinue the app at any time without notice."
                "User Conduct: You agree to use the app only for lawful purposes and in a manner that does not infringe the rights of others. You also agree to comply with all applicable laws and regulations."
                "Personal Information: The app collects and stores personal information, such as your name, email address, and workout data. We will use this information solely for the purpose of providing the app services to you, and will not share or sell this information to any third party."
                "Payment: The app may offer premium features that require payment. By purchasing these features, you agree to pay the specified amount and authorize us to charge your payment method for the purchase."
                "Disclaimer of Warranty: We do not warrant that the app will meet your requirements, or that the app will be error-free or uninterrupted. We provide the app on an 'as is' and 'as available' basis, without warranty of any kind.",
              ),
            ),
            CustomTitle(title: "Privacy Policy"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Welcome to our gym tracker app. By accessing or using the app, you agree to be bound by these terms and conditions. If you disagree with any part of the terms, you may not use the app."
                "Use of App: The app is provided on an 'as is' and 'as available' basis. We reserve the right to modify, suspend, or discontinue the app at any time without notice."
                "User Conduct: You agree to use the app only for lawful purposes and in a manner that does not infringe the rights of others. You also agree to comply with all applicable laws and regulations."
                "Personal Information: The app collects and stores personal information, such as your name, email address, and workout data. We will use this information solely for the purpose of providing the app services to you, and will not share or sell this information to any third party."
                "Payment: The app may offer premium features that require payment. By purchasing these features, you agree to pay the specified amount and authorize us to charge your payment method for the purchase."
                "Disclaimer of Warranty: We do not warrant that the app will meet your requirements, or that the app will be error-free or uninterrupted. We provide the app on an 'as is' and 'as available' basis, without warranty of any kind.",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
