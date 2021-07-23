import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:focus_app/Models/models.dart';

class DatabaseService extends ChangeNotifier {
  final String? uid;
  DatabaseService({this.uid});
  //collection ref
  final CollectionReference focusCollection =
      FirebaseFirestore.instance.collection('Focus Users');

  //initial setting of data
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

  //just some random variables that were used in fields
  bool _hasText = false;

  bool get hastText => _hasText;

  bool _obscureText = true;

  bool get obscureText => _obscureText;

  bool _obscureNewText1 = true;

  bool get obscureNewText1 => _obscureNewText1;

  bool _obscureNewText2 = true;

  bool get obscureNewText2 => _obscureNewText2;

  void toggleNewObscure1() {
    _obscureNewText1 = !_obscureNewText1;
    notifyListeners();
  }

  void toggleNewObscure2() {
    _obscureNewText2 = !_obscureNewText2;
    notifyListeners();
  }

  void toggleObscure() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void setTrue() {
    _hasText = true;
    notifyListeners();
  }

  void setFalse() {
    _hasText = false;
    notifyListeners();
  }

  //updating username
  Future<void> updateUsername(String uid, String username) {
    return focusCollection
        .doc(uid)
        .update({'username': username})
        .then((value) => print("Username updated"))
        .catchError((error) => print("Failed to update username: $error"));
  }

  Future<String?> getFeedBack(String uid) {
    return focusCollection.doc(uid).get().then((DocumentSnapshot snapshot) {
      try {
        var feedback = snapshot.get(FieldPath(['feedback']));
        print(feedback);
        return feedback;
      } on StateError catch (e) {
        print(e.toString());
      }
    });
  }

  //updating feedback
  Future<void> updateFeedback(String uid, String feedback) {
    return focusCollection
        .doc(uid)
        .update({'feedback': feedback})
        .then((value) => print("Feedback updated"))
        .catchError((error) => print("Failed to update feedback: $error"));
  }

  //deleting userdata
  Future<void> deleteUser() {
    return focusCollection
        .doc(uid)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

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
