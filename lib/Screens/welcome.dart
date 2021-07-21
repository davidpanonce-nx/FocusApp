import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Screens/mainDashboard.dart';
import 'package:focus_app/wrapper.dart';

class WelcomePageName extends StatelessWidget {
  final String? username;
  const WelcomePageName({Key? key, this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: primary),
          ),
          Image.asset(
            'assets/stack-3.png',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 30, 15, 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Image.asset('assets/Logo.png',
                      width: size.width - 150, fit: BoxFit.contain),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Image.asset('assets/Welcome-01.png',
                      width: size.width - 80, fit: BoxFit.contain),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Text(
                    'WELCOME\n${username!}!',
                    style:
                        Theme.of(context).primaryTextTheme.headline1!.copyWith(
                              fontSize: 30.0,
                            ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Image.asset('assets/Welcome-02.png',
                      width: size.width - 130, fit: BoxFit.contain),
                  SizedBox(
                    height: size.height / 100,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: buttonColor,
                        minimumSize: Size(size.width, 0)),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Next',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2!
                            .copyWith(color: primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
