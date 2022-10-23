import 'package:flutter/material.dart';
import 'package:muss/update_database_widget.dart';
import 'pkgs/pie_chart/pie_chart.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'txtDB.dart';
import 'utils/courses_icon_correspondance.dart';

class CoursesMainPage extends StatefulWidget {
  const CoursesMainPage({super.key});

  @override
  State<CoursesMainPage> createState() => _CoursesMainPageState();
}

class _CoursesMainPageState extends State<CoursesMainPage> {
  String appName = "MUss";
  TxtDB tdb = TxtDB();
  List<bool> courseOngoing = List.filled(10, false); // maxium 10 courses
  bool loadingFinish = false;

  @override
  void initState() {
    initInfo();
    super.initState();
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
                    onTap: () {
                      tdb.resetDB();
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
        onTap: () => courseClicked(context, index),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 80,
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.center,
              child: Text(
                tdb.coursesList[index],
                style: const TextStyle(
                  letterSpacing: 7,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
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

  void _onItemTapped(int index) {
    if (index == 0) {
      // give report

    } else {
      // courses edit on current days
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return UpdateDatabaseWidget(tdb: tdb);
        },
      );
    }
  }
}
