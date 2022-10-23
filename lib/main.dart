import 'package:flutter/material.dart';
import 'course.dart';

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
      home: Courses(),
    );
  }
}
