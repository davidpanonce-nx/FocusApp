import 'package:flutter/material.dart';
import 'package:focus_app/Components/constants.dart';
import 'package:focus_app/Models/models.dart';
import 'package:focus_app/Screens/mainDashboard.dart';

import 'package:provider/provider.dart';

class Ranking extends StatefulWidget {
  const Ranking({Key? key}) : super(key: key);

  @override
  _RankingState createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  String formatHHMMSS(int seconds) {
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String minuteStr = (minutes).toString();
    String secondStr = (seconds % 60).toString();

    return "$minuteStr.$secondStr min";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ranking = Provider.of<List<FocusRanking>>(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              color: primary,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 45),
              child: ranking.length != 0
                  ? Column(
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
                              'assets/pink-button.png',
                            ),
                          ),
                        ),
                        Text(
                          'Ranking',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline1!
                              .copyWith(color: secondary),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: EdgeInsets.all(size.width / 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    Text(
                                      ranking.length >= 2
                                          ? formatHHMMSS(
                                              ranking[1].focusTime ?? 0)
                                          : 'no-data',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1!
                                          .copyWith(
                                            color: secondaryVariant,
                                            fontSize: 17,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    Image.asset('assets/2nd.png'),
                                    SizedBox(
                                      height: size.height / 100,
                                    ),
                                    Text(
                                      ranking.length >= 2
                                          ? ranking[1].username ?? ''
                                          : 'no-data',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1!
                                          .copyWith(
                                            color: secondary,
                                            fontSize: 20,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '2nd',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1!
                                          .copyWith(
                                            color: secondaryVariant,
                                            fontSize: 20,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    Text(
                                      ranking.length >= 1
                                          ? formatHHMMSS(
                                              ranking[0].focusTime ?? 0)
                                          : 'no-data',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1!
                                          .copyWith(
                                            color: secondary,
                                            fontSize: 17,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    Image.asset('assets/1st.png'),
                                    SizedBox(
                                      height: size.height / 100,
                                    ),
                                    Text(
                                      ranking.length >= 1
                                          ? ranking[0].username ?? ''
                                          : 'no-data',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1!
                                          .copyWith(
                                            color: secondary,
                                            fontSize: 20,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '1st',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1!
                                          .copyWith(
                                            color: secondaryVariant,
                                            fontSize: 20,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    Text(
                                      ranking.length >= 3
                                          ? formatHHMMSS(
                                              ranking[2].focusTime ?? 0)
                                          : 'no-data',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1!
                                          .copyWith(
                                            color: secondary,
                                            fontSize: 17,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    Image.asset('assets/3rd.png'),
                                    SizedBox(
                                      height: size.height / 100,
                                    ),
                                    Text(
                                      ranking.length >= 3
                                          ? ranking[2].username ?? ''
                                          : 'no-data',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1!
                                          .copyWith(
                                            color: secondary,
                                            fontSize: 20,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '3rd',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1!
                                          .copyWith(
                                            color: secondaryVariant,
                                            fontSize: 20,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(size.width / 30),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        '4th',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline1!
                                            .copyWith(
                                              color: secondaryVariant,
                                              fontSize: 20,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Card(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: secondary,
                                              ),
                                              child: Text(
                                                ranking.length >= 4
                                                    ? "${ranking[3].username}-${formatHHMMSS(ranking[3].focusTime ?? 0)}"
                                                    : "no-data",
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline1!
                                                    .copyWith(
                                                      color: primary,
                                                      fontSize: 18,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        '5th',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline1!
                                            .copyWith(
                                              color: secondaryVariant,
                                              fontSize: 20,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Expanded(
                                        flex: 9,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Card(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: secondary,
                                              ),
                                              child: Text(
                                                ranking.length >= 5
                                                    ? "${ranking[4].username}-${formatHHMMSS(ranking[4].focusTime ?? 0)}"
                                                    : "no-data",
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline1!
                                                    .copyWith(
                                                      color: primary,
                                                      fontSize: 18,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        '6th',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline1!
                                            .copyWith(
                                              color: secondaryVariant,
                                              fontSize: 20,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Card(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: secondary,
                                              ),
                                              child: Text(
                                                ranking.length >= 6
                                                    ? "${ranking[5].username}-${formatHHMMSS(ranking[5].focusTime ?? 0)}"
                                                    : "no-data",
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline1!
                                                    .copyWith(
                                                      color: primary,
                                                      fontSize: 18,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        '7th',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .headline1!
                                            .copyWith(
                                              color: secondaryVariant,
                                              fontSize: 20,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Card(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: secondary,
                                              ),
                                              child: Text(
                                                ranking.length == 7
                                                    ? "${ranking[6].username}-${formatHHMMSS(ranking[6].focusTime ?? 0)}"
                                                    : "no-data",
                                                style: Theme.of(context)
                                                    .primaryTextTheme
                                                    .headline1!
                                                    .copyWith(
                                                      color: primary,
                                                      fontSize: 18,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        )
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
