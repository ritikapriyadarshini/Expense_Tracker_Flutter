import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;
  void Function(BuildContext)? editTapped;

  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
    required this.editTapped
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          //delete button
          CustomSlidableAction(
            onPressed: deleteTapped,
            foregroundColor: Colors.white70,
            backgroundColor: Colors.redAccent,
            borderRadius: BorderRadius.circular(4),
            child: Icon(
              Icons.delete,
              color: Colors.grey[200],
            ),
          ),
          //edit button
          SlidableAction(
            onPressed: editTapped,
            icon: Icons.edit,
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey[850]),
        ),
        subtitle: Text(
          '${dateTime.day.toString()}/${dateTime.month.toString()}/${dateTime.year.toString()}',
        ),
        trailing: Text(
          '₹$amount',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.red[900],
          ),
        ),
      ),
    );
  }
}
