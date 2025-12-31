import 'package:event_attendance_mobile/core/components/empty_list_message.dart';
import 'package:event_attendance_mobile/core/components/scaffold_appbar.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/attendee_entity.dart';
import 'package:event_attendance_mobile/feature/present/presentation/attendees/bloc/attendee_cubit.dart';
import 'package:event_attendance_mobile/feature/present/presentation/attendees/widgets/attendee_tile.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/bloc/event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AttendeesPage extends StatelessWidget {
  const AttendeesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldAppbar(title: "Attendees"),
      body: BlocBuilder<AttendeeCubit, List<AttendeeEntity>>(
        builder: (context, attendees) {
          return Padding(
            padding: EdgeInsetsGeometry.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: context.pop,
                          icon: Icon(Icons.turn_left, size: 28),
                        ),
                        Text(
                          "Attendees",
                          style: TextStyle(
                            fontSize: 22,
                            color: Palette.darkTextPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Expanded(
                  child: attendees.isEmpty
                      ? EmptyListMessage(
                          message: "Empty Attendees",
                          subtitle: "Return back to add an attendee",
                        )
                      : ListView.builder(
                          itemCount: attendees.length,
                          itemBuilder: (context, index) {
                            final attendee = attendees[index];

                            return AttendeeTile(attendee: attendee);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
