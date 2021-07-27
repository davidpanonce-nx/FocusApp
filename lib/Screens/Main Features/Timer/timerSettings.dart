import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Screens/Main%20Features/Timer/timer.dart';
import 'package:focus_app/Services/database_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PomodoroSettings extends StatefulWidget {
  const PomodoroSettings({Key? key}) : super(key: key);

  @override
  _PomodoroSettingsState createState() => _PomodoroSettingsState();
}

class _PomodoroSettingsState extends State<PomodoroSettings> {
  TextEditingController? _secondsController;
  TextEditingController? _minutesController;
  TextEditingController? _pomoController;
  TextEditingController? _breakminutesController;

  List<String> symbols = [',', '.', '-', ' '];

  bool secondsFocus = false;
  bool minutesFocus = false;
  bool pomosFocus = false;
  bool breakMinutesFocus = false;
  bool? waterCheck;
  bool? ergoCheck;
  bool? foodCheck;
  bool? bioCheck;

  int? seconds;
  int? minutes;
  int? pomos;
  int? breakMinutes;
  bool? water;
  bool? ergo;
  bool? food;
  bool? bio;
  late bool error;

  @override
  void initState() {
    _secondsController = TextEditingController();
    _minutesController = TextEditingController();
    _pomoController = TextEditingController();
    _breakminutesController = TextEditingController();
    error = false;
    getValues();

    super.initState();
  }

  @override
  void dispose() {
    _secondsController!.dispose();
    _minutesController!.dispose();
    _pomoController!.dispose();
    _breakminutesController!.dispose();

    super.dispose();
  }

  void getValues() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      seconds = _prefs.getInt('seconds');
      minutes = _prefs.getInt('minutes');
      pomos = _prefs.getInt('pomos');
      breakMinutes = _prefs.getInt('breakMinutes');
      water = _prefs.getBool('water');
      ergo = _prefs.getBool('ergo');
      food = _prefs.getBool('food');
      bio = _prefs.getBool('bio');
      waterCheck = water;
      ergoCheck = ergo;
      foodCheck = food;
      bioCheck = bio;
    });
  }

  void secondsToggle() {
    setState(() {
      secondsFocus = !secondsFocus;
    });
  }

  void minutesToggle() {
    setState(() {
      minutesFocus = !minutesFocus;
    });
  }

  void pomosToggle() {
    setState(() {
      pomosFocus = !pomosFocus;
    });
  }

  void breakMinutesFocusToggle() {
    setState(() {
      breakMinutesFocus = !breakMinutesFocus;
    });
  }

  void waterToggle() {
    setState(() {
      waterCheck = !waterCheck!;
    });
  }

  void ergoToggle() {
    setState(() {
      ergoCheck = !ergoCheck!;
    });
  }

  void foodToggle() {
    setState(() {
      foodCheck = !foodCheck!;
    });
  }

  void bioToggle() {
    setState(() {
      bioCheck = !bioCheck!;
    });
  }

  void errorToggle() {
    setState(() {
      error = !error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;

    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentScope = FocusScope.of(context);
          if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
            if (_secondsController!.text.isEmpty) {
              secondsFocus = false;
            } else {
              secondsFocus = true;
            }
            if (_minutesController!.text.isEmpty) {
              minutesFocus = false;
            } else {
              minutesFocus = true;
            }
            if (_pomoController!.text.isEmpty) {
              pomosFocus = false;
            } else {
              pomosFocus = true;
            }
            if (_breakminutesController!.text.isEmpty) {
              breakMinutesFocus = false;
            } else {
              breakMinutesFocus = true;
            }
          }
        },
        child: SafeArea(
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
                    margin: EdgeInsets.fromLTRB(45, 60, 45, 60),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'EDIT TIMER',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline1!
                              .copyWith(
                                color: primary,
                              ),
                        ),
                        SizedBox(
                          height: size.height / 30,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                          decoration: BoxDecoration(
                            color: greenVariant,
                            border: Border.all(
                              color: Colors.black.withOpacity(0.40),
                              width: 5,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Seconds',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1!
                                        .copyWith(
                                          color: primary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      secondsToggle();
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 30,
                                      padding: EdgeInsets.all(2),
                                      child: secondsFocus
                                          ? TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              autofocus: true,
                                              controller: _secondsController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: secondaryVariant,
                                                counterText: '',
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                              maxLength: 2,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    color: primary,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            )
                                          : Card(
                                              color: secondaryVariant,
                                              shadowColor: secondary,
                                              borderOnForeground: true,
                                              child: Text(
                                                seconds.toString(),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                      color: primary,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height / 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Minutes',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1!
                                        .copyWith(
                                          color: primary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      minutesToggle();
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 30,
                                      padding: EdgeInsets.all(2),
                                      child: minutesFocus
                                          ? TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              autofocus: true,
                                              controller: _minutesController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: secondaryVariant,
                                                counterText: '',
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                              maxLength: 2,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    color: primary,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            )
                                          : Card(
                                              color: secondaryVariant,
                                              shadowColor: secondary,
                                              borderOnForeground: true,
                                              child: Text(
                                                minutes.toString(),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                      color: primary,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height / 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pomo/Sessions',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1!
                                        .copyWith(
                                          color: primary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      pomosToggle();
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 30,
                                      padding: EdgeInsets.all(2),
                                      child: pomosFocus
                                          ? TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              autofocus: true,
                                              controller: _pomoController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: secondaryVariant,
                                                counterText: '',
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                              maxLength: 2,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    color: primary,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            )
                                          : Card(
                                              color: secondaryVariant,
                                              shadowColor: secondary,
                                              borderOnForeground: true,
                                              child: Text(
                                                pomos.toString(),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                      color: primary,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height / 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Break (mins)',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline1!
                                        .copyWith(
                                          color: primary,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      breakMinutesFocusToggle();
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 30,
                                      padding: EdgeInsets.all(2),
                                      child: breakMinutesFocus
                                          ? TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              autofocus: true,
                                              controller:
                                                  _breakminutesController,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: secondaryVariant,
                                                counterText: '',
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                ),
                                              ),
                                              maxLength: 2,
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    color: primary,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            )
                                          : Card(
                                              color: secondaryVariant,
                                              shadowColor: secondary,
                                              borderOnForeground: true,
                                              child: Text(
                                                breakMinutes.toString(),
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                      color: primary,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height / 40,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      'Selected Breaks',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1!
                                          .copyWith(
                                            color: primary,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Card(
                                          color: secondaryVariant,
                                          shadowColor: secondary,
                                          borderOnForeground: true,
                                          child: Text(
                                            'Water',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline1!
                                                .copyWith(
                                                  color: Colors.black
                                                      .withOpacity(0.70),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Transform.scale(
                                        scale: 1.8,
                                        child: Checkbox(
                                          side: BorderSide(
                                              color: Color(0xffBF8C60)),
                                          tristate: true,
                                          checkColor: greenVariant,
                                          activeColor: primary,
                                          value: waterCheck,
                                          onChanged: (val) => waterToggle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Card(
                                          color: secondaryVariant,
                                          shadowColor: secondary,
                                          borderOnForeground: true,
                                          child: Text(
                                            'Ergonomic',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline1!
                                                .copyWith(
                                                  color: Colors.black
                                                      .withOpacity(0.70),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Transform.scale(
                                        scale: 1.8,
                                        child: Checkbox(
                                          side: BorderSide(
                                              color: Color(0xffBF8C60)),
                                          tristate: true,
                                          checkColor: greenVariant,
                                          activeColor: primary,
                                          value: ergoCheck,
                                          onChanged: (val) => ergoToggle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Card(
                                          color: secondaryVariant,
                                          shadowColor: secondary,
                                          borderOnForeground: true,
                                          child: Text(
                                            'Food',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline1!
                                                .copyWith(
                                                  color: Colors.black
                                                      .withOpacity(0.70),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Transform.scale(
                                        scale: 1.8,
                                        child: Checkbox(
                                          side: BorderSide(
                                              color: Color(0xffBF8C60)),
                                          tristate: true,
                                          checkColor: greenVariant,
                                          activeColor: primary,
                                          value: foodCheck,
                                          onChanged: (val) => foodToggle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Card(
                                          color: secondaryVariant,
                                          shadowColor: secondary,
                                          borderOnForeground: true,
                                          child: Text(
                                            'Bio',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .headline1!
                                                .copyWith(
                                                  color: Colors.black
                                                      .withOpacity(0.70),
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Transform.scale(
                                        scale: 1.8,
                                        child: Checkbox(
                                          side: BorderSide(
                                              color: Color(0xffBF8C60)),
                                          tristate: true,
                                          checkColor: greenVariant,
                                          activeColor: primary,
                                          value: bioCheck,
                                          onChanged: (val) => bioToggle(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Note:Time should only contain integers and plese do select atleast one break',
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: Colors.redAccent,
                                          fontSize: 13,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: size.height / 100,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  SharedPreferences _prefs =
                                      await SharedPreferences.getInstance();

                                  if (secondsFocus) {
                                    var _seconds = int.tryParse(
                                            _secondsController!.text.trim()) ??
                                        seconds!;
                                    await DatabaseService()
                                        .updateSeconds(_seconds, user!.uid);
                                    await _prefs.setInt('seconds', _seconds);
                                  }

                                  if (minutesFocus) {
                                    var _minutes = int.tryParse(
                                            _minutesController!.text.trim()) ??
                                        minutes!;
                                    await DatabaseService()
                                        .updateMinutes(_minutes, user!.uid);
                                    await _prefs.setInt('minutes', _minutes);
                                  }
                                  if (pomosFocus) {
                                    var _pomo = int.tryParse(
                                            _pomoController!.text.trim()) ??
                                        pomos!;
                                    await DatabaseService()
                                        .updatePomos(_pomo, user!.uid);
                                    await _prefs.setInt('pomos', _pomo);
                                  }
                                  if (breakMinutesFocus) {
                                    var _breakMinutes = int.tryParse(
                                            _breakminutesController!.text
                                                .trim()) ??
                                        breakMinutes!;
                                    await DatabaseService().updateBreakMinutes(
                                        _breakMinutes, user!.uid);
                                    await _prefs.setInt(
                                        'breakMinutes', _breakMinutes);
                                  }
                                  if (water != waterCheck) {
                                    await DatabaseService().updateWaterBreak(
                                        waterCheck!, user!.uid);
                                    await _prefs.setBool('water', waterCheck!);
                                  }
                                  if (ergo != ergoCheck) {
                                    await DatabaseService()
                                        .updateErgoBreak(ergoCheck!, user!.uid);
                                    await _prefs.setBool('ergo', ergoCheck!);
                                  }
                                  if (food != foodCheck) {
                                    await DatabaseService()
                                        .updateFoodBreak(foodCheck!, user!.uid);
                                    await _prefs.setBool('food', foodCheck!);
                                  }
                                  if (bio != bioCheck) {
                                    await DatabaseService()
                                        .updateBioBreak(bioCheck!, user!.uid);
                                    await _prefs.setBool('bio', bioCheck!);
                                  }
                                  if (waterCheck == false &&
                                      ergoCheck == false &&
                                      foodCheck == false &&
                                      bioCheck == false) {
                                    await DatabaseService()
                                        .updateWaterBreak(true, user!.uid);
                                    await _prefs.setBool('water', true);
                                  }
                                },
                                child: Text('Save'),
                              ),
                              SizedBox(
                                height: size.height / 100,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  _secondsController!.clear();
                                  _minutesController!.clear();
                                  _pomoController!.clear();
                                  _breakminutesController!.clear();
                                  Navigator.pushReplacement(
                                      (context),
                                      MaterialPageRoute(
                                          builder: (context) => PomodoroTimer(
                                                key: UniqueKey(),
                                              )));
                                },
                                child: Image.asset(
                                    'assets/Blue-ButtonInverted.png',
                                    width: 40,
                                    fit: BoxFit.cover),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
