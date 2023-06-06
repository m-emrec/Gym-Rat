import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gym_rat_v2/enums/cycle_collection_enum.dart';
import 'package:gym_rat_v2/logger.dart';

class CycleProvider extends ChangeNotifier {
  /// Gets the current User's uid from @[Users_collection]
  getUid() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user!.uid;
  }

  /// Gets the Docs of the current user.
  Future<DocumentReference<Map<String, dynamic>>> getUserDocs() async {
    // logger.i("get user docs");

    final CollectionReference<Map<String, dynamic>> userCollection =
        FirebaseFirestore.instance.collection("Users");

    // final userDoc = userCollection.doc(getUid());
    final userDoc = await userCollection
        .doc(getUid())
        .get()
        .then((value) => value.reference);

    return userDoc;
  }

  /// This function reachs the current User's @[Cycles_collection] and returns it.
  Future<CollectionReference<Map<String, dynamic>>> getCycles() async {
    // logger.i("get  cycles");
    final DocumentReference<Map<String, dynamic>> userDocs =
        await getUserDocs();

    final userCycles = userDocs.collection("Cycles");
    return userCycles;
  }

  Future<DocumentReference<Map<String, dynamic>>> getActiveCycle() async {
    // logger.i("get active cycle");
    final cycles = await getCycles();
    late final DocumentReference<Map<String, dynamic>> activeCycle;
    final cycleList = await cycles.get().then((value) => value.docs);
    for (var doc in cycleList) {
      if (doc.data()[CycleCollection.isActive.name]) {
        activeCycle = doc.reference;
      }
    }
    return activeCycle;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getWorkouts() async {
    // logger.v("get workouts");
    final DocumentReference<Map<String, dynamic>> activeCycle =
        await getActiveCycle();
    final userWorkouts = activeCycle.collection("Workouts").get();
    return userWorkouts;
  }

  ////////////
} //* end of PRovider
