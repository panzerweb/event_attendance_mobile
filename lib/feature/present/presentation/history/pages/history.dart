import 'package:event_attendance_mobile/core/components/empty_list_message.dart';
import 'package:event_attendance_mobile/core/components/scaffold_appbar.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/bloc/event_cubit.dart';
import 'package:event_attendance_mobile/feature/present/presentation/history/widgets/history_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ScaffoldAppbar(title: "History"),
      body: BlocBuilder<EventCubit, List<EventEntity>>(
        builder: (context, events) {
          final completedEvents = events
              .where((e) => e.is_complete == true)
              .toList();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 4.0,
                    children: [
                      Icon(
                        Icons.history,
                        size: 24,
                        color: Palette.darkTextPrimary,
                      ),
                      const Text(
                        "History",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Palette.darkTextPrimary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // 👇 This fixes the layout
                  Expanded(
                    child: completedEvents.isEmpty
                        ? const EmptyListMessage(
                            message: "Empty completed events!",
                            subtitle:
                                'Check some active events back in the dashboard',
                          )
                        : ListView.builder(
                            itemCount: completedEvents.length,
                            itemBuilder: (context, index) {
                              final event = completedEvents[index];
                              return HistoryTile(event: event);
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
