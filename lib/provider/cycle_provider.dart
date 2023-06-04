import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/logger.dart';

class CycleProvider extends ChangeNotifier {
  /// Gets the current User's uid from @[Users_collection]
  getUid() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user!.uid;
  }

  /// Gets the Docs of the current user.
  DocumentReference<Map<String, dynamic>> getUserDocs() {
    // logger.i("get user docs");

    final CollectionReference<Map<String, dynamic>> userCollection =
        FirebaseFirestore.instance.collection("Users");

    final userDoc = userCollection.doc(getUid());
    return userDoc;
  }

  // Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getExercises() async {
  //   late DocumentReference<Map<String, dynamic>> userDoc;
  //   final CollectionReference<Map<String, dynamic>> userCollection =
  //       FirebaseFirestore.instance.collection("Users");

  //   userDoc = userCollection.doc(getUid());
  //   final usersCycles = userDoc.collection("Cycles");
  //   final userWorkouts = await usersCycles.snapshots();
  //   final usersExercises = usersCycles.snapshots();
  //   // logger.i(usersExercises);
  //   return usersExercises;
  // }

  /// This function reachs the current User's @[Cycles_collection] and returns it.
  CollectionReference<Map<String, dynamic>> getCycles() {
    // logger.i("get  cycles");

    final userCycles = getUserDocs().collection("Cycles");
    return userCycles;
  }

  Future<DocumentReference<Map<String, dynamic>>> getActiveCycle() async {
    // logger.i("get active cycle");
    final cycles = getCycles().snapshots();
    late final DocumentReference<Map<String, dynamic>> activeCycle;

    await for (var element in cycles) {
      for (var doc in element.docs) {
        // logger.wtf(doc["cycleName"]);

        if (doc["isActive"]) {
          activeCycle = getCycles().doc(doc.id);
          return activeCycle;
        }
      }
    }
    return activeCycle;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getWorkouts() async {
    final DocumentReference<Map<String, dynamic>> activeCycle =
        await getActiveCycle();
    final userWorkouts = activeCycle.collection("Workouts").get();
    return userWorkouts;
  }
} //* end of PRovider
