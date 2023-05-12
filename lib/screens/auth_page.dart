import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/logger.dart';
import 'package:gym_rat_v2/screens/get_started_screen.dart';
import 'package:gym_rat_v2/screens/login_page_screen.dart';
import 'package:gym_rat_v2/screens/workouts_main_page_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static const routeName = "auth-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            logger.i(snapshot.data);
            // If user is new , that means he has not a display name. So I direct him to the GetStartedPage. This way he can give information about himself.
            if (snapshot.data?.displayName == null) {
              return GetStartedPage();
            }

            return WorkoutsMainPage();
          } else {
            logger.e("Not Logged in");
            return LoginPage();
          }
        },
      ),
    );
  }
}
