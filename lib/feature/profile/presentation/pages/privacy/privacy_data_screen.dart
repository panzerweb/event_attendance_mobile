import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:flutter/material.dart';

class PrivacyDataScreen extends StatelessWidget {
  const PrivacyDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Privacy & Data",
          style: TextStyle(color: Palette.textPrimary),
        ),
        backgroundColor: Palette.primaryColor,
        foregroundColor: Palette.textPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Intro
              const Text(
                "Your Privacy Matters",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 8),
              const Text(
                "This app respects your privacy. All data is stored locally on your device and is not sent to any server.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              // Stored Data
              const Text(
                "Data Stored Locally",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 4),
              const Text(
                "• Events you create\n"
                "• Attendees added to events\n"
                "• Your app preferences (like text size)\n\n"
                "No personal data is collected or shared.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              // Data Management
              const Text(
                "Data Management",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 4),
              const Text(
                "You can clear all stored data from the settings page. "
                "This will remove all events, attendees, and preferences.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              // Footer
              Center(
                child: Text(
                  "Your data stays private and offline. 💚",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
