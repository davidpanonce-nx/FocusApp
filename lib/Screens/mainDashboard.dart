import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';

import 'package:focus_app/Services/authentication_service.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldkey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginProvider = Provider.of<AuthServices>(context);
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
                    height: 20,
                  ),
                  IconButton(
                    onPressed: () async {
                      await loginProvider.logout();
                    },
                    icon: Icon(Icons.logout),
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
