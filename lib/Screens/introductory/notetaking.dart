import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';

class NoteTaking extends StatelessWidget {
  const NoteTaking({Key? key}) : super(key: key);

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
            child: Image.asset('assets/NoteTaking.png'),
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
                    text: 'Note Taking',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text:
                        '\n\nTaking notes is a great way to help students identify\nthe importance of concepts covered in class.\nEffective note taking helps you to remember\ninformation and aids your understanding\nof the topic.',
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
