import 'package:intl/intl.dart';

/*
  REUSABLE:
    Helper function for formatting dates
    2025-12-25 -> December 25, 2025

    Usage:
      Text(
          "${formatDates(event.start_date)} - ${formatDates(event.end_date)}",
          style: TextStyle(
            color: Palette.textSecondary,
            fontSize: 13,
          ),
        ),

*/

String formatDates(DateTime? typeOfDate) {
  DateFormat formatter = DateFormat("MMMM dd, yyyy");
  String formattedDate = formatter.format(typeOfDate!);

  return formattedDate;
}
