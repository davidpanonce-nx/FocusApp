import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';

class BreakSystem extends StatelessWidget {
  const BreakSystem({Key? key}) : super(key: key);

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
            child: Image.asset('assets/ChangeitUp.png'),
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
                    text: 'Change it up',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        '\n\nUnlike other apps, Focus allows you to customize\nthe activities you want to do during breaks, instead\nof being a couch potato bingin on the infinite social\nmedia feed. As well as customize\nhow the app looks.',
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
