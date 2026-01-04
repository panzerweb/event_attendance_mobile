import 'package:flutter/material.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';

class AttendeeSummaryCard extends StatelessWidget {
  final int attendeeCount;
  final VoidCallback onViewPressed;

  const AttendeeSummaryCard({
    super.key,
    required this.attendeeCount,
    required this.onViewPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Palette.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // LEFT ICON
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Palette.accentPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.people,
                size: 32,
                color: Palette.textPrimary,
              ),
            ),

            const SizedBox(width: 16),

            // TITLE + COUNT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Attendees",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Palette.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    attendeeCount.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Palette.textPrimary,
                    ),
                  ),
                ],
              ),
            ),

            // VIEW BUTTON
            ElevatedButton(
              onPressed: onViewPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.darkCardBg,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("View"),
            ),
          ],
        ),
      ),
    );
  }
}
