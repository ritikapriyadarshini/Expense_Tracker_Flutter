import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  String calculateWeeklyTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tueday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
  ) {
    List<double> values= [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tueday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    double total= 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    //get yyyymmdd for each day of the week
    String sunday = convertDateTimeToString(startOfWeek.add(Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(Duration(days: 1)));
    String tueday = convertDateTimeToString(startOfWeek.add(Duration(days: 2)));
    String wednesday = convertDateTimeToString(startOfWeek.add(Duration(days: 3)));
    String thursday = convertDateTimeToString(startOfWeek.add(Duration(days: 4)));
    String friday = convertDateTimeToString(startOfWeek.add(Duration(days: 5)));
    String saturday = convertDateTimeToString(startOfWeek.add(Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Column(
        children: [
          //weekly total
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  "Weekly Total: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "₹${calculateWeeklyTotal(value, sunday, monday, tueday, wednesday, thursday, friday, saturday)}",
                  style: TextStyle(color: Colors.red[900]),
                )
              ],
            ),
          ),

          //bar graph
          SizedBox(
            height: 200,
            child: MyBarGraph(
              maxY: 100,
              sunAmt: value.calculateDailyExpenseSummary()[sunday] ?? 0,
              monAmt: value.calculateDailyExpenseSummary()[monday] ?? 0,
              tueAmt: value.calculateDailyExpenseSummary()[tueday] ?? 0,
              wedAmt: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
              thursAmt: value.calculateDailyExpenseSummary()[thursday] ?? 0,
              friAmt: value.calculateDailyExpenseSummary()[friday] ?? 0,
              satAmt: value.calculateDailyExpenseSummary()[saturday] ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
