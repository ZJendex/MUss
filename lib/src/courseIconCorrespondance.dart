import 'package:flutter/material.dart';

IconData? courseIcon(int index, List<String> coursesList) {
  switch (coursesList[index]) {
    case "SLEEP":
      return Icons.bedtime;
    case "WRITE":
      return Icons.edit;
    case "READ":
      return Icons.menu_book;
    case "WORK":
      return Icons.people;
    case "WORKOUT":
      return Icons.fitness_center;
    case "NAP":
      return Icons.notifications_paused;
    default:
      return Icons.add;
  }
}
