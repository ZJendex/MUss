import 'package:flutter/material.dart';
import '../pie_chart.dart';

class LegendOptions {
  final bool showLegends;
  final bool showLegendsInRow;
  final TextStyle legendTextStyle;
  final TextStyle legendTailTextStyle;
  final BoxShape legendShape;
  final LegendPosition legendPosition;
  final Map<String, String> legendLabels;

  const LegendOptions({
    this.showLegends = true,
    this.showLegendsInRow = false,
    this.legendTextStyle = defaultLegendStyle,
    this.legendTailTextStyle = defaultLegendStyle,
    this.legendShape = BoxShape.circle,
    this.legendPosition = LegendPosition.right,
    this.legendLabels = const {},
  });
}
