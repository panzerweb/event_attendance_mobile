import 'package:intl/intl.dart';

/*
  REUSABLE:
    Helper function for retrieving current date

    Usage:
      Text(${currentDateFormat()}),

*/

String currentDateFormat() {
  DateTime currentDate = DateTime.now();
  DateFormat formatDate = DateFormat("MMMM dd, yyyy");
  String currentFormattedDate = formatDate.format(currentDate);

  return currentFormattedDate;
}
