import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Models/models.dart';
import 'package:focus_app/Screens/Main%20Features/Customize/customize.dart';
import 'package:focus_app/Screens/Main%20Features/Notes/notes.dart';
import 'package:focus_app/Screens/Main%20Features/Ranking/ranking.dart';
import 'package:focus_app/Screens/Main%20Features/Timer/timer.dart';

import 'package:focus_app/Services/authentication_service.dart';
import 'package:focus_app/Services/database_service.dart';
import 'package:focus_app/wrapper.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController? _usernameController;
  TextEditingController? _emailController;
  TextEditingController? _passwordController;
  TextEditingController? _newPasswordController;
  TextEditingController? _newPasswordReController;
  TextEditingController? _feedBackController;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;

  int seconds = 0;
  int minutes = 0;
  int pomos = 0;
  int breakMinutes = 0;
  int focusTime = 0;
  bool water = true;
  bool ergo = true;
  bool food = true;
  bool bio = true;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _newPasswordReController = TextEditingController();
    _feedBackController = TextEditingController();
    setValues();

    super.initState();
  }

  @override
  void dispose() {
    _usernameController!.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
    _newPasswordController!.dispose();
    _newPasswordReController!.dispose();
    _feedBackController!.dispose();
    super.dispose();
  }

  void _openDrawer() {
    _scaffoldkey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  void setValues() async {
    seconds = await DatabaseService().getSeconds(user!.uid);
    minutes = await DatabaseService().getMinutes(user!.uid);
    pomos = await DatabaseService().getPomos(user!.uid);
    breakMinutes = await DatabaseService().getBreakMinutes(user!.uid);
    water = await DatabaseService().getWaterBreak(user!.uid);
    ergo = await DatabaseService().getErgonomicBreak(user!.uid);
    food = await DatabaseService().getFoodBreak(user!.uid);
    bio = await DatabaseService().getBioBreak(user!.uid);
    focusTime = await DatabaseService().getFocusTime(user!.uid);
    SharedPreferences? _pref = await SharedPreferences.getInstance();
    _pref.setInt('seconds', seconds);
    _pref.setInt('minutes', minutes);
    _pref.setInt('pomos', pomos);
    _pref.setInt('pomoCounter', 0);
    _pref.setInt('breakMinutes', breakMinutes);
    _pref.setBool('water', water);
    _pref.setBool('ergo', ergo);
    _pref.setBool('food', food);
    _pref.setBool('bio', bio);
    _pref.setInt('focusTime', focusTime);
  }

  //Alert Dialog for editing username
  _displayDialogEditUsername(BuildContext context) async {
    final updateProvider = Provider.of<DatabaseService>(context, listen: false);

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: secondaryVariant,
            title: Text(
              'New Username',
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline1!
                  .copyWith(color: primary),
            ),
            content:
                Consumer<DatabaseService>(builder: (context, value, child) {
              return Form(
                key: _formKey1,
                child: TextFormField(
                  validator: (val) =>
                      val!.isNotEmpty ? null : "Username can't be blank",
                  controller: _usernameController,
                  onChanged: (val) {
                    if (_usernameController!.text.isEmpty) {
                      value.setFalse();
                    } else {
                      value.setTrue();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Please enter username here",
                    hintStyle:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: primaryVariant,
                              fontWeight: FontWeight.w500,
                            ),
                    suffixIcon: value.hastText
                        ? IconButton(
                            color: primary,
                            onPressed: () {
                              value.setFalse();
                              _usernameController!.clear();
                            },
                            icon: Icon(Icons.close),
                          )
                        : null,
                  ),
                ),
              );
            }),
            contentTextStyle:
                Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                      color: primaryVariant,
                      fontWeight: FontWeight.w500,
                    ),
            actions: <Widget>[
              new ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: primary,
                ),
                child: new Text(
                  'Save',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyText2!
                      .copyWith(color: secondaryVariant),
                ),
                onPressed: () async {
                  if (_formKey1.currentState!.validate()) {
                    updateProvider.updateUsername(
                      user!.uid,
                      _usernameController!.text.trim(),
                    );
                    _usernameController!.clear();
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }

  //Alert Dialog for Deleting Account
  _displayDialogDeleteUser(BuildContext context) async {
    final _authService = Provider.of<AuthServices>(context, listen: false);

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: secondaryVariant,
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'Are you sure you want to'),
                  TextSpan(
                    text: ' delete ',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline1!
                        .copyWith(color: Colors.redAccent, fontSize: 20),
                  ),
                  TextSpan(text: 'your account ?'),
                ],
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline1!
                    .copyWith(color: primary, fontSize: 20),
              ),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: primary,
                    ),
                    child: new Text(
                      'No',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .copyWith(color: secondaryVariant),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                  new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      primary: Colors.redAccent,
                    ),
                    child: new Text(
                      'Yes',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .copyWith(color: secondaryVariant),
                    ),
                    onPressed: () async {
                      await _authService.deleteUser(user!.uid);
                      _authService.recentLogin
                          ? print('User data and account deleted')
                          : _displayDialogReAuth(context);
                      if (_authService.deleteSucess) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  //Alert Dialog for Reauthenticating
  _displayDialogReAuth(BuildContext context) async {
    final _authService = Provider.of<AuthServices>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: secondaryVariant,
          title: Text(
            'Reauthenticate',
            style: Theme.of(context)
                .primaryTextTheme
                .headline1!
                .copyWith(color: Colors.redAccent),
            textAlign: TextAlign.center,
          ),
          content: Consumer<DatabaseService>(builder: (context, value, child) {
            return Form(
              key: _formKey2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: primary,
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (val) => val!.isNotEmpty
                        ? null
                        : "Please enter an email address",
                    onChanged: (val) {
                      if (_emailController!.text.isEmpty) {
                        value.setFalse();
                      } else {
                        value.setTrue();
                      }
                    },
                    cursorColor: primary,
                    style:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: primary,
                              fontWeight: FontWeight.w300,
                            ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: primaryVariant,
                        size: 20,
                      ),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      labelText: "Enter email here",
                      labelStyle: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .copyWith(
                            color: primaryVariant,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                      suffixIcon: value.hastText
                          ? IconButton(
                              color: primary,
                              onPressed: () {
                                value.setFalse();
                                _emailController!.clear();
                              },
                              iconSize: 20,
                              icon: Icon(Icons.close),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amberAccent)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amberAccent)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Password',
                    style:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: primary,
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: value.obscureText,
                    validator: (val) =>
                        val!.isNotEmpty ? null : "Please enter a password",
                    cursorColor: secondaryVariant,
                    style:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: primary,
                              fontWeight: FontWeight.w300,
                            ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                        color: primaryVariant,
                        size: 20,
                      ),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      labelText: "Enter password here",
                      labelStyle: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .copyWith(
                            color: primaryVariant,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          value.toggleObscure();
                        },
                        icon: value.obscureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        color: primary,
                        iconSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amberAccent)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amberAccent)),
                    ),
                  ),
                  // if (_authService.reauthErrorMessage != '')
                  //   Text(_authService.reauthErrorMessage),
                ],
              ),
            );
          }),
          contentTextStyle:
              Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                    color: primaryVariant,
                    fontWeight: FontWeight.w500,
                  ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: primary,
                  ),
                  child: new Text(
                    'Cancel',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2!
                        .copyWith(color: secondaryVariant),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                new ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: Colors.redAccent,
                  ),
                  child: new Text(
                    'Continue',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2!
                        .copyWith(color: secondaryVariant),
                  ),
                  onPressed: () async {
                    if (_formKey2.currentState!.validate()) {
                      await _authService.reAuthenticate(
                        _emailController!.text.trim(),
                        _passwordController!.text.trim(),
                      );
                      if (_authService.reAuthSucces) {
                        _emailController!.clear();
                        _passwordController!.clear();
                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  //Alert Dialog for Reset Password
  _displayDialogResetPassword(BuildContext context) async {
    final _authService = Provider.of<AuthServices>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: secondaryVariant,
          title: Text(
            'Reset Password',
            style: Theme.of(context)
                .primaryTextTheme
                .headline1!
                .copyWith(color: primary),
            textAlign: TextAlign.center,
          ),
          content: Consumer<DatabaseService>(builder: (context, value, child) {
            return Form(
              key: _formKey3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Password',
                    style:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: primary,
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: value.obscureNewText1,
                    validator: (val) =>
                        val!.isNotEmpty ? null : "Please enter new password",
                    cursorColor: secondaryVariant,
                    style:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: primary,
                              fontWeight: FontWeight.w300,
                            ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                        color: primaryVariant,
                        size: 20,
                      ),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      labelText: "Enter new password here",
                      labelStyle: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .copyWith(
                            color: primaryVariant,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          value.toggleNewObscure1();
                        },
                        icon: value.obscureNewText1
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        color: primary,
                        iconSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amberAccent)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amberAccent)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Re-Enter New Password',
                    style:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: primary,
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _newPasswordReController,
                    obscureText: value.obscureNewText2,
                    validator: (val) =>
                        val != _newPasswordController!.text.trim()
                            ? "Password doesn't match"
                            : null,
                    cursorColor: secondaryVariant,
                    style:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: primary,
                              fontWeight: FontWeight.w300,
                            ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.password,
                        color: primaryVariant,
                        size: 20,
                      ),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      labelText: "Re-enter new password here",
                      labelStyle: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .copyWith(
                            color: primaryVariant,
                            fontWeight: FontWeight.w300,
                            fontSize: 12,
                          ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          value.toggleNewObscure2();
                        },
                        icon: value.obscureNewText2
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        color: primary,
                        iconSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greenVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amberAccent)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amberAccent)),
                    ),
                  ),
                ],
              ),
            );
          }),
          contentTextStyle:
              Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                    color: primaryVariant,
                    fontWeight: FontWeight.w500,
                  ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: primary,
                  ),
                  child: new Text(
                    'Cancel',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2!
                        .copyWith(color: secondaryVariant),
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                new ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    primary: Colors.redAccent,
                  ),
                  child: new Text(
                    'Continue',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2!
                        .copyWith(color: secondaryVariant),
                  ),
                  onPressed: () async {
                    if (_formKey3.currentState!.validate()) {
                      await _authService
                          .updatePassword(_newPasswordController!.text.trim());
                      _authService.recentLogin
                          ? print('Done')
                          : _displayDialogReAuth(context);
                      if (_authService.resetPasswordSuccess) {
                        _newPasswordController!.clear();
                        _newPasswordReController!.clear();
                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  //Alert dialog for Give Feedback
  _displayDialogFeedBack(BuildContext context) async {
    final updateProvider = Provider.of<DatabaseService>(context, listen: false);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: secondaryVariant,
            title: Text(
              'We value your feedback',
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline1!
                  .copyWith(color: primary),
              textAlign: TextAlign.center,
            ),
            content:
                Consumer<DatabaseService>(builder: (context, value, child) {
              return Form(
                key: _formKey4,
                child: TextFormField(
                  minLines: 5,
                  maxLines: 10,
                  validator: (val) =>
                      val!.isNotEmpty ? null : "Feedback can't be blank",
                  controller: _feedBackController,
                  decoration: InputDecoration(
                    hintText: "Type here",
                    hintStyle:
                        Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                              color: primaryVariant,
                              fontWeight: FontWeight.w500,
                            ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryVariant),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                  ),
                ),
              );
            }),
            contentTextStyle:
                Theme.of(context).primaryTextTheme.bodyText2!.copyWith(
                      color: primary,
                      fontWeight: FontWeight.w500,
                    ),
            actions: <Widget>[
              new ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  primary: Colors.redAccent,
                ),
                child: new Text(
                  'Submit',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .bodyText2!
                      .copyWith(color: secondaryVariant),
                ),
                onPressed: () async {
                  if (_formKey4.currentState!.validate()) {
                    updateProvider.updateFeedback(
                      user!.uid,
                      _feedBackController!.text.trim(),
                    );
                    _feedBackController!.clear();
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }

  //Alert Dialog For feedback which was already done
  _displayDialogFeedBackCheck(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: secondaryVariant,
            title: RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: 'You already provided us with your feedback.'),
                  TextSpan(
                    text: ' Thank You !',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline1!
                        .copyWith(color: Colors.redAccent, fontSize: 20),
                  ),
                ],
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline1!
                    .copyWith(color: primary, fontSize: 20),
              ),
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginProvider = Provider.of<AuthServices>(context);
    final updateProvider = Provider.of<DatabaseService>(context, listen: false);

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldkey,
          drawer: Container(
            width: size.width / 2,
            child: Drawer(
              child: Container(
                decoration: BoxDecoration(color: primaryVariant),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: (size.width / 2) - 50),
                      child: IconButton(
                        onPressed: _closeDrawer,
                        icon: Icon(Icons.close),
                        color: secondaryVariant,
                        iconSize: size.width / 10,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: size.width / 3.5,
                      height: size.width / 3.5,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset('assets/icon.png'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: StreamBuilder<FocusUserData>(
                        stream: DatabaseService(uid: user!.uid).userData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            FocusUserData data = snapshot.data!;
                            return Text(
                              data.username!,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: secondaryVariant, fontSize: 18),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: primary,
                      height: 0,
                    ),
                    Card(
                      color: primary,
                      child: ListTile(
                        onTap: () {
                          _displayDialogEditUsername(context);
                        },
                        leading: Icon(
                          Icons.person,
                          color: secondaryVariant,
                        ),
                        title: Text(
                          'Edit Username',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(color: secondaryVariant),
                        ),
                      ),
                    ),
                    Divider(
                      color: primary,
                      height: 0,
                    ),
                    Card(
                      color: primary,
                      child: ListTile(
                        onTap: () {
                          _displayDialogResetPassword(context);
                        },
                        leading: Icon(
                          Icons.replay,
                          color: secondaryVariant,
                        ),
                        title: Text(
                          'Reset Password',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                color: secondaryVariant,
                              ),
                        ),
                      ),
                    ),
                    Divider(
                      color: primary,
                      height: 0,
                    ),
                    Card(
                      color: primary,
                      child: ListTile(
                        onTap: () => _displayDialogDeleteUser(context),
                        leading: Icon(
                          Icons.delete,
                          color: secondaryVariant,
                        ),
                        title: Text(
                          'Delete Account',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(color: secondaryVariant),
                        ),
                      ),
                    ),
                    Divider(
                      color: primary,
                      height: 0,
                    ),
                    Card(
                      color: primary,
                      child: ListTile(
                        onTap: () async {
                          var feedback =
                              await updateProvider.getFeedBack(user!.uid);
                          if (feedback != 'default feedback') {
                            _displayDialogFeedBackCheck(context);
                          } else {
                            _displayDialogFeedBack(context);
                          }
                        },
                        leading: Icon(
                          Icons.feedback,
                          color: secondaryVariant,
                        ),
                        title: Text(
                          'Give Feedback',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(color: secondaryVariant),
                        ),
                      ),
                    ),
                    Divider(
                      color: primary,
                      height: 0,
                    ),
                    SizedBox(),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: secondaryVariant,
                      ),
                      title: Text(
                        'Logout',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(color: secondaryVariant),
                      ),
                      onTap: () async {
                        setState(() {
                          loginProvider.logout().whenComplete(() =>
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Wrapper())));
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: greenVariant),
              width: size.width,
              height: size.height,
              padding: EdgeInsets.fromLTRB(15, 15, 15, 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _openDrawer,
                        icon: Icon(
                          Icons.menu,
                          color: primary,
                          size: size.width / 10,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/pngegg.png',
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                          StreamBuilder<FocusUserData>(
                            stream: DatabaseService(uid: user!.uid).userData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                FocusUserData data = snapshot.data!;
                                return Text(
                                  data.credits!.toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline1!
                                      .copyWith(
                                        color: primary,
                                        fontSize: 18,
                                      ),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Center(
                    child: Text(
                      'Menu',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline1!
                          .copyWith(color: primary, fontSize: 30),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PomodoroTimer(
                                                key: UniqueKey(),
                                              )));
                                },
                                child: Image.asset(
                                  'assets/Timer.png',
                                  width: size.width / 3,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Timer',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2!
                                    .copyWith(color: primary, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width / 7,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Notes()));
                                },
                                child: Image.asset(
                                  'assets/Notes.png',
                                  width: size.width / 4,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Notes',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2!
                                    .copyWith(color: primary, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Ranking(key: UniqueKey())));
                                },
                                child: Image.asset(
                                  'assets/Trophy.png',
                                  width: size.width / 4,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Ranking',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2!
                                    .copyWith(color: primary, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width / 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Customize()));
                                },
                                child: Image.asset(
                                  'assets/Custom.png',
                                  width: size.width / 4,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Customize',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText2!
                                    .copyWith(color: primary, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
