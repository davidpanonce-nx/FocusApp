import 'package:flutter/material.dart';
import 'package:focus_app/Screens/login.dart';
import 'package:focus_app/Screens/register/register.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isToggle = false;
  void toggleScreen() {
    setState(() {
      isToggle = !isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isToggle) {
      return RegisterCredentials(toggleScreen: toggleScreen);
    } else {
      return Login(toggleScreen: toggleScreen);
    }
  }
}
