import 'package:flutter/material.dart';
import 'package:muss/backend/models/event_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../backend/models/course.dart';
import '../backend/models/event.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: 40),
          child: SfCalendar(
            firstDayOfWeek: 7,
            view: CalendarView.month,
            monthViewSettings: const MonthViewSettings(
                showAgenda: true,
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
            dataSource: EventDataSource(_eventsList()),
          )),
    );
  }

  List<Event> _eventsList() {
    final List<Event> events = <Event>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 18, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    // events.add(Event(
    //     course: Course(name: "SLEEP", task: "in bed"),
    //     minutes: 20,
    //     start: startTime));
    // events.add(Event(
    //     course: Course(name: "SLEEP", task: "dairy"),
    //     minutes: 30,
    //     start: DateTime(today.year, today.month, today.day, 9, 0, 0)));
    return events;
  }
}
