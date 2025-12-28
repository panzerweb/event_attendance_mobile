import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:flutter/material.dart';

class BuildTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final int? maxLines;
  final String? Function(String?)? validator;

  const BuildTextfield({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.maxLines,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Palette.darkTextSecondary),
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[300],
        prefixIcon: Icon(icon, color: Palette.darkTextPrimary),
        labelText: label,
        labelStyle: TextStyle(color: Palette.darkTextPrimary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Palette.darkTextSecondary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Palette.darkTextSecondary),
        ),
      ),
    );
  }
}
