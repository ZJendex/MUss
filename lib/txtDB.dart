import 'io.dart';

getCoursesList(FileIO fileCcourses, List<String> coursesList) async {
  String value = await fileCcourses.read();
  coursesList = [];
  for (var element in value.split("|").toList()) {
    if (element == "0" || DateTime.tryParse(element) != null) {
      coursesList.add(element);
    }
  }
}

getDBInfo(FileIO fileDBInDays, List<List<String>> dBInfo) async {
  String value = await fileDBInDays.read();
  dBInfo = [];
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
}
