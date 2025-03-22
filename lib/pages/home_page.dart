import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseRupController = TextEditingController();
  final newExpensePaiseController= TextEditingController();

  @override
  void initState() {
    super.initState();
    
    //prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // add a new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add a new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              controller: newExpenseNameController,
              decoration: InputDecoration(
                hintText: "Expense Item"
              ),
            ),

            // expense amount
            Row(
              children: [
                //Rupees
                Expanded(
                  child: TextField(
                    controller: newExpenseRupController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Rupees",
                    ),
                  ),
                ),
                //Paise
                Expanded(
                  child: TextField(
                    controller: newExpensePaiseController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Paise",
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        actions: [
          //cancel
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          ),

          //save
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),

          
        ],
      ),
    );
  }

  //cancel
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  //delete
  void deleteExpense(ExpenseItem expense){
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  //save
  void save() {
    //adding .00 to paise when not entered by user
    String paisa= newExpensePaiseController.text.isEmpty? '00': newExpensePaiseController.text;
    //putting Rupees and Paise together
    String amt= '${newExpenseRupController.text}.$paisa' ;
    //create new expense item
    ExpenseItem newExpenseItem = ExpenseItem(
      name: newExpenseNameController.text,
      amount: amt,
      dateTime: DateTime.now(),
    );
    //add new expense item
    Provider.of<ExpenseData>(context, listen: false)
        .addNewExpense(newExpenseItem);
    Navigator.pop(context);
    clear();
  }

  //clear
  void clear() {
    newExpenseRupController.clear();
    newExpensePaiseController.clear();
    newExpenseNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.grey[850],
          foregroundColor: Colors.grey,
          child: Icon(Icons.add),
        ),
        body: ListView(
          children: [
            //weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),

            SizedBox(height: 20,),

            //expense list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  amount: value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                  deleteTapped:(p0) => deleteExpense(value.getAllExpenseList()[index]),
                  onPressed: (p0) => {},
                ),
            ),
          ],
        )
      ),
    );
  }
}
