import 'package:expense_tracker/data/hive_db.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier{
  // list all the expenses
  List<ExpenseItem> overallExpenseList= [];

  // get expense list
  List<ExpenseItem> getAllExpenseList(){
    return overallExpenseList;
  }

  //prepare data
  final db = HiveDb();
  void prepareData(){
    //if previous data exists
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
    }
  }

  // add new expense
  void addNewExpense(ExpenseItem newExpenseItem){
    overallExpenseList.add(newExpenseItem);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // delete expense
  void deleteExpense(ExpenseItem expense){
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  // get weekday (mon, tue, wed, etc) from a dateTime object
  String getDayName(DateTime dateTime){
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thurs';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // get date from start of the week ( Sunday )
  DateTime startOfWeekDate(){
    DateTime? startOfWeek;

    //get today's date
    DateTime today= DateTime.now();

    //go backwards from today to Sunday
    for(int i=0; i<7; i++){
      if(getDayName(today.subtract(Duration(days: i)))=='Sun'){
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }


  // now I have a list of expenses overall that looks something like: 

  /*

    Convert overall expense list to daily expense list

    e.g.

    overallExpenseList = 
    [
      [food, 2025/02/20, $15],
      [dress, 2025/02/20, $10],
      [rent, 2025/02/21, $100],
      [groceries, 2025/02/22, $5],
      [drinks, 2025/02/23, $40],
      [chips, 2025/02/23, $2],
    ]

    =>

    dailyExpenseList = 
    [
      [20250220: $25],
      [20250221: $100],
      [20250222: $5],
      [20250223: $42],
    ]

  */
  Map<String, double> calculateDailyExpenseSummary(){
    Map<String, double> dailyExpenseSummary= {
      //date (YYYYMMDD): amountTotalForDay
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount+= amount;
        dailyExpenseSummary[date]= currentAmount;
      } else{
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }


}