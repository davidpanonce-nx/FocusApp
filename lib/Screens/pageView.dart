import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
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
