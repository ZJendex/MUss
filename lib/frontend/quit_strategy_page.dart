import 'package:flutter/material.dart';

// The method retrieved from Happy Sex Millionaire written by Steven Bartlett @2021

class Question {
  final String text;
  final String leftButtonText;
  final String rightButtonText;

  Question(
      {required this.text,
      required this.leftButtonText,
      required this.rightButtonText});
}

class QuitStrategyPage extends StatefulWidget {
  const QuitStrategyPage({super.key});

  @override
  State<QuitStrategyPage> createState() => _QuitStrategyPageState();
}

class _QuitStrategyPageState extends State<QuitStrategyPage> {
  int index = 0; // question index
  bool buttonVisibility = true;
  double fontSize = 32;
  Color fontColor = Colors.white;
  List<Question> questions = [
    Question(
        // 0
        text: "ARE YOU THINKING ABOUT QUITTING?",
        leftButtonText: "NO",
        rightButtonText: "YES"),
    Question(
        // 1
        text: "WHY ARE YOU THINKING ABOUT QUITTING?",
        leftButtonText: "IT'S JUST HARD",
        rightButtonText: "IT SUCKS"),
    Question(
        // 2
        text: "IS THE CHALLENGE WORTH THE POTENTIAL REWARD?",
        leftButtonText: "NO",
        rightButtonText: "YES"),
    Question(
        // 3
        text: "DO YOU BELIEVE YOU COULD MAKE IT NOT SUCK?",
        leftButtonText: "NO",
        rightButtonText: "YES"),
    Question(
        // 4
        text: "IS THE EFFORT IT WOULD TAKE TO MAKE IT NOT SUCK WORTH IT?",
        leftButtonText: "NO",
        rightButtonText: "YES"),
    Question(
        // 5
        text: "QUIT",
        leftButtonText: "NO",
        rightButtonText: "YES"),
    Question(
        // 6
        text: "DON'T QUIT",
        leftButtonText: "NO",
        rightButtonText: "YES"),
  ];

/*
  question path to answer
  int larger than zero represent the index to go
  -1 means pop the page
  -2 means don't quit
  -3 means quit

  flag->true button->left
  vice versa
*/
  Map<int, Function> questionPath = {
    0: (flag) => flag ? -1 : 1,
    1: (flag) => flag ? 2 : 3,
    2: (flag) => flag ? -3 : -2,
    3: (flag) => flag ? -3 : 4,
    4: (flag) => flag ? -3 : -2
  };

  void moveQuestion(bool flag) {
    int rst = questionPath[index]!(flag);
    if (rst >= 0) {
      setState(() {
        index = rst;
      });
    } else if (rst == -1) {
      Navigator.pop(context);
    } else if (rst == -3) {
      // quit
      setState(() {
        index = 5;
        buttonVisibility = false;
        fontSize = 60;
        fontColor = const Color.fromARGB(255, 193, 25, 25);
      });
    } else {
      // don't quit
      setState(() {
        index = 6;
        buttonVisibility = false;
        fontSize = 60;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onDoubleTap: () {
              Navigator.pop(context);
            },
            child: Text(
              questions[index].text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: fontColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
              child: Visibility(
                  visible: buttonVisibility,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: buttonStyleQuit,
                        child: Text(questions[index].leftButtonText),
                        onPressed: () {
                          moveQuestion(true);
                        },
                      ),
                      ElevatedButton(
                        style: buttonStyleQuit,
                        child: Text(questions[index].rightButtonText),
                        onPressed: () {
                          moveQuestion(false);
                        },
                      ),
                    ],
                  )))
        ],
      ),
    );
  }

  ButtonStyle buttonStyleQuit = ButtonStyle(
      fixedSize: MaterialStateProperty.all(const Size(100, 62)),
      backgroundColor:
          MaterialStateProperty.all(const Color.fromARGB(255, 193, 25, 25)),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))));
}
