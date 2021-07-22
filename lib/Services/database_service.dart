import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:focus_app/Models/models.dart';

class DatabaseService extends ChangeNotifier {
  final String? uid;
  DatabaseService({this.uid});
  //collection ref
  final CollectionReference focusCollection =
      FirebaseFirestore.instance.collection('Focus Users');
  Future updateUserData(
      String username, int focusTime, String feedback, int credits) async {
    return await focusCollection.doc(uid).set(
      {
        'username': username,
        'focusTime': focusTime,
        'feedback': feedback,
        'credits': credits,
      },
    );
  }

  bool _hasText = false;

  bool get hastText => _hasText;

  void setTrue() {
    _hasText = true;
    notifyListeners();
  }

  void setFalse() {
    _hasText = false;
    notifyListeners();
  }

  Future<void> updateUsername(String uid, String username) {
    return focusCollection
        .doc(uid)
        .update({'username': username})
        .then((value) => print("Username updated"))
        .catchError((error) => print("Failed to update username: $error"));
  }

  Future<void> deleteUser() {
    return focusCollection
        .doc(uid)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  // // focus users from snapshot
  // List<FocusUser> _focusUserListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return FocusUser(
  //       username: doc['username'] ?? '',
  //       focusTime: doc['focusTime'] ?? 0,
  //       feedBack: doc['feedback'] ?? '',
  //       credits: doc['credits'] ?? 0,
  //     );
  //   }).toList();
  // }

  // //stream
  // Stream<List<FocusUser>> get focuser {
  //   return focusCollection.snapshots().map(_focusUserListFromSnapshot);
  // }

  //user data from snapshot
  FocusUserData _userDataFromSnap(DocumentSnapshot snapshot) {
    return FocusUserData(
      uid: uid,
      username: snapshot.get(FieldPath(['username'])),
      focusTime: snapshot.get(FieldPath(['focusTime'])),
      feedBack: snapshot.get(FieldPath(['feedback'])),
      credits: snapshot.get(FieldPath(['credits'])),
    );
  }

  // get user doc stream
  Stream<FocusUserData> get userData {
    return focusCollection.doc(uid).snapshots().map(_userDataFromSnap);
  }
}
