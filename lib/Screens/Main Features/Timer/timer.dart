import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Screens/Main%20Features/Timer/break.dart';

import 'package:focus_app/Screens/Main%20Features/Timer/timerSettings.dart';
import 'package:focus_app/Screens/mainDashboard.dart';

import 'package:focus_app/Services/database_service.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

final user = FirebaseAuth.instance.currentUser;

class PomodoroTimer extends StatefulWidget {
  const PomodoroTimer({Key? key}) : super(key: key);

  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  bool started = false;
  int paused = 0;
  double percent = 1;
  int? start;
  int? seconds;
  int _start = 0;
  int stop = 0;
  int? pomoCount;
  int _pomoCount = 0;
  int? pomo;
  bool? water;
  bool? ergo;
  bool? food;
  bool? bio;
  int initialTime = 0;
  int _pomo = 0;
  bool _water = true;
  bool _ergo = true;
  bool _food = true;
  bool _bio = true;
  int? focusTime;
  int? prevFocusTime;

  String formatHHMMSS(int seconds) {
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String minuteStr = (minutes).toString().padLeft(2, '0');
    String secondStr = (seconds % 60).toString().padLeft(2, '0');
    return "$minuteStr:$secondStr";
  }

  void getValues() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    start = _prefs.getInt('minutes');
    seconds = _prefs.getInt('seconds');
    pomo = _prefs.getInt('pomos');
    pomoCount = _prefs.getInt('pomoCounter');
    water = _prefs.getBool('water');
    ergo = _prefs.getBool('ergo');
    food = _prefs.getBool('food');
    bio = _prefs.getBool('bio');
    focusTime = _prefs.getInt('focusTime');
    _start = (start! * 60) + seconds!;
    _pomoCount = pomoCount!;
    _pomo = pomo!;
    _water = water!;
    _ergo = ergo!;
    _food = food!;
    _bio = bio!;
    setPomoCount();

    if (_pomoCount > _pomo) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
    setState(() {
      initialTime = _start;
    });
  }

  void setPomoCount() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('pomoCounter', _pomoCount++);
  }

  void setFocusTime(int seconds) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('focusTime', seconds);
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

  void _startTimer() async {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_start < 1) {
          timer.cancel();
          updateFocusTime((initialTime * (pomoCount! + 1)) + focusTime!);
          _start = initialTime;
          setPomoCount();
          //selecting one break
          if (_water) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => WaterBreak()));
          }
          if (_ergo) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ErgoBreak()));
          }
          if (_food) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => FoodBreak()));
          }
          if (_bio) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => BioBreak()));
          }

          //selecting two breaks
          if (_water && _ergo) {
            if ((_pomoCount + 1) % 2 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WaterBreak()));
            } else {
              if ((_pomoCount + 1) / 2 == 1) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ErgoBreak()));
              }
            }
          } else if (_water && _food) {
            if ((_pomoCount + 1) % 2 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WaterBreak()));
            } else {
              if ((_pomoCount + 1) / 2 == 1) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => FoodBreak()));
              }
            }
          } else if (_water && _bio) {
            if ((_pomoCount + 1) % 2 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WaterBreak()));
            } else {
              if ((_pomoCount + 1) / 2 == 1) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BioBreak()));
              }
            }
          }

          //selecting two breaks
          if (_ergo && _food) {
            if ((_pomoCount + 1) % 2 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ErgoBreak()));
            } else {
              if ((_pomoCount + 1) / 2 == 1) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => FoodBreak()));
              }
            }
          } else if (_ergo && _bio) {
            if ((_pomoCount + 1) % 2 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ErgoBreak()));
            } else {
              if ((_pomoCount + 1) / 2 == 1) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BioBreak()));
              }
            }
          }

          //selecting two breaks
          if (_food && _bio) {
            if ((_pomoCount + 1) % 2 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FoodBreak()));
            } else {
              if ((_pomoCount + 1) / 2 == 1) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BioBreak()));
              }
            }
          }

          //selecting three breaks
          if (_water && _ergo && _food) {
            if ((_pomoCount) == 0 || (_pomoCount) % 3 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WaterBreak()));
            } else if ((_pomoCount + 2) % 3 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ErgoBreak()));
            } else {
              if ((_pomoCount + 1) % 3 == 0) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => FoodBreak()));
              }
            }
          } else if (_water && _food && _ergo) {
            if ((_pomoCount) == 0 || (_pomoCount) % 3 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WaterBreak()));
            } else if ((_pomoCount + 2) % 3 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FoodBreak()));
            } else {
              if ((_pomoCount + 1) % 3 == 0) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BioBreak()));
              }
            }
          } else if (_ergo && _food && _bio) {
            if ((_pomoCount) == 0 || (_pomoCount) % 3 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ErgoBreak()));
            } else if ((_pomoCount + 2) % 3 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FoodBreak()));
            } else {
              if ((_pomoCount + 1) % 3 == 0) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BioBreak()));
              }
            }
          }

          //selecting four
          if (_water && _ergo && _food && _bio) {
            if ((_pomoCount + 1) % 2 == 0 &&
                (_pomoCount + 1) % 3 != 0 &&
                (_pomoCount + 1) % 4 != 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WaterBreak()));
            } else if ((_pomoCount + 1) % 2 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ErgoBreak()));
            } else if ((_pomoCount + 1) % 3 == 0) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FoodBreak()));
            } else {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => BioBreak()));
            }
          }
        } else {
          if (paused == 0 && stop == 0) {
            _start = _start - 1;

            percent = (_start / initialTime);
          } else if (paused == 1 && stop == 0) {
            _start = _start;
            percent = (_start / initialTime);
          } else {
            _start = initialTime;

            timer.cancel();
          }
        }
      });
    });
  }

  void updateFocusTime(int time) async {
    await DatabaseService().updateFocusTime(user!.uid, time);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: secondaryVariant,
              ),
            ),
            Image.asset(
              'assets/clockBg.png',
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(30, 30, 15, 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()));
                        },
                        icon: Image.asset(
                          'assets/Blue-button.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Text(
                      'POMODORO TIMER',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline1!
                          .copyWith(
                            color: primary,
                          ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: greenVariant,
                        shape: BoxShape.circle,
                      ),
                      child: CircularPercentIndicator(
                        percent: percent,
                        lineWidth: 15,
                        radius: size.width * 0.70,
                        center: Text(
                          formatHHMMSS(_start),
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline1!
                              .copyWith(
                                color: Colors.black.withOpacity(0.70),
                                fontSize: 30,
                              ),
                        ),
                        animation: true,
                        animateFromLastPercent: true,
                        backgroundColor: Colors.black.withOpacity(0.20),
                        progressColor: primary,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      pomoCount.toString() + '/' + pomo.toString(),
                      style: Theme.of(context)
                          .primaryTextTheme
                          .bodyText2!
                          .copyWith(
                            color: primary,
                            fontSize: 20,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: size.height / 30,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            stop = 1;
                          },
                          child: Image.asset(
                            'assets/STOP.png',
                            fit: BoxFit.cover,
                            width: size.width / 8,
                          ),
                        ),
                        SizedBox(
                          width: size.height / 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_start == initialTime) {
                              paused = 0;
                              stop = 0;
                              _startTimer();
                            } else {
                              paused = 0;
                              stop = 0;
                            }
                          },
                          child: Image.asset(
                            'assets/PLAY.png',
                            fit: BoxFit.cover,
                            width: size.width / 10,
                          ),
                        ),
                        SizedBox(
                          width: size.height / 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            paused = 1;
                          },
                          child: Image.asset(
                            'assets/PAUSE.png',
                            fit: BoxFit.cover,
                            width: size.width / 8,
                          ),
                        ),
                        SizedBox(
                          width: size.height / 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PomodoroSettings()));
                          },
                          child: Image.asset(
                            'assets/EDIT.png',
                            fit: BoxFit.cover,
                            width: size.width / 8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
