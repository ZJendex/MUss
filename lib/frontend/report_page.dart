import 'package:flutter/material.dart';
import 'package:muss/pkgs/pie_chart/pie_chart.dart';
import 'package:muss/backend/txt_db.dart';

class ReportPage extends StatefulWidget {
  final TxtDB tdb;

  const ReportPage({Key? key, required this.tdb}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  bool loadingFinish = false;
  Map<String, double> cumulateCoursesDuration = {};
  String currentDays = "0";

  @override
  void initState() {
    initInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loadingFinish
        ? Container(
            color: const Color.fromARGB(255, 179, 217, 245),
            padding: const EdgeInsets.all(50),
            child: GestureDetector(
              child: PieChart(
                  chartLegendSpacing: 70,
                  centerText: "DAY $currentDays",
                  centerTextStyle: const TextStyle(
                      color: Color.fromARGB(255, 0, 49, 83),
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: false,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: true,
                    chartValueStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  emptyColor: Colors.white,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 100,
                  colorList: pinknessColorList,
                  legendOptions: LegendOptions(
                      legendTextStyle: TextStyle(
                        color: const Color.fromARGB(255, 0, 49, 83)
                            .withOpacity(0.88),
                        decoration: TextDecoration.none,
                        fontSize: 12,
                      ),
                      legendTailTextStyle: TextStyle(
                        color: const Color.fromARGB(255, 0, 49, 83)
                            .withOpacity(0.88),
                        decoration: TextDecoration.none,
                        fontSize: 12,
                      ),
                      legendPosition: LegendPosition.bottom,
                      showLegendsInRow: false),
                  dataMap: cumulateCoursesDuration),
              onDoubleTap: () => Navigator.pop(context),
            ))
        : Container(
            color: const Color.fromARGB(255, 179, 217, 245),
            child: GestureDetector(
              child: const Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation(Colors.black),
              )),
              onDoubleTap: () => Navigator.pop(context),
            ),
          );
  }

  void initInfo() async {
    await widget.tdb
        .cumulateCoursesDuration()
        .then((value) => cumulateCoursesDuration = value);
    currentDays = await widget.tdb.getCurrentDays();
    setState(() {
      loadingFinish = true;
    });
  }
}
