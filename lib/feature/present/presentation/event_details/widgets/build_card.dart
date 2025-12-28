import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:flutter/material.dart';

class BuildCard extends StatelessWidget {
  final Widget child;
  const BuildCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Palette.primaryBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }
}
