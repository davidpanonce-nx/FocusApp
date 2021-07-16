import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Screens/register/register.dart';

import 'package:focus_app/Screens/register/register_email.dart';

void main() {
  runApp(FocusApp());
}

class FocusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus App',
      theme: _buildFocusTheme(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/registerEmail': (BuildContext context) => RegisterEmail(),
      },
      home: SafeArea(
        child: FocusHomepage(title: 'Focus App'),
      ),
    );
  }
}

class FocusHomepage extends StatelessWidget {
  const FocusHomepage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterCredentials(),
    );
  }
}

ThemeData _buildFocusTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: primary,
      primaryVariant: primaryVariant,
      secondary: secondary,
      secondaryVariant: secondaryVariant,
    ),
    primaryTextTheme: _buildFocusTextTheme(base.textTheme),
  );
}

TextTheme _buildFocusTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline1: base.headline1!.copyWith(
          fontSize: 25,
          fontWeight: FontWeight.w700,
          color: secondaryVariant,
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w300,
          color: secondaryVariant,
        ),
        bodyText2: base.bodyText2!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      )
      .apply(
        fontFamily: 'Nunito',
      );
}
