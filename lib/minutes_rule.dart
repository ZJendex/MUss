import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "appName",
      home: MinutesRulePage(),
    );
  }
}

class MinutesRulePage extends StatefulWidget {
  const MinutesRulePage({super.key});

  @override
  State<MinutesRulePage> createState() => _MinutesRulePageState();
}

class _MinutesRulePageState extends State<MinutesRulePage> {
  int countDownInSecond = 600;
  Timer? timer;
  double hintVisible = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (timer == null) {
          startTimer();
          setState(() {
            hintVisible = 0;
          });
        }
      },
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("${timeSecToMin(timeInSecond: countDownInSecond)}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none)),
          const SizedBox(
            height: 60,
          ),
          Text(
            "Tab to start timer",
            style: TextStyle(
                color: Colors.red[100]?.withOpacity(hintVisible),
                fontSize: 15,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none),
          ),
        ]),
      ),
    );
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countDownInSecond > 0) {
          countDownInSecond--;
        } else {
          timer.cancel();
        }
      });
    });
  }
}

timeSecToMin({required int timeInSecond}) {
  int sec = timeInSecond % 60;
  int min = (timeInSecond / 60).floor();
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
  return "$minute:$second";
}
