import 'package:flutter/material.dart';

import 'package:focus_app/Screens/introductory/breaksystem.dart';
import 'package:focus_app/Screens/introductory/mainloading.dart';
import 'package:focus_app/Screens/introductory/note.dart';
import 'package:focus_app/Screens/introductory/notetaking.dart';
import 'package:focus_app/Screens/introductory/rankingsystem.dart';
import 'package:focus_app/Screens/introductory/ticktock.dart';
import 'package:focus_app/Screens/introductory/worksmart.dart';

import 'package:focus_app/Screens/registerlogin.dart';

class PageViewIntro extends StatefulWidget {
  const PageViewIntro({Key? key}) : super(key: key);

  @override
  _PageViewIntroState createState() => _PageViewIntroState();
}

class _PageViewIntroState extends State<PageViewIntro> {
  Color primary = Color(0xff35656F);
  Color primaryVariant = Color(0xff507881);
  Color secondary = Color(0xffF8DCC7);
  Color secondaryVariant = Color(0xffFBE8DA);
  Color greenVariant = Color(0xff9AD7BC);
  Color buttonColor = Color(0xffF1D5BD);

  PageController? pageController;
  Animatable<Color?>? background;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  void _initialize() {
    background = TweenSequence([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: primary,
          end: greenVariant,
        ),
      ),
      TweenSequenceItem(
        tween: ColorTween(
          begin: greenVariant,
          end: secondary,
        ),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween: ColorTween(
          begin: secondary,
          end: primary,
        ),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween: ColorTween(
          begin: primary,
          end: greenVariant,
        ),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween: ColorTween(
          begin: greenVariant,
          end: secondary,
        ),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween: ColorTween(
          begin: secondary,
          end: primary,
        ),
        weight: 1.0,
      ),
      TweenSequenceItem(
        tween: ColorTween(
          begin: primary,
          end: primary,
        ),
        weight: 1.0,
      ),
    ]);
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController!,
      builder: (context, child) {
        final color =
            pageController!.hasClients ? pageController!.page! / 7 : .0;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: background!.evaluate(
              AlwaysStoppedAnimation(color),
            ),
          ),
          child: child,
        );
      },
      child: PageView(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: <Widget>[
          MainLoading(),
          TickTock(),
          WorkSmart(),
          NoteTaking(),
          BreakSystem(),
          RankingSystem(),
          Note(),
          WelcomePage(),
        ],
      ),
    );
  }
}
