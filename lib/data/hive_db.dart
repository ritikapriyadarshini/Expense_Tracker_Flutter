import 'package:expense_tracker/models/expense_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDb {
  //reference the box
  final _myBox = Hive.box('expense_db');

  //read
  List<ExpenseItem> readData() {
    /*

    Data is stored in Hive as a list of srings + dateTime
    So let's convert our saved data into ExpenseItem objects

    saveData =
    [
      [name, amount, dateTime],
      ..
    ]

    ->

    [
      ExpenseItem{ name/ amount/ dateTime },
      ..
    ]

    */

    List savedExpense = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpense.length; i++) {
      //collect individual expense data
      String name = savedExpense[i][0];
      String amount = savedExpense[i][1];
      DateTime dateTime = savedExpense[i][2];

      //create expense item
      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );

      //add expense to overall list of expenses
      allExpenses.add(expense);
    }

    return allExpenses;
  }

  //write
  void saveData(List<ExpenseItem> allExpense) {
    /* 
    
    Hive can only store basic primite type like strings, dateTime, int, and not custom objects like ExpenseItem.
    So lets convert ExpenseItem objects into types that can be stored in out db

    allExpense =
    [
      ExpenseItem [ name / amount / dateTime],
      ...
    ]

    ->

    [
      [name, amount, dateTime],
      ...
    ]

    */
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      //convert each expenseItem into a list of storabletypes (strings, dateTime)
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    //finally lets store in our box
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }
}
