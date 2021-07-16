import 'package:flutter/material.dart';

import 'package:focus_app/Components/constants.dart';

class Note extends StatelessWidget {
  const Note({Key? key}) : super(key: key);

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
            child: Image.asset('assets/Remember.png'),
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
                  color: secondary,
                ),
                children: [
                  TextSpan(
                    text: 'Remember',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        '\n\nMake sure to allow Focus to run in background\nthrough your phone battery or power management settings.',
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
