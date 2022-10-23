import 'package:flutter/material.dart';

class LegendTail extends StatelessWidget {
  const LegendTail({
    required this.value,
    required this.style,
    Key? key,
  }) : super(key: key);

  final double value;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2.0),
          height: 20,
          width: 18.0,
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            getTime(value), // minute to hours & minute
            style: style,
            softWrap: true,
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
      ],
    );
  }
}

String getTime(double timeInMinute) {
  int minute = (timeInMinute % 60).toInt();
  int hours = (timeInMinute / 60).floor();
  if (hours == 0) return "$minute min";
  return "$hours h $minute min";
}
