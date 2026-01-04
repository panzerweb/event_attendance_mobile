import 'package:event_attendance_mobile/core/constant/priority_enums.dart';
import 'package:event_attendance_mobile/core/helper/format_dates.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/bloc/event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/*
  Widget for each tiles
  
  Highly customizable
*/

class EventTile extends StatelessWidget {
  final EventEntity event;

  const EventTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // Badge configuration
    String eventName = PriorityEnums.low.name;
    Color? backGround;

    switch (event.priority_id) {
      case 1:
        backGround = Colors.green.shade700;
        eventName = PriorityEnums.low.name;
        break;
      case 2:
        backGround = Colors.yellow.shade700;
        eventName = PriorityEnums.medium.name;
        break;
      case 3:
        backGround = Colors.red.shade700;
        eventName = PriorityEnums.high.name;
        break;
      default:
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Palette.darkCardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ───────────── TOP ROW ─────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Complete Button
                IconButton(
                  onPressed: () {
                    context.read<EventCubit>().toggleEventCubit(event);
                  },
                  icon: event.is_complete!
                      ? const Icon(Icons.check_box_rounded)
                      : const Icon(Icons.check_box_outline_blank_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: event.is_complete!
                        ? Colors.green.shade700
                        : Palette.fieldBg,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// Title + Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Event name
                      Text(
                        event.event_name!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// Date Range
                      Text(
                        "${formatDates(event.start_date)} - ${formatDates(event.end_date)}",
                        style: TextStyle(
                          color: Palette.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                /// Edit Button
                IconButton(
                  onPressed: () {
                    context.go('/dashboard/event/${event.id}');
                  },
                  icon: const Icon(Icons.edit_note_rounded),
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

            const SizedBox(height: 12),

            /// ───────────── BOTTOM ROW ─────────────
            Row(
              children: [
                /// Status / Priority Badge
                Badge(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  backgroundColor: backGround,
                  label: Text(
                    eventName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const Spacer(),

                /// Optional subtitle / status
                if (event.is_complete!)
                  Text(
                    "Completed",
                    style: TextStyle(
                      color: Colors.green.shade400,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
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
