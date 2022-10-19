import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'txtDB.dart';

const String appName = "MUss";
TxtDB tdb = TxtDB();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MUss',
      home: Courses(),
    );
  }
}

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  // maxium 10 courses
  List<bool> courseOngoing = List.filled(10, false);
  final _listViewKey = GlobalKey();
  bool loadingFinish = false;
  final List<String> _coursesList = [
    "SLEEP",
    "NAP",
    "WRITE",
    "READ",
    "WORK",
    "WORKOUT",
  ];
  final List<Color> brownessColorList = const [
    Color.fromARGB(255, 0, 78, 162), // SLEEP
    Color.fromARGB(255, 0, 113, 171), // NAP
    Color.fromARGB(255, 172, 108, 86), // WRITE
    Color.fromARGB(255, 95, 39, 29), // READ
    Color.fromARGB(255, 212, 166, 81), // WORK
    Color.fromARGB(255, 228, 142, 81), // WORKOUT
    Color.fromARGB(255, 101, 87, 86), // OTHERS
    Color.fromARGB(255, 101, 87, 86), // RANDOM1
    Color.fromARGB(255, 101, 87, 86), // RANDOM2
    Color.fromARGB(255, 101, 87, 86) // RANDOM3
  ];
  final List<Color> pinknessColorList = const [
    Color.fromARGB(255, 0, 78, 162), // SLEEP
    Color.fromARGB(255, 0, 113, 171), // NAP
    Color.fromARGB(255, 156, 100, 167), // WRITE
    Color.fromARGB(255, 227, 198, 207), // READ
    Color.fromARGB(255, 199, 45, 117), // WORK
    Color.fromARGB(255, 92, 16, 40), // WORKOUT
    Color.fromARGB(255, 101, 87, 86), // OTHERS
    Color.fromARGB(255, 101, 87, 86), // RANDOM1
    Color.fromARGB(255, 101, 87, 86), // RANDOM2
    Color.fromARGB(255, 101, 87, 86) // RANDOM3
  ];

  @override
  void initState() {
    super.initState();
    initInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loadingFinish
        ? Scaffold(
            appBar: NewGradientAppBar(
                title: const Text(
                  appName,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(255, 81, 118, 147), // 马耳他蓝
                  Color.fromARGB(255, 0, 49, 83) // 普鲁士蓝
                ]),
                actions: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          tdb.resetDB();
                        },
                        child: const Icon(
                          Icons.restart_alt,
                        ),
                      ))
                ]),
            body: Container(
                margin: const EdgeInsets.all(10),
                child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    key: _listViewKey,
                    itemBuilder: (BuildContext context, int index) {
                      return _courses(context, index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 8,
                      );
                    },
                    itemCount: _coursesList.length)),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 81, 118, 147), // 马耳他蓝
              onPressed: () async {
                // get pie chart for the course distribution
                Map<String, double> cumulateCourseDuration = {};
                DateTime now = DateTime.now();
                List<List<String>> dBInfo = [];
                await tdb.getDBInfo().then((value) => dBInfo = value);
                String theBeginning = "";
                await tdb.fileConst
                    .read()
                    .then((value) => theBeginning = value);
                String totalDuration =
                    DateTimeRange(start: DateTime.parse(theBeginning), end: now)
                        .duration
                        .inSeconds
                        .toString();
                // add up times in each day
                List<double> cCD = List.filled(_coursesList.length, 0);
                for (var day in dBInfo) {
                  for (int i = 0; i < _coursesList.length; i++) {
                    if (day[i] != "0") {
                      cCD[i] = cCD[i] + double.parse(day[i]);
                    }
                  }
                }
                // fill cumulateCoursesDuration
                double cumulateAll = 0;
                for (int i = 0; i < _coursesList.length; i++) {
                  cumulateCourseDuration[_coursesList[i]] = cCD[i];
                  cumulateAll = cumulateAll + cCD[i];
                }
                cumulateCourseDuration["OTHERS"] =
                    double.parse(totalDuration) - cumulateAll;

                Map<String, double> testPieChart = {
                  "SLEEP": 8,
                  "NAP": 1,
                  "WRITE": 1,
                  "READ": 2,
                  "WORK": 6,
                  "WORKOUT": 0.5,
                  "OTHERS": 5.5
                };
                showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        child: PieChart(
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValueBackground: false,
                              showChartValues: true,
                              showChartValuesInPercentage: true,
                              showChartValuesOutside: false,
                              chartValueStyle: TextStyle(
                                  color: Color.fromARGB(255, 200, 233, 84)),
                            ),
                            emptyColor: Colors.white,
                            chartType: ChartType.ring,
                            colorList: pinknessColorList,
                            legendOptions: const LegendOptions(
                                legendTextStyle: TextStyle(
                              color: Color.fromARGB(255, 200, 233, 84),
                              decoration: TextDecoration.none,
                              fontSize: 12,
                            )),
                            dataMap: cumulateCourseDuration),
                      );
                    });
              },
              tooltip: 'Check the time use in pie chart',
              child: const Icon(Icons.pie_chart),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          )
        : Scaffold(
            // Loading Page
            appBar: NewGradientAppBar(
              title: const Text(
                appName,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 81, 118, 147), // 马耳他蓝
                Color.fromARGB(255, 0, 49, 83) // 普鲁士蓝
              ]),
            ),
            body: Container(),
          );
  }

  Widget _courses(BuildContext context, int index) {
    // 点击监视器
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => courseClicked(context, index),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
            ),
            SizedBox(
              height: 80,
              child: Center(
                child: Text(
                  _coursesList[index],
                  style: const TextStyle(
                    letterSpacing: 7,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            Container(
              width: 20,
            ),
            Icon(
              _courseIcon(index, _coursesList),
              color: courseOngoing[index]
                  ? const Color.fromARGB(255, 217, 87, 74)
                  : Colors.black,
            ),
          ],
        ));
  }

  void courseClicked(BuildContext context, int index) async {
    DateTime now = DateTime.now();
    String courseName = _coursesList[index];
    String currentDays = "";
    await tdb.fileCdays.read().then((value) => currentDays = value);
    String duration;

    // retrieve current course info
    List<String> coursesList = [];
    await tdb.getCoursesList().then((value) => coursesList = value);

    // retrieve current DB info
    // each line is a day start from day one
    List<List<String>> dBInfo = [];
    await tdb.getDBInfo().then((value) => dBInfo = value);

    // check if no course conflict
    bool conflict = false;
    for (int i = 0; i < coursesList.length; i++) {
      // if there is an ongoing course and its different from the current clicked course
      if (coursesList[i] != '0' && i != index) {
        setState(() {
          conflict = true;
        });
      }
    }

    if (conflict) {
      // do nothing if ongoing course conflict happened
    } else if (coursesList[index] == '0') {
      // course start
      // new courses started
      setState(() {
        courseOngoing[index] = true;
      });
      // update counter for today's courses
      coursesList[index] = now.toString();
      await tdb.updateOngoingCoursesList(coursesList);
      await tdb.fileDBBackup.append("$courseName from ${now.toString()}");
    } else {
      // course finished
      // current courses finished
      setState(() {
        courseOngoing[index] = false;
      });
      // get the duration and clean the corresponding counter
      duration =
          DateTimeRange(start: DateTime.parse(coursesList[index]), end: now)
              .duration
              .inSeconds
              .toString();
      // clean the counter
      coursesList[index] = "0";
      await tdb.updateOngoingCoursesList(coursesList);
      // update the duration info in DB
      int i = int.parse(currentDays) - 1;
      dBInfo[i][index] =
          (int.parse(duration) + int.parse(dBInfo[i][index])).toString();
      await tdb.updateDB(dBInfo);
      await tdb.fileDBBackup.append(
          " to ${now.toString()} $courseName for about $duration minutes \n");
      // check if its the new day --- after sleep
      if (courseName == "SLEEP") {
        await tdb.newDay(currentDays);
      }
    }
  }

  void initInfo() async {
    String cds = await tdb.fileCdays.read();
    // if it's the first time open the app
    if (cds.isEmpty) {
      tdb.resetDB();
    }
    // loading the ongoing course curcumstances
    List<String> coursesList = [];
    await tdb.getCoursesList().then((value) => coursesList = value);
    for (int i = 0; i < coursesList.length; i++) {
      if (coursesList[i] != "0") {
        courseOngoing[i] = true;
      } else {
        courseOngoing[i] = false;
      }
    }
    setState(() {
      loadingFinish = true;
    });
  }

  IconData? _courseIcon(int index, List<String> coursesList) {
    switch (coursesList[index]) {
      case "SLEEP":
        return Icons.bedtime;
      case "WRITE":
        return Icons.edit;
      case "READ":
        return Icons.menu_book;
      case "WORK":
        return Icons.people;
      case "WORKOUT":
        return Icons.fitness_center;
      case "NAP":
        return Icons.notifications_paused;
      default:
        return Icons.add;
    }
  }
}
