import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muss/main.dart';
import 'package:muss/update_countdown_widget.dart';
import 'package:muss/update_database_widget.dart';
import 'pkgs/pie_chart/pie_chart.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'txt_db.dart';
import 'utils/courses_icon_correspondance.dart';
import 'package:audioplayers/audioplayers.dart';

class CoursesMainPage extends StatefulWidget {
  const CoursesMainPage({super.key});

  @override
  State<CoursesMainPage> createState() => _CoursesMainPageState();
}

class _CoursesMainPageState extends State<CoursesMainPage> {
  final player = AudioPlayer();
  String appName = "奶奶做事用时记录";
  TxtDB tdb = TxtDB();
  List<bool> courseOngoing = List.filled(10, false); // maxium 10 courses
  bool loadingFinish = false;
  Timer? timerV;

  String previousOngoingTime = "";
  late List<int> countDowns;
  String ongoingTime = "00:00:00";
  ValueNotifier ongoingTimeInSeconds = ValueNotifier(0);
  bool knowingPlayed = false;

  @override
  void initState() {
    super.initState();
    initInfo();
  }

  @override
  Widget build(BuildContext context) {
    return loadingFinish
        ? Scaffold(
            appBar: _appBarWidget(),
            body: Container(
                margin: const EdgeInsets.all(10),
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return _courses(context, index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                      );
                    },
                    itemCount: tdb.coursesList.length)),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 81, 118, 147), // 马耳他蓝
              onPressed: () async {
                // get pie chart for the course distribution
                Map<String, double> cumulateCoursesDuration = {};
                await tdb
                    .cumulateCoursesDuration()
                    .then((value) => cumulateCoursesDuration = value);
                showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(50),
                        child: PieChart(
                            chartLegendSpacing: 70,
                            centerText: "每日平均用时",
                            centerTextStyle: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: false,
                              showChartValues: false,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: false,
                              chartValueStyle: TextStyle(color: Colors.white),
                            ),
                            emptyColor: Colors.white,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 100,
                            colorList: pinknessColorList,
                            legendOptions: LegendOptions(
                                legendTextStyle: const TextStyle(
                                  color: Color.fromARGB(210, 200, 233, 84),
                                  decoration: TextDecoration.none,
                                  fontSize: 12,
                                ),
                                legendTailTextStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.88),
                                  decoration: TextDecoration.none,
                                  fontSize: 12,
                                ),
                                legendPosition: LegendPosition.bottom,
                                showLegendsInRow: false),
                            dataMap: cumulateCoursesDuration),
                      );
                    },
                    barrierColor: const Color.fromARGB(225, 0, 0, 0));
              },
              tooltip: 'Check the time use in pie chart',
              child: const Icon(Icons.pie_chart),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.alarm),
                  label: '改变提醒时间',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.timelapse),
                  label: '更新事件时间',
                ),
              ],
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              selectedFontSize: 12,
              onTap: _onItemTapped,
            ),
          )
        : Scaffold(
            // Loading Page
            appBar: _appBarWidget(),
            body: const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(Colors.black),
            )),
          );
  }

  PreferredSizeWidget? _appBarWidget() {
    return NewGradientAppBar(
        title: Text(
          appName,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 81, 118, 147), // 马耳他蓝
          Color.fromARGB(255, 0, 49, 83) // 普鲁士蓝
        ]),
        actions: <Widget>[
          Visibility(
              visible: loadingFinish,
              child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () async {
                      alertOnResetDB();
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.restart_alt,
                    ),
                  )))
        ]);
  }

  Widget _courses(BuildContext context, int index) {
    // 点击监视器
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () async {
          courseClicked(context, index);
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 100,
                  padding: const EdgeInsets.only(right: 20),
                  alignment: Alignment.center,
                  child: Text(
                    tdb.coursesList[index],
                    style: const TextStyle(
                        letterSpacing: 7,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        fontSize: 30),
                  ),
                ),
                Icon(
                  courseIcon(index, tdb.coursesList),
                  color: courseOngoing[index]
                      ? const Color.fromARGB(255, 217, 87, 74)
                      : Colors.black,
                  size: 60,
                ),
              ],
            ),
            Visibility(
              visible: courseOngoing[index],
              child: Text(
                "${ongoingTime}",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ));
  }

  timeSecToHours({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int timeInMin = (timeInSecond / 60).floor();
    int min = timeInMin % 60;
    int timeInHour = (timeInMin / 60).floor();
    String hour =
        timeInHour.toString().length <= 1 ? "0$timeInHour" : "$timeInHour";
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$hour:$minute:$second";
  }

  void courseClicked(BuildContext context, int index) async {
    DateTime now = DateTime.now();
    String courseName = tdb.coursesList[index];
    String currentDays = "";
    await tdb.getCurrentDays().then((value) => currentDays = value);
    String duration;

    // retrieve current course info
    List<String> coursesList = [];
    await tdb.getCoursesList().then((value) => coursesList = value);

    // retrieve current DB info
    List<List<String>> dBInfo = [];
    await tdb.getDBInfo().then((value) => dBInfo = value);

    // check if no course conflict
    bool conflict = false;
    for (int i = 0; i < coursesList.length; i++) {
      // if clicked course doesn't match the ongoing course (need alert dialog)
      if (coursesList[i] != '0' && i != index) {
        setState(() {
          conflict = true;
        });
      }
    }

    if (conflict) {
      // do nothing if ongoing course conflict happened
    } else if (coursesList[index] == '0') {
      // new courses started
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          onVisible: () {
            Timer.periodic(const Duration(seconds: 2), (timer) {
              timer.cancel();
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            });
          },
          content: Text("${countDowns[index]}分钟计时开始"),
          actions: [
            TextButton(
                onPressed: (() {
                  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                  player.stop();
                }),
                child: const Text("知道了"))
          ],
        ),
      );

      // visualized timer
      timerV = Timer.periodic(const Duration(seconds: 1), ((timer) {
        ongoingTimeInSeconds.value++;
        setState(() {
          ongoingTime =
              timeSecToHours(timeInSecond: ongoingTimeInSeconds.value);
        });
      }));
      setState(() {
        courseOngoing[index] = true;
      });
      // update counter for today's courses
      coursesList[index] = now.toString();
      await tdb.updateOngoingCoursesList(coursesList);
      tdb.appendHistory("$courseName from ${now.toString()}");
    } else {
      // current courses finished
      knowingPlayed = false;
      timerV == null ? {} : {timerV!.cancel()};
      ongoingTimeInSeconds.value = 0;
      player.stop();
      setState(() {
        courseOngoing[index] = false;
        ongoingTime = "00:00:00";
      });
      // get the duration and clean the corresponding counter
      duration =
          DateTimeRange(start: DateTime.parse(coursesList[index]), end: now)
              .duration
              .inMinutes
              .toString();
      // clean the counter
      coursesList[index] = "0";
      await tdb.updateOngoingCoursesList(coursesList);
      // update the duration info in DB
      int i = int.parse(currentDays) - 1;
      dBInfo[i][index] =
          (int.parse(duration) + int.parse(dBInfo[i][index])).toString();
      await tdb.updateDB(dBInfo);
      tdb.appendHistory(
          " to ${now.toString()} $courseName for about $duration minutes \n");
      // check if its the new day --- after sleep
      if (courseName == "SLEEP") {
        tdb.newDay(currentDays);
      }
    }
  }

  void initInfo() async {
    countDowns = await tdb.getCountDowns();
    String cds = await tdb.getCurrentDays();
    // if it's the first time open the app
    if (cds.isEmpty) {
      tdb.resetDB();
    }
    // loading the ongoing course curcumstances
    List<String> coursesList = [];
    await tdb.getCoursesList().then((value) => coursesList = value);
    for (int i = 0; i < coursesList.length; i++) {
      if (coursesList[i] != "0") {
        previousOngoingTime = coursesList[i];
        courseOngoing[i] = true;
      } else {
        courseOngoing[i] = false;
      }
    }

    // if app closed when ongoing courses still going, get back the countdown in real time
    if (previousOngoingTime != "") {
      print(previousOngoingTime);
      ongoingTimeInSeconds.value = DateTimeRange(
              start: DateTime.parse(previousOngoingTime), end: DateTime.now())
          .duration
          .inSeconds;
      timerV = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          ongoingTime =
              timeSecToHours(timeInSecond: ongoingTimeInSeconds.value++);
        });
      });
    }
    ongoingTimeInSeconds.addListener(
      () async {
        //get current ongoing course limit time
        int i = 0;
        for (bool element in courseOngoing) {
          if (element) break;
          i++;
        }
        List<int> countDownList = await tdb.getCountDowns(); // in minutes
        // play alarm
        if (ongoingTimeInSeconds.value > countDownList[i] &&
            player.state != PlayerState.playing &&
            !knowingPlayed) {
          int countDown = countDownList[i];
          player.play(AssetSource('audio/mixkit-goals-are-ahead-146.mp3'));
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text("已经过了$countDown分钟了, 需要休息啦"),
              actions: [
                TextButton(
                    onPressed: (() {
                      knowingPlayed = true;
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                      player.stop();
                    }),
                    child: const Text("知道了"))
              ],
            ),
          );
        }
      },
    );
    setState(() {
      ongoingTime = timeSecToHours(timeInSecond: ongoingTimeInSeconds.value);
      loadingFinish = true;
    });
  }

  void _onItemTapped(int index) async {
    if (index == 0) {
      List<String> coursesList = [];
      await tdb.getCoursesList().then((value) => coursesList = value);
      bool coursesOngoingStatus = false;
      coursesList.forEach((element) {
        if (element != '0') {
          coursesOngoingStatus = true;
        }
      });
      if (!coursesOngoingStatus) {
        // change coutDown
        await showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return UpdateCountdownWidget(tdb: tdb);
          },
        );
        // Refresh the main page with initState triggered
        RestartWidget.restartApp(context);
      } else {
        ScaffoldMessenger.of(context).showMaterialBanner(
          MaterialBanner(
            onVisible: () {
              Timer.periodic(const Duration(seconds: 2), (timer) {
                timer.cancel();
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              });
            },
            content: const Text("请先停止当前进行的事件"),
            actions: [
              TextButton(
                  onPressed: (() {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    player.stop();
                  }),
                  child: const Text("知道了"))
            ],
          ),
        );
      }
    } else {
      // courses edit on current days
      await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return UpdateDatabaseWidget(tdb: tdb);
        },
      );
    }
  }

  Future alertOnResetDB() {
    return showDialog(
        context: context,
        builder: ((context) => AlertDialog(
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(70),
                side: const BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 81, 118, 147),
                    style: BorderStyle.solid)),
            backgroundColor: const Color.fromARGB(238, 24, 49, 74),
            content: SizedBox(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "要清除所有历史数据吗？",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                    const Size.fromWidth(100)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 81, 118, 147)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)))),
                            child: const Text('取消'),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                    const Size.fromWidth(100)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 81, 118, 147)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)))),
                            child: const Text('清除'),
                            onPressed: () async {
                              tdb.resetDB();
                              Navigator.pop(context);
                              // Refresh the main page with initState triggered
                              RestartWidget.restartApp(context);
                            },
                          ),
                        ],
                      ))
                ],
              ),
            ))));
  }
}
