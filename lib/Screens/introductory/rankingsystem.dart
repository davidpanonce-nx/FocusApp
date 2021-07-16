import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';

class RankingSystem extends StatelessWidget {
  const RankingSystem({Key? key}) : super(key: key);

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
            child: Image.asset('assets/DoBetter.png'),
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
                    text: 'Do-Better',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        '\n\nA little competition wouldn\'t hurt. When things gets too easy it becomes boring and causes motivation to\nsuffer,while a competitive challenge, well\noutside our reach can be overwhelming.\nGreat competition is focused.',
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
