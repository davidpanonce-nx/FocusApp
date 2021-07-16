import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';

class TickTock extends StatelessWidget {
  const TickTock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(15, 60, 15, 45),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
          ),
          Expanded(
            flex: 4,
            child: Image.asset('assets/Clock.png'),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 6,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontFamily: 'Nunito',
                  color: primary,
                ),
                children: [
                  TextSpan(
                    text: 'Tick-Tock',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        '\n\nFocus is infused with Pomodoro technique which is a\nsimple yet effective tool for focused work with\nplanned breaks in between.',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
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
