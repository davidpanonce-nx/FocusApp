import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  //collection ref
  final CollectionReference userdata =
      FirebaseFirestore.instance.collection('Focus Users');

  Future updateUserData(String username, String focusTime) async {
    return await userdata.doc(uid).set({
      'username': username,
      'focusTime': focusTime,
    });
  }
}
