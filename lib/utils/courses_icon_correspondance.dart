import 'package:flutter/material.dart';

IconData? courseIcon(int index, List<String> coursesList) {
  switch (coursesList[index]) {
    case "SLEEP":
      return Icons.bedtime;
    case "WRITE":
      return Icons.edit;
    case "STUDY":
      return Icons.menu_book;
    case "WORK":
      return Icons.people;
    case "WORKOUT":
      return Icons.fitness_center;
    case "NAP":
      return Icons.notifications_paused;
    case "SOCIAL":
      return Icons.emoji_food_beverage;
    case "看手机":
      return Icons.phone_android;
    case "出门运动":
      return Icons.run_circle_outlined;
    default:
      return Icons.add;
  }
}
