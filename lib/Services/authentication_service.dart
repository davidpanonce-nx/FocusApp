import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_app/Services/database_service.dart';

class AuthServices with ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = '';
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool _recentLogin = false;
  bool get recentLogin => _recentLogin;
  String _reauthErrorMessage = '';
  String get reauthErrorMessage => _reauthErrorMessage;
  bool _reAuthSucess = true;
  bool get reAuthSucces => _reAuthSucess;
  bool _deleteSuccess = true;
  bool get deleteSucess => _deleteSuccess;
  bool _resetPasswordSuccess = true;
  bool get resetPasswordSuccess => _resetPasswordSuccess;

  Future register(String email, String password, String username) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = authResult.user;
      setLoading(false);

      //create a  new document for each user
      await DatabaseService(uid: user!.uid)
          .setInitialUserData(username, 0, 'default feedback', 50);
      await DatabaseService(uid: user.uid)
          .setInitialSettings(4, 25, 0, 5, true, true, true, true);
      await DatabaseService(uid: user.uid).setInitialNotesCollection();
      return user;
    } on SocketException {
      setLoading(false);
      setMessage("No internet, please connect to the internet");
    } catch (e) {
      setLoading(false);
      setMessage(e.toString());
    }
    notifyListeners();
  }

  Future login(String email, String password) async {
    setLoading(true);
    try {
      UserCredential authResult = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      setLoading(false);
      return user;
    } on SocketException {
      setLoading(false);
      setMessage("No internet, please connect to the internet");
    } catch (e) {
      setLoading(false);
      var message = e.toString();
      print(message.substring(message.indexOf(' '), message.length));
      setMessage(message.substring(message.indexOf(' '), message.length));
    }
    notifyListeners();
  }

  Future logout() async {
    await firebaseAuth.signOut();
  }

  //deleting user account
  Future deleteUser(String uid) async {
    try {
      setRecentLogin(true);
      await firebaseAuth.currentUser!.delete();
      await DatabaseService(uid: uid).deleteUser();
      await DatabaseService(uid: uid).deleteUserSettings();
      setSucessDelete(true);
    } on FirebaseAuthException catch (e) {
      setRecentLogin(false);
      setSucessDelete(false);
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  //reauth
  Future reAuthenticate(String email, String password) async {
    try {
      // Create a credential
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      // Reauthenticate
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);
      setSuccessReauth(true);
      print("Successful");
    } catch (e) {
      setSuccessReauth(false);
      var message = e.toString();
      print(message.substring(message.indexOf(' '), message.length));
      reauthSetMessage(message);
    }
  }

  Future updatePassword(String newpassword) async {
    try {
      setRecentLogin(true);
      await firebaseAuth.currentUser!.updatePassword(newpassword);
      setSuccessResetPass(true);
    } on FirebaseAuthException catch (e) {
      setRecentLogin(false);
      setSuccessResetPass(false);
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  void setLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setRecentLogin(val) {
    _recentLogin = val;
    notifyListeners();
  }

  void reauthSetMessage(message) {
    _reauthErrorMessage = message;
    notifyListeners();
  }

  void setSuccessReauth(val) {
    _reAuthSucess = val;
    notifyListeners();
  }

  void setSucessDelete(val) {
    _deleteSuccess = val;
    notifyListeners();
  }

  void setSuccessResetPass(val) {
    _resetPasswordSuccess = val;
    notifyListeners();
  }

  Stream<User> get user {
    return firebaseAuth.authStateChanges().map((event) => event!);
  }

  //getting something in referrence to our model
  // Stream<User> get user {
  //   return firebaseAuth.authStateChanges().map(_userFromFirebase);
  // }
}
