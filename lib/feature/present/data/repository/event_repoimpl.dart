import 'package:event_attendance_mobile/core/config/database_helper.dart';
import 'package:event_attendance_mobile/feature/present/data/models/event_model.dart';
import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';
import 'package:event_attendance_mobile/feature/present/domain/repository/event_repository.dart';

/*
  Defines the actual implementation of the data manipulation
  The methods here are defined by EventRepository

  Interacts with the database - SQLFlite
*/
class EventRepoimpl implements EventRepository {
  final DatabaseHelper db;

  EventRepoimpl(this.db);

  @override
  Future<List<EventEntity>> getEvent() async {
    final databaseInstance = await db.database;
    try {
      final List<Map<String, Object?>> eventMaps = await databaseInstance.query(
        'events',
      );
      return eventMaps
          .map((event) => EventModel.fromMap(event).toEntity())
          .toList();
    } catch (e) {
      throw Exception('Error fetching events: $e');
    }
  }

  @override
  Future<void> addEvent(EventEntity event) async {
    try {
      final databaseInstance = await db.database;

      await databaseInstance.insert(
        'events',
        EventModel.fromEntity(event).toMap(),
      );
    } catch (e) {
      throw Exception('Error adding event: $e');
    }
  }

  @override
  Future<void> deleteEvent(int eventId) async {
    try {
      final databaseInstance = await db.database;

      await databaseInstance.delete(
        'events',
        where: 'id = ?',
        whereArgs: [eventId],
      );
    } catch (e) {
      throw Exception('Error deleting event: $e');
    }
  }

  @override
  Future<void> updateEvent(EventEntity event) async {
    try {
      final databaseInstance = await db.database;

      await databaseInstance.update(
        'events',
        EventModel.fromEntity(event).toMap(),
        where: 'id = ?',
        whereArgs: [event.id],
      );
    } catch (e) {
      throw Exception('Error updating event: $e');
    }
  }
}
