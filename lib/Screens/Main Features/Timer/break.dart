import 'dart:async';

import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Screens/Main%20Features/Timer/timer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterBreak extends StatefulWidget {
  const WaterBreak({Key? key}) : super(key: key);

  @override
  _WaterBreakState createState() => _WaterBreakState();
}

class _WaterBreakState extends State<WaterBreak> {
  int? breakMinutes;
  int _breakMinutes = 0;
  int start = 0;
  int? pomoCount;

  void _startBreakTimer() async {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_breakMinutes < 1) {
          timer.cancel();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PomodoroTimer()));
        } else {
          _breakMinutes = _breakMinutes - 1;
        }
      });
    });
  }

  void getValues() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    breakMinutes = _prefs.getInt('breakMinutes');
    _breakMinutes = (breakMinutes! * 60);
    setState(() {
      start = _breakMinutes;
    });
  }

  String formatHHMMSS(int seconds) {
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String minuteStr = (minutes).toString().padLeft(2, '0');
    String secondStr = (seconds % 60).toString().padLeft(2, '0');
    return "$minuteStr:$secondStr";
  }

  @override
  void initState() {
    getValues();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: secondaryVariant,
            ),
          ),
          Image.asset(
            'assets/breakbg.png',
            fit: BoxFit.contain,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 75, 30, 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 10,
                ),
                Text(
                  'WATER BREAK',
                  style: Theme.of(context).primaryTextTheme.headline1!.copyWith(
                        color: primary,
                      ),
                ),
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  'assets/waterbreak.png',
                  fit: BoxFit.cover,
                  width: size.width * 0.75,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  formatHHMMSS(_breakMinutes),
                  style: Theme.of(context).primaryTextTheme.headline1!.copyWith(
                        color: Colors.black.withOpacity(0.60),
                        fontSize: 30,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PomodoroTimer()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: Colors.redAccent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Skip',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                color: primary,
                                fontSize: 17,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _startBreakTimer();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: greenVariant,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Start',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                color: primary,
                                fontSize: 17,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class ErgoBreak extends StatefulWidget {
  const ErgoBreak({Key? key}) : super(key: key);

  @override
  _ErgoBreakState createState() => _ErgoBreakState();
}

class _ErgoBreakState extends State<ErgoBreak> {
  int? breakMinutes;
  int _breakMinutes = 0;
  int start = 0;

  void _startBreakTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_breakMinutes < 1) {
          timer.cancel();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PomodoroTimer()));
        } else {
          _breakMinutes = _breakMinutes - 1;
        }
      });
    });
  }

  void getValues() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    breakMinutes = _prefs.getInt('breakMinutes');
    _breakMinutes = (breakMinutes! * 60);
    setState(() {
      start = _breakMinutes;
    });
  }

  String formatHHMMSS(int seconds) {
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String minuteStr = (minutes).toString().padLeft(2, '0');
    String secondStr = (seconds % 60).toString().padLeft(2, '0');
    return "$minuteStr:$secondStr";
  }

  @override
  void initState() {
    getValues();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: secondaryVariant,
            ),
          ),
          Image.asset(
            'assets/breakbg.png',
            fit: BoxFit.contain,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 75, 30, 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 10,
                ),
                Text(
                  'ERGONOMIC\nBREAK',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.headline1!.copyWith(
                        color: primary,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/ergobreak.png',
                  fit: BoxFit.cover,
                  width: size.width * 0.75,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  formatHHMMSS(_breakMinutes),
                  style: Theme.of(context).primaryTextTheme.headline1!.copyWith(
                        color: Colors.black.withOpacity(0.60),
                        fontSize: 30,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PomodoroTimer()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: Colors.redAccent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Skip',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                color: primary,
                                fontSize: 17,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _startBreakTimer();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: greenVariant,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Start',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                color: primary,
                                fontSize: 17,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class FoodBreak extends StatefulWidget {
  const FoodBreak({Key? key}) : super(key: key);

  @override
  _FoodBreakState createState() => _FoodBreakState();
}

class _FoodBreakState extends State<FoodBreak> {
  int? breakMinutes;
  int _breakMinutes = 0;
  int start = 0;

  void _startBreakTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_breakMinutes < 1) {
          timer.cancel();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PomodoroTimer()));
        } else {
          _breakMinutes = _breakMinutes - 1;
        }
      });
    });
  }

  void getValues() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    breakMinutes = _prefs.getInt('breakMinutes');
    _breakMinutes = (breakMinutes! * 60);
    setState(() {
      start = _breakMinutes;
    });
  }

  String formatHHMMSS(int seconds) {
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String minuteStr = (minutes).toString().padLeft(2, '0');
    String secondStr = (seconds % 60).toString().padLeft(2, '0');
    return "$minuteStr:$secondStr";
  }

  @override
  void initState() {
    getValues();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: secondaryVariant,
            ),
          ),
          Image.asset(
            'assets/breakbg.png',
            fit: BoxFit.contain,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 75, 30, 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 10,
                ),
                Text(
                  'FOOD BREAK',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.headline1!.copyWith(
                        color: primary,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  'assets/foodbreak.png',
                  fit: BoxFit.cover,
                  width: size.width * 0.75,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  formatHHMMSS(_breakMinutes),
                  style: Theme.of(context).primaryTextTheme.headline1!.copyWith(
                        color: Colors.black.withOpacity(0.60),
                        fontSize: 30,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PomodoroTimer()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: Colors.redAccent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Skip',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                color: primary,
                                fontSize: 17,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _startBreakTimer();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: greenVariant,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Start',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                color: primary,
                                fontSize: 17,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class BioBreak extends StatefulWidget {
  const BioBreak({Key? key}) : super(key: key);

  @override
  _BioBreakState createState() => _BioBreakState();
}

class _BioBreakState extends State<BioBreak> {
  int? breakMinutes;
  int _breakMinutes = 0;
  int start = 0;

  void _startBreakTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_breakMinutes < 1) {
          timer.cancel();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => PomodoroTimer()));
        } else {
          _breakMinutes = _breakMinutes - 1;
        }
      });
    });
  }

  void getValues() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    breakMinutes = _prefs.getInt('breakMinutes');
    _breakMinutes = (breakMinutes! * 60);
    setState(() {
      start = _breakMinutes;
    });
  }

  String formatHHMMSS(int seconds) {
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String minuteStr = (minutes).toString().padLeft(2, '0');
    String secondStr = (seconds % 60).toString().padLeft(2, '0');
    return "$minuteStr:$secondStr";
  }

  @override
  void initState() {
    getValues();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: secondaryVariant,
            ),
          ),
          Image.asset(
            'assets/breakbg.png',
            fit: BoxFit.contain,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 75, 30, 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 10,
                ),
                Text(
                  'BIO BREAK',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.headline1!.copyWith(
                        color: primary,
                      ),
                ),
                SizedBox(
                  height: 15,
                ),
                Image.asset(
                  'assets/biobreak.png',
                  fit: BoxFit.cover,
                  width: size.width * 0.70,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  formatHHMMSS(_breakMinutes),
                  style: Theme.of(context).primaryTextTheme.headline1!.copyWith(
                        color: Colors.black.withOpacity(0.60),
                        fontSize: 30,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PomodoroTimer()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: Colors.redAccent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Skip',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                color: primary,
                                fontSize: 17,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _startBreakTimer();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        primary: greenVariant,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Start',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2!
                              .copyWith(
                                color: primary,
                                fontSize: 17,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
