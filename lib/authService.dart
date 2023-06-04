import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_rat_v2/utils/Custom%20Widgets/custom_progress_indicator.dart';

class AuthService {
  signInWithGoogle(BuildContext ctx) async {
    CustomProgressIndicator().showProgressIndicator(ctx);
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential).then(
          //Just to close the Procgress indicator.
          (_) => Navigator.of(ctx).pop(),
        );
  }
}
