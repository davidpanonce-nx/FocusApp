import 'package:flutter/material.dart';

class MainLoading extends StatelessWidget {
  const MainLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        padding: EdgeInsets.fromLTRB(15, 45, 15, 45),
        child: Image.asset('assets/logo1.png', fit: BoxFit.contain),
      ),
    );
  }
}
