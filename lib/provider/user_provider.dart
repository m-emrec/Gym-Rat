import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/authService.dart';
import 'package:gym_rat_v2/models/user_model.dart';

import '../logger.dart';
import '../utils/Custom Widgets/customSnackBar.dart';
import '../utils/Custom Widgets/custom_progress_indicator.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("Users");

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

  void googleSignIn(BuildContext ctx) {
    AuthService().signInWithGoogle(ctx);
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
          // add the User to the Firestore database.
          (_) => _firestore.collection("Users").add(
            {"uid": _auth.currentUser?.uid},
          ),
        )
        // Navigate to AuthPage.
        .then(
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

  /// this function connects the User from FirebaseAuth to Firestore database.
  Future<void> addUserToDatabase(UserModel newUser) async {
    final Map<String, dynamic> userData = {
      "uid": newUser.uid,
      "userName": newUser.userName,
      "gender": newUser.gender,
      "birthDate": newUser.birthDate,
      "length": newUser.length,
      "weight": newUser.weight,
    };
    await _auth.currentUser?.updateDisplayName(newUser.userName);
    await _userCollection.add(userData);
  }

  // User update operations
  void updateProfilePic() {}

  // end of user update operations
}
