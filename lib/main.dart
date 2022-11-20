import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'backend/my_database.dart';
import 'frontend/courses_main_page.dart';
import 'frontend/event_record_page.dart';

const String appName = "MUss";

void main() {
  Get.put(MyDatabase());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appName,
      home: EventRecordPage(),
    );
  }
}
