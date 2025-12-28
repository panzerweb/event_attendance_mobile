import 'package:intl/intl.dart';

String formatDates(DateTime? typeOfDate) {
  DateFormat formatter = DateFormat("MMMM dd, yyyy");
  String formattedDate = formatter.format(typeOfDate!);

  return formattedDate;
}
