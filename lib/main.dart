import 'package:flutter/material.dart';
import 'courses_main_page.dart';

const String appName = "MUss";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appName,
      home: CoursesMainPage(),
    );
  }
}
