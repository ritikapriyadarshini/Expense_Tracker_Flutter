//convert datetime to string
String convertDateTimeToString(DateTime dateTime){

  //date in format dd
  String date= dateTime.day.toString();
  if (date.length == 1) {
    date = '0$date';
  }

  //month in format mm
  String month= dateTime.month.toString();
  if(month.length == 1){
   month = '0$month';
  }

  //year in format yyyy
  String year= dateTime.year.toString();

  //final format -> (yyyymmdd)
  String yyyymmdd= year + month + date;

  return yyyymmdd;
}