import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Models/models.dart';
import 'package:focus_app/Screens/mainDashboard.dart';

import 'package:focus_app/Screens/pageView.dart';

import 'package:focus_app/Services/authentication_service.dart';
import 'package:focus_app/Services/database_service.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(FocusApp());
}

class FocusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget();
          } else if (snapshot.hasData) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthServices>.value(
                  value: AuthServices(),
                ),
                StreamProvider<User?>.value(
                  value: AuthServices().user,
                  initialData: null,
                  catchError: (context, error) => null,
                ),
                ChangeNotifierProvider<DatabaseService>.value(
                  value: DatabaseService(),
                ),
                StreamProvider<List<FocusRanking>>.value(
                  value: DatabaseService().ranking,
                  initialData: [],
                ),
              ],
              child: MaterialApp(
                title: 'Focus App',
                theme: _buildFocusTheme(),
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  body: FocusHomepage(
                    title: 'Focus App',
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
    this.error,
  }) : super(key: key);
  final String? error;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.error),
            Text("Something went wrong. ${error!}"),
          ],
        ),
      ),
    );
  }
}

class FocusHomepage extends StatelessWidget {
  const FocusHomepage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return PageViewIntro();
    } else {
      return Dashboard();
    }
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
