import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/authService.dart';

import '../logger.dart';
import '../utils/Custom Widgets/customSnackBar.dart';
import '../utils/Custom Widgets/custom_progress_indicator.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// I use this function to manage errors on SignIn
  void _onSignInError(BuildContext ctx, FirebaseAuthException error) {
    /// Close [ProgressIndicator]
    Navigator.of(ctx).pop();
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

  /// I use this function to manage errors on Sign Up
  void _onSignUpError(BuildContext ctx, FirebaseAuthException error) {
    Navigator.of(ctx).pop(); // Just for closing the Progress Indicator.
    logger.e(error.code);
    Map errorMap = {
      "unknown": "Email or Password can't be empty!",
      "invalid-email": "Please enter a valid email\nex: email@hotmail.com",
      "weak-password": "Your password must be longer than 6 char.",
      "email-already-in-use":
          "This email already in use.Please go to login page."
    };

    final snack =
        customSnackBar(message: errorMap[error.code]).createSnackBar();

    ScaffoldMessenger.of(ctx).showSnackBar(snack);
  }

  // Auth operations
  void signIn({
    required BuildContext ctx,
    required String email,
    required String password,
  }) {
    /// Show a Progress indicator [FirebaseAuth].
    CustomProgressIndicator().showProgressIndicator(ctx);
    final snackBar =
        customSnackBar(message: "Logged in as $email").createSnackBar();

    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError(
          (error) => {
            _onSignInError(ctx, error),
          },
        )

        /// Navigate to [AuthPage]
        .then(
          (_) => {
            ScaffoldMessenger.of(ctx).showSnackBar(snackBar),
            Navigator.of(ctx)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false),
          },
        );
  }

  Future<void> googleSignIn(BuildContext ctx) async {
    await AuthService().signInWithGoogle(ctx);
  }

  void signUp({
    required String email,
    required String password,
    required BuildContext ctx,
  }) async {
    CustomProgressIndicator().showProgressIndicator(ctx);

    final SnackBar snackBar =
        customSnackBar(message: "Signed Up!").createSnackBar();

    await _auth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        // If there is an error.
        .catchError(
          (e) => _onSignUpError(ctx, e),
        )
        .then(
          // Navigate to AuthScreen
          (_) => {
            ScaffoldMessenger.of(ctx).showSnackBar(snackBar),
            Navigator.of(ctx).pushReplacementNamed(
              "/",
            )
          },
        );
  }

  void logOut() {
    _auth.signOut();
  }

// end of Auth operations
}
