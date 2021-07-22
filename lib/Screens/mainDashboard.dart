import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Models/models.dart';

import 'package:focus_app/Services/authentication_service.dart';
import 'package:focus_app/Services/database_service.dart';

import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController? _usernameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController!.dispose();
    super.dispose();
  }

  void _openDrawer() {
    _scaffoldkey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  _displayDialogEditUsername(BuildContext context) async {
    final updateProvider = Provider.of<DatabaseService>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
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
                key: _formKey,
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
                  if (_formKey.currentState!.validate()) {
                    updateProvider.updateUsername(
                      user!.uid,
                      _usernameController!.text.trim(),
                    );
                    Navigator.of(context).pop();
                    _usernameController!.clear();
                  }
                },
              )
            ],
          );
        });
  }

  _displayDialogDeleteUser(BuildContext context) async {
    final _authService = Provider.of<AuthServices>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
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
                    },
                  ),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginProvider = Provider.of<AuthServices>(context);
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
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
                      loginProvider.logout();
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
                IconButton(
                  onPressed: _openDrawer,
                  icon: Icon(
                    Icons.menu,
                    color: primary,
                    size: size.width / 10,
                  ),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/Timer.png',
                              width: size.width / 4.5,
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
                            Image.asset(
                              'assets/Notes.png',
                              width: size.width / 5,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/Trophy.png',
                              width: size.width / 5,
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
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/NotifBlock.png',
                              width: size.width / 4,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Notif Block',
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
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/Custom.png',
                          width: size.width / 5,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
