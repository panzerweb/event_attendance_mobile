import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:flutter/material.dart';

class BuildDatetime extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;

  const BuildDatetime({
    super.key,
    required this.label,
    this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Palette.darkTextSecondary),
      ),
      leading: const Icon(
        Icons.calendar_month,
        color: Palette.darkTextSecondary,
      ),
      title: Text(label, style: TextStyle(color: Palette.darkTextSecondary)),
      subtitle: Text(
        date!.toLocal().toString().split(' ')[0],
        style: const TextStyle(color: Palette.darkTextSecondary),
      ),
    );
  }
}
