import 'dart:math';

import 'package:muss/backend/models/course.dart';

class Event {
  Course course;
  int minutes;
  DateTime start;
  late DateTime end;
  Event({required this.course, required this.minutes, required this.start}) {
    end = start.add(Duration(minutes: minutes));
  }
}
