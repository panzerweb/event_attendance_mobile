import 'package:flutter/material.dart';

/*
  COMPONENT FOLDER: Common widgets that are reusable to the entire application

  Reusable component for each TextFields and Controllers in a form or user input
  fields.

  Usage:
    FieldLabel(message: string),
    TextField(params...),
*/

class FieldLabel extends StatelessWidget {
  final String message;
  const FieldLabel({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        message,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}
