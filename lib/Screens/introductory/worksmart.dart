import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';

class WorkSmart extends StatelessWidget {
  const WorkSmart({Key? key}) : super(key: key);

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
            child: Image.asset('assets/WorkSmart.png'),
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
                    text: 'Work Smart',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        '\n\nStop avoiding or delaying a task. Work on it and\naccomplish it. There\'s nothing more satisfying than\nfinishing the things you need to do.\nThis app helps you do that!',
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
