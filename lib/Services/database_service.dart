import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:focus_app/Models/models.dart';

class DatabaseService extends ChangeNotifier {
  final String? uid;
  DatabaseService({this.uid});
  //collection ref
  final CollectionReference _focusCollection =
      FirebaseFirestore.instance.collection('Focus Users');

  final CollectionReference _focusUserSettings =
      FirebaseFirestore.instance.collection('Focus Settings');

  //initial setting of data
  Future setInitialUserData(
      String username, int focusTime, String feedback, int credits) async {
    return await _focusCollection.doc(uid).set(
      {
        'username': username,
        'focusTime': focusTime,
        'feedback': feedback,
        'credits': credits,
      },
    );
  }

  Future setInitialNotesCollection() {
    return _focusCollection
        .doc(uid)
        .collection('notes')
        .doc()
        .set({'title': 'Focus Notes', 'content': 'Welcome to Focus Notes'});
  }

  //initial setting of settings
  Future setInitialSettings(int pomos, int minutes, int seconds,
      int breakMinutes, bool water, bool ergo, bool food, bool bio) async {
    return await _focusUserSettings.doc(uid).set({
      'pomos': pomos,
      'minutes': minutes,
      'seconds': seconds,
      'break': breakMinutes,
      'water': water,
      'ergo': ergo,
      'food': food,
      'bio': bio,
    });
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

  int? _minutes;
  int get minutes => _minutes!;

  // update focusTime
  Future<void> updateFocusTime(String uid, int time) {
    return _focusCollection
        .doc(uid)
        .update({'focusTime': time})
        .then((value) => print("FocusTime Updated"))
        .catchError((error) => print("Faield to update focusTime: $error"));
  }

  // get FocusTime
  Future<int> getFocusTime(String uid) {
    return _focusCollection.doc(uid).get().then((DocumentSnapshot snapshot) {
      try {
        int focusTime = snapshot.get(FieldPath(['focusTime']));
        print(focusTime);
        return focusTime;
      } on StateError catch (e) {
        print(e.toString());
        return 0;
      }
    });
  }

  //updating username
  Future<void> updateUsername(String uid, String username) {
    return _focusCollection
        .doc(uid)
        .update({'username': username})
        .then((value) => print("Username updated"))
        .catchError((error) => print("Failed to update username: $error"));
  }

  //get feedback
  Future<String?> getFeedBack(String uid) {
    return _focusCollection.doc(uid).get().then((DocumentSnapshot snapshot) {
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
    return _focusCollection
        .doc(uid)
        .update({'feedback': feedback})
        .then((value) => print("Feedback updated"))
        .catchError((error) => print("Failed to update feedback: $error"));
  }

  //deleting userdata
  Future<void> deleteUser() {
    return _focusCollection
        .doc(uid)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  //deleting user settings
  Future<void> deleteUserSettings() {
    return _focusUserSettings
        .doc(uid)
        .delete()
        .then((value) => print("User Settings Deleted"))
        .catchError((error) => print("Failed to delete user settings: $error"));
  }

  //get seconds
  Future<int> getSeconds(String uid) {
    return _focusUserSettings.doc(uid).get().then((DocumentSnapshot snapshot) {
      try {
        var seconds = snapshot.get(FieldPath(['seconds']));
        print(seconds);
        return seconds;
      } on StateError catch (e) {
        print(e.toString());
        return 0;
      }
    });
  }

  //update seconds
  Future<void> updateSeconds(int seconds, String uid) {
    return _focusUserSettings
        .doc(uid)
        .update({'seconds': seconds})
        .then((value) => print("Seconds updated"))
        .catchError((error) => print("Failed to update seconds: $error"));
  }

  //get minutes
  Future<int> getMinutes(String uid) {
    return _focusUserSettings.doc(uid).get().then((DocumentSnapshot snapshot) {
      try {
        var minutes = snapshot.get(FieldPath(['minutes']));
        print(minutes);
        return minutes;
      } on StateError catch (e) {
        print(e.toString());
        return 25;
      }
    });
  }

  //update minutes
  Future<void> updateMinutes(int minutes, String uid) {
    return _focusUserSettings
        .doc(uid)
        .update({'minutes': minutes})
        .then((value) => print("Minutes updated"))
        .catchError((error) => print("Failed to update minutes: $error"));
  }

  //get pomos
  Future<int> getPomos(String uid) {
    return _focusUserSettings.doc(uid).get().then((DocumentSnapshot snapshot) {
      try {
        var pomos = snapshot.get(FieldPath(['pomos']));
        print(pomos);
        return pomos;
      } on StateError catch (e) {
        print(e.toString());
        return 4;
      }
    });
  }

  //update pomos
  Future<void> updatePomos(int pomos, String uid) {
    return _focusUserSettings
        .doc(uid)
        .update({'pomos': pomos})
        .then((value) => print("Pomos updated"))
        .catchError((error) => print("Failed to update pomos: $error"));
  }

  //get breaKminutes
  Future<int> getBreakMinutes(String uid) {
    return _focusUserSettings.doc(uid).get().then((DocumentSnapshot snapshot) {
      try {
        var breakMinutes = snapshot.get(FieldPath(['break']));
        print(breakMinutes);
        return breakMinutes;
      } on StateError catch (e) {
        print(e.toString());
        return 5;
      }
    });
  }

  //update breakMinutes
  Future<void> updateBreakMinutes(int breakMinutes, String uid) {
    return _focusUserSettings
        .doc(uid)
        .update({'break': breakMinutes})
        .then((value) => print("BreakMinutes updated"))
        .catchError((error) => print("Failed to update breakMinutes: $error"));
  }

  //get waterBreak
  Future<bool> getWaterBreak(String uid) {
    return _focusUserSettings.doc(uid).get().then((DocumentSnapshot snapshot) {
      try {
        bool waterBreak = snapshot.get(FieldPath(['water']));
        print(waterBreak);
        return waterBreak;
      } on StateError catch (e) {
        print(e.toString());
        return true;
      }
    });
  }

  //update waterBreak
  Future<void> updateWaterBreak(bool water, String uid) {
    return _focusUserSettings
        .doc(uid)
        .update({'water': water})
        .then((value) => print("Water break updated"))
        .catchError((error) => print("Failed to update water break: $error"));
  }

  //get ergonomicBreak
  Future<bool> getErgonomicBreak(String uid) {
    return _focusUserSettings.doc(uid).get().then((DocumentSnapshot snapshot) {
      try {
        bool ergoBreak = snapshot.get(FieldPath(['ergo']));
        print(ergoBreak);
        return ergoBreak;
      } on StateError catch (e) {
        print(e.toString());
        return true;
      }
    });
  }

  //update ergonomicBreak
  Future<void> updateErgoBreak(bool ergo, String uid) {
    return _focusUserSettings
        .doc(uid)
        .update({'ergo': ergo})
        .then((value) => print("Ergo break updated"))
        .catchError((error) => print("Failed to update ergo break: $error"));
  }

  //get foodBreak
  Future<bool> getFoodBreak(String uid) {
    return _focusUserSettings.doc(uid).get().then((DocumentSnapshot snapshot) {
      try {
        bool foodBreak = snapshot.get(FieldPath(['food']));
        print(foodBreak);
        return foodBreak;
      } on StateError catch (e) {
        print(e.toString());
        return true;
      }
    });
  }

  //update food break
  Future<void> updateFoodBreak(bool food, String uid) {
    return _focusUserSettings
        .doc(uid)
        .update({'food': food})
        .then((value) => print("Food break update"))
        .catchError((error) => print("Failed to update food break: $error"));
  }

  //get bioBreak
  Future<bool> getBioBreak(String uid) {
    return _focusUserSettings.doc(uid).get().then((DocumentSnapshot snapshot) {
      try {
        bool bioBreak = snapshot.get(FieldPath(['bio']));
        print(bioBreak);
        return bioBreak;
      } on StateError catch (e) {
        print(e.toString());
        return true;
      }
    });
  }

  //update food break
  Future<void> updateBioBreak(bool bio, String uid) {
    return _focusUserSettings
        .doc(uid)
        .update({'bio': bio})
        .then((value) => print("Bio break update"))
        .catchError((error) => print("Failed to update bio break: $error"));
  }

  // add notes
  Future<void> addNotes(String title, String content) {
    return _focusCollection.doc(uid).collection('notes').add({
      'title': title,
      'content': content,
    });
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

  //user settings from snapshot
  FocusUserSettings _userSettingsFromSnap(DocumentSnapshot snapshot) {
    return FocusUserSettings(
      uid: uid,
      pomos: snapshot.get(FieldPath(['pomos'])),
      minutes: snapshot.get(FieldPath(['minutes'])),
      seconds: snapshot.get(FieldPath(['seconds'])),
      breakMinutes: snapshot.get(FieldPath(['break'])),
      water: snapshot.get(FieldPath(['water'])),
      ergo: snapshot.get(FieldPath(['ergo'])),
      food: snapshot.get(FieldPath(['food'])),
      bio: snapshot.get(FieldPath(['bio'])),
    );
  }

  //notes data from snapshot
  FocusNotes _userNotesFromSnap(DocumentSnapshot snapshot) {
    return FocusNotes(
      title: snapshot.get(FieldPath(['title'])),
      content: snapshot.get(FieldPath(['content'])),
    );
  }

  //get notes doc strem
  Stream<FocusNotes> get notesData {
    return _focusCollection
        .doc(uid)
        .collection('notes')
        .doc()
        .snapshots()
        .map(_userNotesFromSnap);
  }

  // get user doc stream
  Stream<FocusUserData> get userData {
    return _focusCollection.doc(uid).snapshots().map(_userDataFromSnap);
  }

  Stream<QuerySnapshot> get notesQuery {
    return _focusCollection.doc(uid).collection('notes').snapshots();
  }

  //get user settings stream
  Stream<FocusUserSettings> get userSettings {
    return _focusUserSettings.doc(uid).snapshots().map(_userSettingsFromSnap);
  }

  List<FocusRanking> _focusRankingUsers(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FocusRanking(
        username: doc['username'] ?? '',
        focusTime: doc['focusTime'] ?? 0,
      );
    }).toList();
  }

  Stream<List<FocusRanking>> get ranking {
    return _focusCollection
        .orderBy('focusTime', descending: true)
        .snapshots()
        .map(_focusRankingUsers);
  }
}
