import 'package:event_attendance_mobile/core/helper/current_date.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/widgets/stat_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*

  Header card in the Dashboard

  Allows the adding of event by going to the add_event route
  Shows the overview upcoming and total events

*/

class HeaderCard extends StatelessWidget {
  final String? user;
  final List<EventEntity> events;

  const HeaderCard({super.key, required this.user, required this.events});

  // Helpers
  static int _upcomingCount(List<EventEntity> events) {
    final now = DateTime.now();
    return events.where((e) => e.start_date!.isAfter(now)).length;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Palette.primaryColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ───────────── TOP ROW ─────────────
              Row(
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Palette.accentPurple,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.event_available,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Welcome Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back,",
                          style: TextStyle(
                            color: Palette.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          user ?? 'Guest',
                          style: TextStyle(
                            color: Palette.textPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Add Button
                  IconButton(
                    onPressed: () => context.push('/dashboard/event'),
                    icon: const Icon(Icons.add),
                    style: IconButton.styleFrom(
                      backgroundColor: Palette.accentPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// ───────────── DATE ─────────────
              Text(
                "Today • ${currentDateFormat()}",
                style: TextStyle(color: Palette.textSecondary, fontSize: 14),
              ),

              const SizedBox(height: 16),

              /// ───────────── STATS ─────────────
              Row(
                children: [
                  StatItem(
                    label: "Total Events",
                    value: events.length.toString(),
                    icon: Icons.event_note,
                  ),

                  const SizedBox(width: 16),

                  StatItem(
                    label: "Upcoming",
                    value: _upcomingCount(events).toString(),
                    icon: Icons.schedule,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
