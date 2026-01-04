import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final int listCount;
  final String label;
  final IconData leadingIcon;
  final Color cardColor;
  // final VoidCallback? onViewPressed;
  // final bool isCallback;

  const SummaryCard({
    super.key,
    required this.listCount,
    required this.label,
    required this.leadingIcon,
    required this.cardColor,
    // this.onViewPressed,
    // required this.isCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Row(
          children: [
            // LEFT ICON
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Palette.textAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                leadingIcon,
                size: 32,
                color: Palette.darkTextSecondary,
              ),
            ),

            const SizedBox(width: 16),

            // TITLE AND COUNT
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: cardColor == Palette.darkCardBg
                        ? Palette.textSecondary
                        : Palette.darkTextSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  listCount.toString(),
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: cardColor == Palette.darkCardBg
                        ? Palette.textPrimary
                        : Palette.darkTextPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
