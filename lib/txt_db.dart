import 'file_io.dart';
import 'package:flutter/material.dart';

class TxtDB {
  final FileIO _fileCdays = FileIO("current_days.txt"); // the number of days
  final FileIO _fileCcourses =
      FileIO("counter_ongoing_courses.txt"); // current courses status
  final FileIO _fileDBInDays =
      FileIO("database.txt"); // main database through all the days
  final FileIO _fileDBBackup = FileIO("history.txt"); // backup txt
  final FileIO _fileConst = FileIO("const.txt"); // utils save
  final List<String> coursesList = [
    "看手机",
    "出门运动",
  ];
  final String _oneDayCoursesBaseData = "0|0|0|0|0|0|0";

  TxtDB();

  void resetDB() async {
    // Current days from begin
    _fileCdays.write("1");
    // assignment of today
    _fileCcourses.write(_oneDayCoursesBaseData);
    // the database in days for each course
    // Total: 5 courses * n days
    _fileDBInDays.write("$_oneDayCoursesBaseData\n");
    // the backup for each intervals
    _fileDBBackup.write("");
    // save the starting datetime
    _fileConst.write(DateTime.now().toString());
  }

  // update current courses status
  updateOngoingCoursesList(List<String> currentCoursesList) async {
    await _fileCcourses.clear();
    for (var coursesCount in currentCoursesList) {
      await _fileCcourses.append("$coursesCount|");
    }
  }

  // update main database
  updateDB(List<List<String>> currentDBInfo) async {
    await _fileDBInDays.clear();
    for (var day in currentDBInfo) {
      for (var course in day) {
        await _fileDBInDays.append("$course|");
      }
      await _fileDBInDays.append("\n");
    }
  }

  // get current number of days
  Future<String> getCurrentDays() async {
    String rst = "";
    rst = await _fileCdays.read();
    return rst;
  }

  // get current course status
  Future<List<String>> getCoursesList() async {
    List<String> coursesList = [];
    String value = await _fileCcourses.read();
    for (var element in value.split("|").toList()) {
      if (element == "0" || DateTime.tryParse(element) != null) {
        coursesList.add(element);
      }
    }
    return coursesList;
  }

  // get current main database
  Future<List<List<String>>> getDBInfo() async {
    List<List<String>> dBInfo = [];
    String value = await _fileDBInDays.read();
    int n = 0;
    for (var line in value.split("\n").toList()) {
      if (line != "") {
        dBInfo.add([]);
        for (var element in line.split("|").toList()) {
          if (int.tryParse(element) != null) {
            dBInfo[n].add(element);
          }
        }
      }
      n++;
    }
    return dBInfo;
  }

  // append history
  void appendHistory(String history) async {
    _fileDBBackup.append(history);
  }

  // days increment steps
  void newDay(String currentDays) async {
    String newDays = (int.parse(currentDays) + 1).toString();
    _fileCdays.write(newDays);
    await _fileDBInDays.append("$_oneDayCoursesBaseData\n");
    await _fileDBBackup.append("NEW DAY FROM HERE\n");
  }

  // get the map of courses and their total spent times include OTHERS
  Future<Map<String, double>> cumulateCoursesDuration() async {
    Map<String, double> cumulateCoursesDuration = {};
    DateTime now = DateTime.now();
    List<List<String>> dBInfo = [];
    await getDBInfo().then((value) => dBInfo = value);
    String theBeginning = "";
    await _fileConst.read().then((value) => theBeginning = value);
    int totalDuration =
        DateTimeRange(start: DateTime.parse(theBeginning), end: now)
            .duration
            .inMinutes;
    // add up times in each day
    List<double> cCD = List.filled(coursesList.length, 0);
    for (var day in dBInfo) {
      for (int i = 0; i < coursesList.length; i++) {
        if (day[i] != "0") {
          cCD[i] = cCD[i] + double.parse(day[i]);
        }
      }
    }
    // fill cumulateCoursesDuration
    double cumulateAll = 0;
    String nowTime = await _fileConst.read();
    int days =
        DateTimeRange(start: DateTime.parse(nowTime), end: DateTime.now())
            .duration
            .inDays;
    for (int i = 0; i < coursesList.length; i++) {
      cumulateCoursesDuration[coursesList[i]] = cCD[i] / (days + 1);
      cumulateAll = cumulateAll + cCD[i];
    }

    // cumulateCoursesDuration["OTHERS"] =
    //     totalDuration - cumulateAll >= 0 ? totalDuration - cumulateAll : 0;
    return cumulateCoursesDuration;
  }
}
