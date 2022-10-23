import 'package:flutter/material.dart';

const defaultChartValueStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const defaultLegendStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
);

const List<Color> defaultColorList = [
  Color(0xFFff7675),
  Color(0xFF74b9ff),
  Color(0xFF55efc4),
  Color(0xFFffeaa7),
  Color(0xFFa29bfe),
  Color(0xFFfd79a8),
  Color(0xFFe17055),
  Color(0xFF00b894),
];

Color getColor(List<Color> colorList, int index) {
  if (index > (colorList.length - 1)) {
    final newIndex = index % (colorList.length - 1);
    return colorList.elementAt(newIndex);
  }
  return colorList.elementAt(index);
}

List<Color> getGradient(List<List<Color>> gradientList, int index,
    {required bool isNonGradientElementPresent,
    required List<Color> emptyColorGradient}) {
  index = isNonGradientElementPresent ? index - 1 : index;
  if (index == -1) {
    return emptyColorGradient;
  } else if (index > (gradientList.length - 1)) {
    final newIndex = index % gradientList.length;
    return gradientList.elementAt(newIndex);
  }
  return gradientList.elementAt(index);
}

// custom val
List<Color> brownessColorList = const [
  Color.fromARGB(255, 0, 78, 162), // SLEEP
  Color.fromARGB(255, 0, 113, 171), // NAP
  Color.fromARGB(255, 172, 108, 86), // WRITE
  Color.fromARGB(255, 95, 39, 29), // READ
  Color.fromARGB(255, 212, 166, 81), // WORK
  Color.fromARGB(255, 228, 142, 81), // WORKOUT
  Color.fromARGB(255, 101, 87, 86), // OTHERS
  Color.fromARGB(255, 101, 87, 86), // RANDOM1
  Color.fromARGB(255, 101, 87, 86), // RANDOM2
  Color.fromARGB(255, 101, 87, 86) // RANDOM3
];
List<Color> pinknessColorList = const [
  Color.fromARGB(255, 0, 78, 162), // SLEEP
  Color.fromARGB(255, 0, 113, 171), // NAP
  Color.fromARGB(255, 156, 100, 167), // WRITE
  Color.fromARGB(255, 227, 198, 207), // READ
  Color.fromARGB(255, 199, 45, 117), // WORK
  Color.fromARGB(255, 92, 16, 40), // WORKOUT
  Color.fromARGB(255, 101, 87, 86), // OTHERS
  Color.fromARGB(255, 101, 87, 86), // RANDOM1
  Color.fromARGB(255, 101, 87, 86), // RANDOM2
  Color.fromARGB(255, 101, 87, 86) // RANDOM3
];

Map<String, double> testPieChart = {
  "SLEEP": 80,
  "NAP": 10,
  "WRITE": 10,
  "READ": 20,
  "WORK": 60,
  "WORKOUT": 50,
  "OTHERS": 55
};
