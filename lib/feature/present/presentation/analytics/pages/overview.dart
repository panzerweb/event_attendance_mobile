import 'package:event_attendance_mobile/core/components/scaffold_appbar.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/attendee_entity.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';
import 'package:event_attendance_mobile/feature/present/presentation/analytics/widgets/summary_card.dart';
import 'package:event_attendance_mobile/feature/present/presentation/attendees/bloc/attendee_cubit.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/bloc/event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  // Count of upcoming events
  static int _upcomingCount(List<EventEntity> events) {
    final now = DateTime.now();
    return events.where((e) => e.start_date!.isAfter(now)).length;
  }

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  void initState() {
    super.initState();

    context.read<AttendeeCubit>().loadAllAttendees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldAppbar(title: "Overview"),
      body: BlocBuilder<EventCubit, List<EventEntity>>(
        builder: (context, events) {
          // All Events Count
          int? eventLength = events.length;
          // Completed Events Count
          final completedEvents = events.where(
            (event) => event.is_complete == true,
          );
          int? completedEventLength = completedEvents.length;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  spacing: 4.0,
                  children: [
                    Icon(
                      Icons.analytics,
                      size: 32,
                      color: Palette.darkTextPrimary,
                    ),
                    const Text(
                      "Analytics",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Palette.darkTextPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Summary Cards
                    Expanded(
                      child: SummaryCard(
                        listCount: eventLength,
                        label: "Total Events",
                        leadingIcon: Icons.event_note,
                        cardColor: Palette.darkCardBg,
                      ),
                    ),
                    Expanded(
                      child: SummaryCard(
                        listCount: Overview._upcomingCount(events),
                        label: "Upcoming Events",
                        leadingIcon: Icons.schedule,
                        cardColor: Palette.darkCardBg,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                BlocBuilder<AttendeeCubit, List<AttendeeEntity>>(
                  builder: (context, attendees) {
                    final blacklistedAttendees = attendees.where(
                      (attendee) => attendee.is_blacklisted == true,
                    );
                    return Column(
                      children: [
                        SummaryCard(
                          listCount: attendees.length,
                          label: "Total Attendees",
                          leadingIcon: Icons.people,
                          cardColor: Palette.lightCardBg,
                        ),
                        SizedBox(height: 8),
                        SummaryCard(
                          listCount: blacklistedAttendees.length,
                          label: "Blacklisted Attendees",
                          leadingIcon: Icons.person_add_disabled_rounded,
                          cardColor: Palette.lightCardBg,
                        ),
                      ],
                    );
                  },
                ),

                SummaryCard(
                  listCount: completedEventLength,
                  label: "Completed Events",
                  leadingIcon: Icons.event_available_sharp,
                  cardColor: Palette.lightCardBg,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
