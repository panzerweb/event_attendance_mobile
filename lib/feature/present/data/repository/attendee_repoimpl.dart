import 'package:event_attendance_mobile/core/config/database_helper.dart';
import 'package:event_attendance_mobile/feature/present/data/models/attendee_model.dart';
// import 'package:event_attendance_mobile/feature/present/data/models/event_model.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/attendee_entity.dart';
import 'package:event_attendance_mobile/feature/present/domain/repository/attendee_repository.dart';

class AttendeeRepoimpl implements AttendeeRepository {
  final DatabaseHelper db;

  AttendeeRepoimpl({required this.db});

  @override
  Future<List<AttendeeEntity>> loadAllAttendees() async {
    try {
      final databaseInstance = await db.database;
      final List<Map<String, Object?>> attendees = await databaseInstance.query(
        'attendees',
      );

      return attendees
          .map((attendee) => AttendeeModel.fromMap(attendee).toEntity())
          .toList();
    } catch (e) {
      throw Exception("Error fetching attendees: $e");
    }
  }

  @override
  Future<List<AttendeeEntity>> getAttendees({required int eventId}) async {
    try {
      final databaseInstance = await db.database;
      final List<Map<String, Object?>> attendees = await databaseInstance.query(
        'attendees',
        where: 'event_id = ?',
        whereArgs: [eventId],
      );

      return attendees
          .map((attendee) => AttendeeModel.fromMap(attendee).toEntity())
          .toList();
    } catch (e) {
      throw Exception("Error fetching attendees: $e");
    }
  }

  @override
  Future<void> addAttendee(AttendeeEntity attendee) async {
    try {
      final databaseInstance = await db.database;

      await databaseInstance.insert(
        'attendees',
        AttendeeModel.fromEntity(attendee).toMap(),
      );
    } catch (e) {
      throw Exception("Error adding attendee: $e");
    }
  }

  @override
  Future<void> deleteAttendee(int attendeeId) async {
    try {
      final databaseInstance = await db.database;

      await databaseInstance.delete(
        'attendees',
        where: 'id = ?',
        whereArgs: [attendeeId],
      );
    } catch (e) {
      throw Exception("Error deleting attendee: $e");
    }
  }

  @override
  Future<void> updateAttendee(AttendeeEntity attendee) async {
    try {
      final databaseInstance = await db.database;
      await databaseInstance.update(
        'attendees',
        AttendeeModel.fromEntity(attendee).toMap(),
        where: 'id = ?',
        whereArgs: [attendee.id],
      );
    } catch (e) {
      throw Exception("Error updating attendee: $e");
    }
  }
}
