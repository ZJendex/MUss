import 'package:flutter/material.dart';
import 'package:muss/backend/my_database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:muss/pkgs/pie_chart/pie_chart.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:path/path.dart';

class EventRecordPage extends StatefulWidget {
  const EventRecordPage({super.key});

  @override
  State<EventRecordPage> createState() => _EventRecordPageState();
}

class _EventRecordPageState extends State<EventRecordPage> {
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late MyDatabase _db;
  late String _selectedCourse;
  late List<CourseData> courseList;
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
            body: Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                DropdownButton2<String>(
                  customButton: Container(
                    child: Icon(Icons.arrow_drop_down),
                    width: 20,
                    height: 20,
                  ),
                  dropdownWidth: 100,
                  value: _selectedCourse,
                  alignment: AlignmentDirectional.centerEnd,
                  underline: const DropdownButtonHideUnderline(
                    child: SizedBox.shrink(),
                  ),
                  items: courseList.map((CourseData items) {
                    return DropdownMenuItem(
                      value: items.name,
                      child: Text(
                        items.name,
                        style: const TextStyle(
                          letterSpacing: 3,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }).toList()
                    ..add(const DropdownMenuItem(
                      value: "ADD NEW",
                      child: Text(
                        "ADD NEW",
                        style: TextStyle(
                          letterSpacing: 3,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )),
                  onChanged: (val) {
                    setState(() {
                      _selectedCourse = val ?? "";
                    });
                  },
                ),
              ]),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 81, 118, 147), // 马耳他蓝
              onPressed: () async {
                // get pie chart for the course distribution
                Map<String, double> cumulateCoursesDuration = {};
                String currentDays = "1";
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
                            dataMap: testPieChart),
                      );
                    },
                    barrierColor: const Color.fromARGB(225, 0, 0, 0));
              },
              tooltip: 'Check the time use in pie chart',
              child: const Icon(Icons.pie_chart),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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

  Padding newMethod() {
    return Padding(
      padding: const EdgeInsets.all(80.0),
      child: Column(
        children: [
          propertyInputTFF(
            controller: _courseController,
            propertyName: "Course Type",
          ),
          const SizedBox(
            height: 10,
          ),
          propertyInputTFF(
            controller: _minuteController,
            propertyName: "Time Duration",
          ),
          const SizedBox(
            height: 10,
          ),
          propertyInputTFF(
            controller: _descriptionController,
            propertyName: "Task Description",
          )
        ],
      ),
    );
  }

  void initInfo() async {
    _db = Get.find<MyDatabase>();
    CourseData? value = await _db.getCourseByName("SLEEP");
    _selectedCourse = value == null ? "" : value.name;
    courseList = await _db.getCourses();

    dummyDataFilled(driftdb: _db);
    //initDatafilled()
    setState(() {
      loadingFinish = true;
    });
  }

  PreferredSizeWidget? _appBarWidget() {
    return NewGradientAppBar(
        title: Text(
          "MUss",
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 81, 118, 147), // 马耳他蓝
          Color.fromARGB(255, 0, 49, 83) // 普鲁士蓝
        ]),
        actions: <Widget>[
          // Visibility(
          //     visible: loadingFinish,
          //     child: Padding(
          //         padding: const EdgeInsets.only(right: 20.0),
          //         child: GestureDetector(
          //           onTap: () => alertOnResetDB(),
          //           child: const Icon(
          //             Icons.restart_alt,
          //           ),
          //         )))
        ]);
  }
}

void dummyDataFilled({required MyDatabase driftdb}) {
  driftdb.deleteALLEvent();
  driftdb.deleteALLCourse();
  driftdb.deleteALLTask();
  driftdb.insertCourse(const CourseCompanion(name: drift.Value("SLEEP")));
  driftdb.insertCourse(const CourseCompanion(name: drift.Value("READ")));
  driftdb.insertCourse(const CourseCompanion(name: drift.Value("WRITE")));
  driftdb.insertCourse(const CourseCompanion(name: drift.Value("WORK")));

  driftdb.insertTask(const TaskCompanion(
      description: drift.Value("read the book Solve For Happy")));
  driftdb.insertTask(const TaskCompanion(
      description: drift.Value("write code"), course: drift.Value(3)));

  driftdb.insertEvent(EventCompanion(
      course: drift.Value(1),
      duration: drift.Value(30),
      to: drift.Value(DateTime.now()),
      from: drift.Value(DateTime.now().subtract(Duration(minutes: 30)))));
  driftdb.insertEvent(EventCompanion(
      course: drift.Value(0),
      from: drift.Value(DateTime.now().subtract(Duration(minutes: 180)))));

  late List<CourseData> courses;
  late List<EventData> events;

  driftdb.getEvents().then((value) {
    events = value;
    print(events);
  });
  driftdb.getCourses().then((value) => print(value));
}

class propertyInputTFF extends StatelessWidget {
  final TextEditingController _controller;
  final String _propertyName;

  const propertyInputTFF({
    Key? key,
    required TextEditingController controller,
    required String propertyName,
  })  : _controller = controller,
        _propertyName = propertyName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          border: const OutlineInputBorder(), label: Text(_propertyName)),
      validator: (value) {
        if (value!.isEmpty) {
          return "course selection can not be empty";
        }
        return null;
      },
    );
  }
}
