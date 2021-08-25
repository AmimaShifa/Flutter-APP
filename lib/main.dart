//import "package:percent_indicator/percent_indicator.dart";

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Pomodoro(),
  ));
}

class Pomodoro extends StatefulWidget {
  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  double percent = 0;
  // ignore: non_constant_identifier_names
  static int TimeInMinut = 25;
  // ignore: non_constant_identifier_names
  int TimeInSec = TimeInMinut * 60;
  Timer? timer;
  // ignore: non_constant_identifier_names
  void _StartTimer() {
    TimeInMinut = 25;
    // ignore: non_constant_identifier_names
    int Time = TimeInSec;
    // ignore: non_constant_identifier_names
    double SecPercent = (Time / 100);
    print(SecPercent);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (Time > 0) {
          Time--;
          if (Time % 60 == 0) {
            TimeInMinut--;
          }
          if (Time % SecPercent == 0) {
            if (percent < 1) {
              percent += 0.01;
            } else {
              percent = 1;
            }
          }
        } else {
          percent = 0;
          TimeInMinut = 25;
          timer.cancel();
        }
      });
    });
  }

  // ignore: non_constant_identifier_names
  _StopTimer() {
    timer?.cancel();
    TimeInMinut = 25;

  }


  @override // This widget is the root of your application.

  // ignore: unused_element
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xfffec194), Color(0xffff0061)],
                  begin: FractionalOffset(0.5, 1)),
            ),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50.0, bottom: 50.0),
                  child: Text(
                    "Pomodoro Clock",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 40.0),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
                Expanded(
                  child: CircularPercentIndicator(
                    
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: percent,
                    animation: true,
                    animateFromLastPercent: true,
                    radius: 250.0,
                    lineWidth: 20.0,
                    arcType: ArcType.FULL,
                    arcBackgroundColor: Color(0xff37f877),
                    progressColor: Colors.white,
                    backgroundColor: Colors.transparent,
                    center: Text(
                      "$TimeInMinut",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xff591da9),
                          fontSize: 80.0),
                    ),
                  ),
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _StopTimer();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Stop",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _StartTimer();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Start",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          padding: EdgeInsets.all(5.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                        )),
                  ],
                ))
               
              ],
            )),
      ),
    );
  }
}
