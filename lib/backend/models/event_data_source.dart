import 'dart:ui';

import 'package:muss/backend/models/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:muss/pkgs/pie_chart/src/utils.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].start;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].end;
  }

  @override
  String getSubject(int index) {
    return appointments![index].course.task;
  }

  @override
  Color getColor(int index) {
    return pinknessColorList[index];
  }
}
