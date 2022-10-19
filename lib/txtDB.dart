import 'io.dart';

class TxtDB {
  FileIO fileCdays = FileIO("current_days.txt");
  FileIO fileCcourses = FileIO("counter_ongoing_courses.txt");
  FileIO fileDBInDays = FileIO("database.txt");
  FileIO fileDBBackup = FileIO("history.txt");
  FileIO fileConst = FileIO("const.txt");

  TxtDB() {}

  void resetDB() async {
    // Current days from begin
    fileCdays.write("1");
    // assignment of today
    fileCcourses.write("0|0|0|0|0|0");
    // the database in days for each course
    // Total: 5 courses * n days
    fileDBInDays.write("0|0|0|0|0|0\n");
    // the backup for each intervals
    fileDBBackup.write("");
    // save the starting datetime
    fileConst.write(DateTime.now().toString());
  }

  updateOngoingCoursesList(List<String> currentCoursesList) async {
    await fileCcourses.clear();
    for (var coursesCount in currentCoursesList) {
      await fileCcourses.append("$coursesCount|");
    }
  }

  updateDB(List<List<String>> currentDBInfo) async {
    await fileDBInDays.clear();
    for (var day in currentDBInfo) {
      for (var course in day) {
        await fileDBInDays.append("$course|");
      }
      await fileDBInDays.append("\n");
    }
  }

  Future<List<String>> getCoursesList() async {
    List<String> coursesList = [];
    String value = await fileCcourses.read();
    for (var element in value.split("|").toList()) {
      if (element == "0" || DateTime.tryParse(element) != null) {
        coursesList.add(element);
      }
    }
    return coursesList;
  }

  Future<List<List<String>>> getDBInfo() async {
    List<List<String>> dBInfo = [];
    String value = await fileDBInDays.read();
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

  newDay(String currentDays) async {
    String newDays = (int.parse(currentDays) + 1).toString();
    fileCdays.write(newDays);
    await fileDBInDays.append("0|0|0|0|0|0\n");
    await fileDBBackup.append("NEW DAY FROM HERE\n");
  }
}
