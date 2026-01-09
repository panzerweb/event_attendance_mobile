import 'package:event_attendance_mobile/core/components/scaffold_appbar.dart';
import 'package:event_attendance_mobile/core/helper/shared_helper.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:flutter/material.dart';

class SetProfilePage extends StatefulWidget {
  const SetProfilePage({super.key});

  @override
  State<SetProfilePage> createState() => _SetProfilePageState();
}

class _SetProfilePageState extends State<SetProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _bioController;

  String username = '';
  String bio = '';

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _bioController = TextEditingController();

    _loadProfile();
  }

  Future<void> _loadProfile() async {
    _usernameController.text = await SharedHelper.loadProfile('username');
    _bioController.text = await SharedHelper.loadProfile('bio');
  }

  Future<void> _setProfile() async {
    final newUsername = _usernameController.text.trim();
    final newBio = _bioController.text.trim();
    // Update (this overwrites if key exists, creates if not)
    await SharedHelper.setPrefs('username', newUsername);
    await SharedHelper.setPrefs('bio', newBio);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Set Profile",
          style: TextStyle(color: Palette.textPrimary),
        ),
        backgroundColor: Palette.primaryColor,
        foregroundColor: Palette.textPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            // Avatar placeholder
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Colors.grey.shade500,
                child: const Icon(Icons.person, size: 48, color: Colors.white),
              ),
            ),

            const SizedBox(height: 32),

            // Username
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                hintText: "Enter your username",
                prefixIcon: const Icon(Icons.alternate_email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Bio
            TextField(
              controller: _bioController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Bio",
                hintText: "Tell us something about you",
                prefixIcon: const Icon(Icons.edit_note),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // CTA Button
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: _setProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.fieldBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Set Profile",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Palette.textPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
