import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:flutter/material.dart';

/*
  COMPONENT FOLDER: Common widgets that are reusable to the entire application

  Reusable component for instances a query has empty values.

  Usage:
  List<type>.empty or List<type>.isNotEmpty 
    return EmptyListMessage(message: string, subtitle: string);
*/

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
