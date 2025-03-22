import 'dart:ffi';

import 'package:expense_tracker/bar%20graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmt;
  final double monAmt;
  final double tueAmt;
  final double wedAmt;
  final double thursAmt;
  final double friAmt;
  final double satAmt;

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmt,
    required this.monAmt,
    required this.tueAmt,
    required this.wedAmt,
    required this.thursAmt,
    required this.friAmt,
    required this.satAmt,
  });

  @override
  Widget build(BuildContext context) {
    //initialize bar data
    BarData myBarData = BarData(
      sunAmt: sunAmt,
      monAmt: monAmt,
      tueAmt: tueAmt,
      wedAmt: wedAmt,
      thursAmt: thursAmt,
      friAmt: friAmt,
      satAmt: satAmt,
    );

    double maxYaxis = ([
          sunAmt,
          monAmt,
          tueAmt,
          wedAmt,
          thursAmt,
          friAmt,
          satAmt
        ].reduce((a, b) => a > b ? a : b)) *
        1.2;

    maxYaxis= maxYaxis> 0 ? maxYaxis: 100;

    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        minY: 0,
        maxY: maxYaxis,
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles:
                SideTitles(showTitles: true, getTitlesWidget: getBottomTiles),
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: Colors.grey[800],
                      width: 25,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxYaxis,
                        color: Colors.grey[200],
                      )),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

Widget getBottomTiles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'Sun',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'Mon',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'Tue',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'Wed',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'Thu',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'Fri',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'Sat',
        style: style,
      );
      break;

    default:
      text = const Text(
        '',
        style: style,
      );
      break;
  }

  return SideTitleWidget(
    meta: meta,
    child: text,
  );
}
