import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Models/models.dart';
import 'package:focus_app/Screens/mainDashboard.dart';
import 'package:focus_app/Services/database_service.dart';

class Customize extends StatefulWidget {
  const Customize({Key? key}) : super(key: key);

  @override
  _CustomizeState createState() => _CustomizeState();
}

class _CustomizeState extends State<Customize> {
  bool defaultColor = true;
  bool scheme1 = false;
  bool scheme2 = false;
  bool scheme3 = false;

  bool defaultFont = true;
  bool font1 = false;
  bool font2 = false;
  bool font3 = false;
  int? currentCreds;
  String font = 'Nunito';
  Color primary1 = Color(colors[0]);

  @override
  void initState() {
    super.initState();
  }

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: primary1,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 45),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Dashboard(key: UniqueKey())));
                        },
                        icon: Image.asset(
                          'assets/pink-button.png',
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
                          SizedBox(
                            width: 10,
                          ),
                          StreamBuilder<FocusUserData>(
                            stream: DatabaseService(uid: user!.uid).userData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                FocusUserData data = snapshot.data!;
                                currentCreds = data.credits;
                                print(currentCreds);
                                return Text(
                                  data.credits!.toString(),
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline1!
                                      .copyWith(
                                        color: secondaryVariant,
                                        fontSize: 18,
                                        fontFamily: font,
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
                  Text(
                    'Market Place',
                    style:
                        Theme.of(context).primaryTextTheme.headline1!.copyWith(
                              color: secondary,
                              fontFamily: font,
                            ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Text(
                    'THEMES',
                    style:
                        Theme.of(context).primaryTextTheme.headline1!.copyWith(
                              color: secondary,
                              fontFamily: font,
                            ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: defaultColor
                                    ? null
                                    : () {
                                        setState(() {
                                          scheme1 = false;
                                          scheme2 = false;
                                          scheme3 = false;
                                          primary1 = Color(colors[0]);

                                          defaultColor = true;
                                        });
                                      },
                                child: Image.asset('assets/Default.png'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Default',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline1!
                                    .copyWith(
                                      color: secondaryVariant,
                                      fontSize: 18,
                                      fontFamily: font,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: scheme1
                                    ? null
                                    : () async {
                                        setState(() {
                                          defaultColor = false;
                                          scheme2 = false;
                                          scheme3 = false;
                                          primary1 = Color(0xff4C4372);
                                          scheme1 = true;
                                        });
                                      },
                                child: Image.asset('assets/Scheme1.png'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/pngegg.png',
                                    fit: BoxFit.cover,
                                    scale: 2,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '0',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1!
                                        .copyWith(
                                          color: secondaryVariant,
                                          fontSize: 18,
                                          fontFamily: font,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: scheme2
                                    ? null
                                    : () {
                                        setState(() {
                                          defaultColor = false;
                                          scheme1 = false;
                                          scheme3 = false;
                                          primary1 = Color(0xff187970);
                                          scheme2 = true;
                                        });
                                      },
                                child: Image.asset('assets/Scheme2.png'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/pngegg.png',
                                      fit: BoxFit.cover,
                                      scale: 2,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '0',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1!
                                          .copyWith(
                                            color: secondaryVariant,
                                            fontSize: 18,
                                            fontFamily: font,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: scheme3
                                    ? null
                                    : () async {
                                        setState(() {
                                          defaultColor = false;
                                          scheme1 = false;
                                          scheme2 = false;
                                          primary1 = Color(0xff012C3F);
                                          scheme3 = true;
                                        });
                                      },
                                child: Image.asset('assets/Scheme3.png'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      'assets/pngegg.png',
                                      fit: BoxFit.cover,
                                      scale: 2,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '0',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1!
                                          .copyWith(
                                            color: secondaryVariant,
                                            fontSize: 18,
                                            fontFamily: font,
                                          ),
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'FONTS',
                    style:
                        Theme.of(context).primaryTextTheme.headline1!.copyWith(
                              color: secondary,
                              fontFamily: font,
                            ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: defaultFont
                                    ? null
                                    : () {
                                        setState(() {
                                          font1 = false;
                                          font2 = false;
                                          font3 = false;
                                          font = 'Nunito';
                                          defaultFont = true;
                                        });
                                      },
                                child: Image.asset('assets/Nunito.png'),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Default - Nunito',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headline1!
                                    .copyWith(
                                      color: secondaryVariant,
                                      fontSize: 15,
                                      fontFamily: font,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: font1
                                    ? null
                                    : () async {
                                        setState(() {
                                          defaultFont = false;
                                          font2 = false;
                                          font3 = false;
                                          font = 'Lato';
                                          font1 = true;
                                        });
                                      },
                                child: Image.asset('assets/Lato.png'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/pngegg.png',
                                    fit: BoxFit.cover,
                                    scale: 3,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '0',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1!
                                        .copyWith(
                                          color: secondaryVariant,
                                          fontSize: 15,
                                          fontFamily: font,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '- Lato',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1!
                                        .copyWith(
                                          color: secondaryVariant,
                                          fontSize: 15,
                                          fontFamily: font,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: font2
                                    ? null
                                    : () async {
                                        setState(() {
                                          defaultFont = false;
                                          font1 = false;
                                          font3 = false;
                                          font = 'Roboto';
                                          font2 = true;
                                        });
                                      },
                                child: Image.asset('assets/Roboto.png'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/pngegg.png',
                                    fit: BoxFit.cover,
                                    scale: 3,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '0',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1!
                                        .copyWith(
                                          color: secondaryVariant,
                                          fontSize: 15,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '- Roboto',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1!
                                        .copyWith(
                                          color: secondaryVariant,
                                          fontSize: 15,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: font3
                                    ? null
                                    : () async {
                                        setState(() {
                                          defaultFont = false;
                                          font1 = false;
                                          font2 = false;
                                          font = 'OpenSans';
                                          font3 = true;
                                        });
                                      },
                                child: Image.asset('assets/OpenSans.png'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/pngegg.png',
                                    fit: BoxFit.cover,
                                    scale: 3,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '0',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1!
                                        .copyWith(
                                          color: secondaryVariant,
                                          fontSize: 15,
                                        ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '- OpenSans',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1!
                                        .copyWith(
                                          color: secondaryVariant,
                                          fontSize: 15,
                                        ),
                                  ),
                                ],
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
