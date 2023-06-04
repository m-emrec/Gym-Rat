import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("Users");

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
    await _userCollection.doc(userData["uid"]).set(userData);
  }

  // User update operations
  void updateProfilePic() {}

  // end of user update operations
}
