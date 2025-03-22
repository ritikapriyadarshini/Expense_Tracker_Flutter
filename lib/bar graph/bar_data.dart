import 'package:expense_tracker/bar%20graph/individual_bars.dart';

class BarData {
  final double sunAmt;
  final double monAmt;
  final double tueAmt;
  final double wedAmt;
  final double thursAmt;
  final double friAmt;
  final double satAmt;

  BarData({
    required this.sunAmt,
    required this.monAmt,
    required this.tueAmt,
    required this.wedAmt,
    required this.thursAmt,
    required this.friAmt,
    required this.satAmt,
  });

  List<IndividualBar> barData= [];

  //initialize bar data
  void initializeBarData(){

    barData=[
    //sun
    IndividualBar(x: 0, y: sunAmt),

    //mon
    IndividualBar(x: 1, y: monAmt),

    //tue
    IndividualBar(x: 2, y: tueAmt),

    //wed
    IndividualBar(x: 3, y: wedAmt),

    //thurs
    IndividualBar(x: 4, y: thursAmt),

    //fri
    IndividualBar(x: 5, y: friAmt),

    //sat
    IndividualBar(x: 6, y: satAmt), 
    ] ;
  }
}
