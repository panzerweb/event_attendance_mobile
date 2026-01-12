import 'package:event_attendance_mobile/feature/present/domain/entities/attendee_entity.dart';

abstract class AttendeeRepository {
  Future<List<AttendeeEntity>> getAttendees({required int eventId});
  Future<List<AttendeeEntity>> loadAllAttendees();
  Future<void> addAttendee(AttendeeEntity attendee);
  Future<void> updateAttendee(AttendeeEntity attendee);
  Future<void> deleteAttendee(int attendeeId);
}
