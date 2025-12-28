import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:flutter/material.dart';

class EmptyListMessage extends StatelessWidget {
  final String message;
  final String? subtitle;
  const EmptyListMessage({super.key, required this.message, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              color: Palette.darkTextSecondary,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            subtitle!,
            style: TextStyle(
              color: Palette.darkTextAccent,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
