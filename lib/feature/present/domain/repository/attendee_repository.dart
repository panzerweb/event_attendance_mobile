import 'package:event_attendance_mobile/feature/present/domain/entities/attendee_entity.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';

abstract class AttendeeRepository {
  Future<List<AttendeeEntity>> getAttendees({required int eventId});
  Future<void> addAttendee(AttendeeEntity attendee);
  Future<void> updateAttendee(AttendeeEntity attendee);
  Future<void> deleteAttendee(int attendeeId);
}
