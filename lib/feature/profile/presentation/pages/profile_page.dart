import 'package:event_attendance_mobile/core/components/text_scale_cubit.dart';
import 'package:event_attendance_mobile/core/helper/shared_helper.dart';
import 'package:event_attendance_mobile/core/helper/show_confirm.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/bloc/event_cubit.dart';
import 'package:event_attendance_mobile/feature/profile/presentation/widgets/setting_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? username;
  String? bio;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final loadUsername = await SharedHelper.loadProfile('username');
    final loadBio = await SharedHelper.loadProfile('bio');
    setState(() {
      username = loadUsername;
      bio = loadBio;
    });
  }

  // Clear all events
  Future<void> clearAll() async {
    await showConfirmDialog(
      context: context,
      title: "Clear all events",
      message: "This will permanently delete all events.",
      confirmText: "Clear",
      onConfirm: () {
        return context.read<EventCubit>().clearAllEventsCubit();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Palette.primaryColor,
            foregroundColor: Palette.textPrimary,
            expandedHeight: 280,
            pinned: true,
            centerTitle: true,

            title: const Text("Profile"),

            // Edit button
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  await context.push('/profile/user');
                  _loadUserProfile();
                },
              ),
            ],

            // Renders the main content
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.only(bottom: 32),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, size: 48, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      username ?? 'Guest',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      bio ?? '---',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Example content below the app bar
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    // Notifications
                    SettingSection(
                      title: "Notifications",
                      children: [
                        //  Switch list tile uncommented if feature is okay
                        // SwitchListTile(
                        //   title: const Text("Event reminders"),
                        //   subtitle: const Text(
                        //     "Get notified before events start",
                        //   ),
                        //   value: true,
                        //   onChanged: (value) {},
                        //   secondary: const Icon(Icons.notifications),
                        // ),
                        ListTile(
                          leading: const Icon(Icons.notifications_none),
                          title: const Text("Event reminders"),
                          subtitle: const Text(
                            "Notification feature is under development",
                          ),
                        ),
                      ],
                    ),

                    SettingSection(
                      title: "Data & Storage",
                      children: [
                        ListTile(
                          leading: const Icon(Icons.delete_outline),
                          title: const Text("Clear data"),
                          subtitle: const Text("Remove all event data"),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () async {
                            // show confirmation dialog
                            clearAll();
                            // print("Clicked");
                          },
                        ),
                      ],
                    ),

                    SettingSection(
                      title: "Accessibility & App Info",
                      children: [
                        ListTile(
                          leading: const Icon(Icons.text_fields),
                          title: const Text("Text size"),
                          subtitle: const Text("Adjust font scaling"),
                          trailing: DropdownButton<double>(
                            value: context.watch<TextScaleCubit>().state,
                            items: const [
                              DropdownMenuItem(
                                value: 0.9,
                                child: Text("Small"),
                              ),
                              DropdownMenuItem(
                                value: 1.0,
                                child: Text("Medium"),
                              ),
                              DropdownMenuItem(
                                value: 1.2,
                                child: Text("Large"),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                context.read<TextScaleCubit>().setTextScale(
                                  value,
                                );
                              }
                            },
                          ),
                        ),
                        const Divider(height: 4),

                        ListTile(
                          leading: const Icon(Icons.info_outline),
                          title: const Text("About this app"),
                          subtitle: const Text(
                            "Developer, licenses, and details",
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            context.push('/profile/about');
                          },
                        ),
                        const Divider(height: 4),

                        ListTile(
                          leading: const Icon(Icons.privacy_tip_outlined),
                          title: const Text("Privacy & data"),
                          subtitle: const Text("View stored data information"),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            context.push('/profile/privacy');
                          },
                        ),
                        const Divider(height: 4),

                        ListTile(
                          leading: const Icon(Icons.app_settings_alt),
                          title: const Text("App version"),
                          subtitle: const Text("You're using the latest build"),
                          trailing: const Text("Beta 1.1"),
                          onTap: null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
