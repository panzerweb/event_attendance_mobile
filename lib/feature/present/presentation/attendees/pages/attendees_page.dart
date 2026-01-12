import 'package:event_attendance_mobile/core/components/empty_list_message.dart';
import 'package:event_attendance_mobile/core/components/scaffold_appbar.dart';
import 'package:event_attendance_mobile/core/constant/attendee_status_enums.dart';
import 'package:event_attendance_mobile/core/styles/palette.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/attendee_entity.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';
import 'package:event_attendance_mobile/feature/present/presentation/attendees/bloc/attendee_cubit.dart';
import 'package:event_attendance_mobile/feature/present/presentation/attendees/widgets/attendee_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final Map<AttendeeStatusEnums, String> attendeeStatus = {
  AttendeeStatusEnums.all: 'All',
  AttendeeStatusEnums.blacklisted: 'Blacklisted',
  AttendeeStatusEnums.whitelisted: 'Whitelisted',
};

class AttendeesPage extends StatefulWidget {
  final EventEntity event;

  const AttendeesPage({super.key, required this.event});

  @override
  State<AttendeesPage> createState() => _AttendeesPageState();
}

class _AttendeesPageState extends State<AttendeesPage> {
  List<AttendeeEntity> filteredList = []; // AN EMPTY TO BE ADDED LATER
  AttendeeStatusEnums? _selectedOption = AttendeeStatusEnums.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScaffoldAppbar(title: "Attendees"),
      body: BlocBuilder<AttendeeCubit, List<AttendeeEntity>>(
        builder: (context, attendees) {
          // For selecting filters
          switch (_selectedOption) {
            case AttendeeStatusEnums.blacklisted:
              final blacklistedAttendees = attendees.where(
                (attendee) => attendee.is_blacklisted == true,
              );
              filteredList.clear();
              filteredList.addAll(blacklistedAttendees);
              break;
            case AttendeeStatusEnums.whitelisted:
              final whitelistedAttendees = attendees.where(
                (attendee) => attendee.is_blacklisted == false,
              );
              filteredList.clear();
              filteredList.addAll(whitelistedAttendees);
              break;
            default:
              final allAttendees = attendees;
              filteredList.clear();
              filteredList.addAll(allAttendees);
          }

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
                          "Attendees for ${widget.event.event_name}",
                          style: TextStyle(
                            fontSize: 22,
                            color: Palette.darkTextPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    DropdownMenu<AttendeeStatusEnums>(
                      initialSelection: _selectedOption,
                      // The default requestFocusOnTap value depends on the platform.
                      // On mobile, it defaults to false, and on desktop, it defaults to true.
                      // Setting this to true will trigger a focus request on the text field, and
                      // the virtual keyboard will appear afterward.
                      requestFocusOnTap: false,
                      label: const Text('Filter'),
                      onSelected: (value) {
                        setState(() {
                          _selectedOption = value;
                          // debugPrint(_selectedOption);
                        });
                      },
                      dropdownMenuEntries: attendeeStatus.entries.map((entry) {
                        return DropdownMenuEntry<AttendeeStatusEnums>(
                          value: entry.key,
                          label: entry.value,
                        );
                      }).toList(),
                    ),
                  ],
                ),

                Expanded(
                  child: filteredList.isEmpty
                      ? EmptyListMessage(
                          message: "Empty Attendees",
                          subtitle: "Return back to add an attendee",
                        )
                      : ListView.builder(
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            final attendee = filteredList[index];

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
