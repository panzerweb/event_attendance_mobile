import 'package:event_attendance_mobile/core/helper/current_date.dart';
import 'package:event_attendance_mobile/core/helper/show_delete_dialog.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/attendee_entity.dart';
import 'package:event_attendance_mobile/feature/present/presentation/attendees/bloc/attendee_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendeeTile extends StatefulWidget {
  final AttendeeEntity attendee;

  const AttendeeTile({super.key, required this.attendee});

  @override
  State<AttendeeTile> createState() => _AttendeeTileState();
}

class _AttendeeTileState extends State<AttendeeTile> {
  bool get isBlacklisted => widget.attendee.is_blacklisted == true;

  Future<void> _deleteAttendee(AttendeeEntity attendee) async {
    await showDeleteDialog<AttendeeEntity>(
      context: context,
      entity: attendee,
      message: 'Are you sure you wanna delete this attendee?',
      onDelete: (event) =>
          context.read<AttendeeCubit>().deleteAttendeeCubit(event),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isBlacklisted
            ? const Color.fromARGB(255, 56, 13, 10)
            : Palette.darkCardBg,
        borderRadius: BorderRadius.circular(16),
        border: isBlacklisted
            ? Border.all(color: Colors.redAccent, width: 1)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            /// ───────── Avatar ─────────
            CircleAvatar(
              radius: 24,
              backgroundColor: isBlacklisted
                  ? Colors.redAccent
                  : Palette.textPrimary,
              child: Icon(
                isBlacklisted ? Icons.block : Icons.person,
                color: isBlacklisted ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(width: 14),

            /// ───────── Info ─────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.attendee.attendee_name ?? "Unknown Attendee",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isBlacklisted
                          ? Colors.redAccent
                          : Palette.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const SizedBox(width: 8),
                      _MetaChip(
                        icon: Icons.schedule,
                        label: currentDateFormat(),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// ───────── Actions ─────────
            Column(
              children: [
                IconButton(
                  tooltip: isBlacklisted
                      ? "Remove from blacklist"
                      : "Blacklist attendee",
                  icon: Icon(
                    isBlacklisted ? Icons.lock_open : Icons.block,
                    color: isBlacklisted ? Colors.orange : Colors.redAccent,
                  ),
                  onPressed: () {
                    context.read<AttendeeCubit>().toggleAttendeeStatus(
                      widget.attendee,
                    );
                  },
                ),

                IconButton(
                  tooltip: "Delete attendee",
                  icon: const Icon(Icons.delete, color: Colors.grey),
                  onPressed: () async {
                    _deleteAttendee(widget.attendee);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}
