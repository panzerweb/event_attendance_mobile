import 'package:event_attendance_mobile/feature/present/domain/entities/attendee_entity.dart';
import 'package:event_attendance_mobile/feature/present/domain/repository/attendee_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

/*

  Cubit for the Attendee Entity

  Handles interacting with the repository to finally implement a business logic
  UI interacts with the Cubit through a provider
*/

class AttendeeCubit extends Cubit<List<AttendeeEntity>> {
  final AttendeeRepository attendeeRepo;

  final DateTime date = DateTime.now();
  String get formattedDate => DateFormat('yyyy-MM-dd').format(date);

  AttendeeCubit(this.attendeeRepo) : super([]) {
    loadAllAttendees();
  }

  Future<void> loadAllAttendees() async {
    final attendees = await attendeeRepo.loadAllAttendees();

    emit(attendees);
  }

  Future<void> loadAttendees(int eventId) async {
    final attendees = await attendeeRepo.getAttendees(eventId: eventId);

    emit(attendees);
  }

  Future<void> addAttendeeCubit(String attendeeName, int eventId) async {
    final newAttendee = AttendeeEntity(
      attendee_name: attendeeName,
      event_id: eventId,
      created_at: DateTime.parse(formattedDate),
    );

    await attendeeRepo.addAttendee(newAttendee);
    await loadAttendees(eventId);
  }

  Future<void> updateAttendeeCubit(
    int? attendeeId,
    String? attendeeName,
    int? eventId,
  ) async {
    final updatedAttendee = AttendeeEntity(
      id: attendeeId,
      attendee_name: attendeeName,
      event_id: eventId,
      created_at: DateTime.parse(formattedDate),
    );

    await attendeeRepo.updateAttendee(updatedAttendee);
    await loadAttendees(eventId!);
  }

  Future<void> deleteAttendeeCubit(AttendeeEntity attendee) async {
    await attendeeRepo.deleteAttendee(attendee.id!);

    await loadAttendees(attendee.event_id!);
  }

  Future<void> toggleAttendeeStatus(AttendeeEntity attendee) async {
    final toggleStatus = attendee.toggleAttendeeStatus();

    await attendeeRepo.updateAttendee(toggleStatus);
    await loadAttendees(attendee.event_id!);
  }
}
