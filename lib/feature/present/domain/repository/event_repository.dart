import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';

/*
  Business logic of the entire mobile application

  Defines the methods that will be used for the application
  Methods that are gonna be used for Event manipulation
*/

abstract class EventRepository {
  Future<List<EventEntity>> getEvent();

  Future<void> addEvent(EventEntity event);

  Future<void> updateEvent(EventEntity event);

  Future<void> deleteEvent(int id);

  Future<void> clearAllEvents();
}
