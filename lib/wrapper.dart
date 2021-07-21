import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_app/Screens/mainDashboard.dart';

import 'package:focus_app/authentication.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return Authentication();
    } else {
      return Dashboard();
    }
  }
}
