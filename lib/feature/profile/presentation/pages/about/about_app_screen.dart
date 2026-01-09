import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About This App",
          style: TextStyle(color: Palette.textPrimary),
        ),
        backgroundColor: Palette.primaryColor,
        foregroundColor: Palette.textPrimary,
      ),
      body: SingleChildScrollView(
        // allows scrolling if content grows
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Name
            Text(
              "Present",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const SizedBox(height: 8),

            // Description
            const Text(
              "Event Attendance Management Mobile Application.\n\n"
              "This app allows you to add events and track attendees. "
              "It is a personal side project developed for learning Flutter "
              "and practicing clean architecture.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Features
            const Text(
              "Features",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            const Text(
              "• Add and manage events\n"
              "• Add attendees to events\n"
              "• Block attendees\n"
              "• Event history\n"
              "• Offline-first design (works without internet)\n"
              "• Clean architecture & Flutter BLoC state management",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Developer
            const Text(
              "Developer",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            const Text("Panzerweb"),
            const SizedBox(height: 24),

            // Motivation / Why
            const Text(
              "Motivation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            const Text(
              "This project is a learning experiment to practice Flutter, "
              "BLoC, and Clean Architecture. It helps me understand "
              "how to structure apps properly while building something functional.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Future Plans
            const Text(
              "Future Plans",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            const Text(
              "• Add notifications for events\n"
              "• Enable CSV export for attendance\n"
              "• Add multi-event reporting dashboard\n"
              "• Improve UI/UX design",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Licenses
            const Text(
              "Licenses",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 4),
            const Text(
              "This is a personal project. No third-party licenses are used.",
            ),
            const SizedBox(height: 24),

            // Footer / Optional
            Center(
              child: Text(
                "Thank you for using Present! 💚",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
