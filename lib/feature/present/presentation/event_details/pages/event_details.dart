import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';
import 'package:event_attendance_mobile/feature/present/presentation/dashboard/bloc/event_cubit.dart';
import 'package:event_attendance_mobile/feature/present/presentation/event_details/pages/edit_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventDetails extends StatefulWidget {
  final String eventId;

  const EventDetails({super.key, required this.eventId});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<EventCubit, List<EventEntity>>(
        builder: (context, events) {
          for (var event in events) {
            if (event.id == int.parse(widget.eventId)) {
              return EditEvent(event: event);
            }
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
