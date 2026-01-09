import 'package:event_attendance_mobile/core/components/empty_list_message.dart';
import 'package:event_attendance_mobile/core/components/scaffold_appbar.dart';
import 'package:event_attendance_mobile/core/helper/shared_helper.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/bloc/event_cubit.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/widgets/event_tile.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/widgets/header_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String? username;

  @override
  void initState() {
    super.initState();

    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final loadUsername = await SharedHelper.loadProfile('username');

    setState(() {
      username = loadUsername;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Navigation Bar
      appBar: ScaffoldAppbar(
        title: "Track Your Events",
        username: username,
        onProfileUpdate: _loadProfile,
      ),
      // Provides the list of events with buttons to correspond to the Cubit methods
      // The main interface of dashboard
      body: BlocBuilder<EventCubit, List<EventEntity>>(
        builder: (context, events) {
          var incompleteEvents = events
              .where((event) => event.is_complete == false)
              .toList();
          return Material(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    // Header Card for the Dashboard
                    HeaderCard(user: username, events: events),

                    SizedBox(height: 12),

                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "List of Events",
                            style: TextStyle(
                              fontSize: 24,
                              color: Palette.darkTextPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),

                    // List of Events
                    // 👇 This fixes the layout
                    Expanded(
                      child: incompleteEvents.isEmpty
                          ? const EmptyListMessage(
                              message: "Empty completed events!",
                              subtitle: "Press the '+' button to add events",
                            )
                          : ListView.builder(
                              itemCount: incompleteEvents.length,
                              itemBuilder: (context, index) {
                                final event = incompleteEvents[index];
                                return EventTile(event: event);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
