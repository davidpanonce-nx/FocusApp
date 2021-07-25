import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:focus_app/Components/constants.dart';

import 'package:focus_app/wrapper.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: primary),
              ),
              SvgPicture.asset(
                'assets/stack-1.svg',
                fit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 30, 15, 45),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Image.asset('assets/Logo.png'),
                    ),
                    Expanded(
                      flex: 30,
                      child: Stack(
                        children: [
                          Positioned(
                            right: screenSize / 2 - 50,
                            child: Image.asset(
                              'assets/BG-1.png',
                              width: 200,
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            left: screenSize / 2 - 50,
                            top: 130,
                            child: Image.asset(
                              'assets/BG-2.png',
                              width: 200,
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            right: screenSize / 2 - 30,
                            top: 230,
                            child: Image.asset(
                              'assets/BG-3.png',
                              width: 200,
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          Text(
                            'Welcome to Focus',
                            style: Theme.of(context).primaryTextTheme.headline1,
                          ),
                          Text(
                            'Study with no distractions! Learn how to focus\nwith FOCUS',
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () => {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Wrapper(),
                            ),
                          ),
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            primary: secondaryVariant,
                            minimumSize: Size(350, 0)),
                        child: Text(
                          'Continue',
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
            ],
          ),
        ),
      ),
    );
  }
}
