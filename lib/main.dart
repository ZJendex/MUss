import 'package:flutter/material.dart';
import 'pkgs/pie_chart/pie_chart.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'utils/pieChart.dart';
import 'txtDB.dart';
import 'utils/courseIconCorrespondance.dart';

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
      title: appName,
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
  bool loadingFinish = false;
  int _bottomNavigatorSelectedIndex = 0;
  String _courseEditSelectedCourse = tdb.coursesList[0];
  int _minuteChange = 0;

  @override
  void initState() {
    super.initState();
    initInfo();
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
                      padding: const EdgeInsets.only(right: 20.0),
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
                    itemBuilder: (BuildContext context, int index) {
                      return _courses(context, index);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 8,
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
                String currentDays = await tdb.fileCdays.read();
                showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(50),
                        child: PieChart(
                            chartLegendSpacing: 70,
                            centerText: "DAY $currentDays",
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
                  icon: Icon(Icons.data_thresholding_outlined),
                  label: 'Report',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_box_outlined),
                  label: 'Edit',
                ),
              ],
              currentIndex: _bottomNavigatorSelectedIndex,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black,
              selectedFontSize: 12,
              onTap: _onItemTapped,
            ),
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
                  tdb.coursesList[index],
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
              courseIcon(index, tdb.coursesList),
              color: courseOngoing[index]
                  ? const Color.fromARGB(255, 217, 87, 74)
                  : Colors.black,
            ),
          ],
        ));
  }

  void courseClicked(BuildContext context, int index) async {
    DateTime now = DateTime.now();
    String courseName = tdb.coursesList[index];
    String currentDays = "";
    await tdb.fileCdays.read().then((value) => currentDays = value);
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
      // if clicked course doesn't match the ongoing course
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
      setState(() {
        courseOngoing[index] = true;
      });
      // update counter for today's courses
      coursesList[index] = now.toString();
      await tdb.updateOngoingCoursesList(coursesList);
      await tdb.fileDBBackup.append("$courseName from ${now.toString()}");
    } else {
      // current courses finished
      setState(() {
        courseOngoing[index] = false;
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

  updateDB(String course, int minute) async {
    List<List<String>> db = [];
    await tdb.getDBInfo().then((value) => db = value);
    int courseIndex = 0;
    for (int i = 0; i < tdb.coursesList.length; i++) {
      if (tdb.coursesList[i] == course) {
        courseIndex = i;
        break;
      }
    }
    print("minute is $minute");
    print("int parse is ${int.parse(db[db.length - 1][courseIndex])}");
    // only able to edit today's data: db[currentDay]
    String changeResult =
        (int.parse(db[db.length - 1][courseIndex]) + minute).toString();
    print("change result is $changeResult");
    if (changeResult != "" || changeResult != "0") {
      db[db.length - 1][courseIndex] = changeResult;
      await tdb.updateDB(db);
    }
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      // give report

    } else {
      // courses edit on current days
      courseEditPage(context);
    }
  }

  courseEditPage(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // new state
          builder: (context, setState) {
            return Container(
              height: 200,
              color: Colors.amber,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DropdownButton<String>(
                          value: _courseEditSelectedCourse,
                          items: tdb.coursesList.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? val) {
                            setState(() {
                              _courseEditSelectedCourse = val!;
                            });
                          },
                        ),
                        Container(
                          width: 30,
                          height: 30,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text("$_minuteChange min"),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(
                                    () {
                                      _minuteChange = _minuteChange + 10;
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.minimize),
                                onPressed: () {
                                  setState(
                                    () {
                                      _minuteChange = _minuteChange - 10;
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                    Container(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ElevatedButton(
                            child: const Text('Cancel'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          ElevatedButton(
                            child: const Text('Save'),
                            onPressed: () async {
                              Navigator.pop(context);
                              // if save button causing a lag, modify this method
                              await updateDB(
                                  _courseEditSelectedCourse, _minuteChange);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
