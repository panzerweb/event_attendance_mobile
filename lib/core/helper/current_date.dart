import 'package:intl/intl.dart';

String currentDateFormat() {
  DateTime currentDate = DateTime.now();
  DateFormat formatDate = DateFormat("MMMM dd, yyyy");
  String currentFormattedDate = formatDate.format(currentDate);

  return currentFormattedDate;
}
