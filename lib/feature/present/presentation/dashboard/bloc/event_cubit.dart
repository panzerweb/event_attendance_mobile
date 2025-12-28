import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';
import 'package:event_attendance_mobile/feature/present/domain/repository/event_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

/*

  Cubit for the Event Entity

  Handles interacting with the repository to finally implement a business logic
  UI interacts with the Cubit through a provider
*/

class EventCubit extends Cubit<List<EventEntity>> {
  final EventRepository eventRepo;

  final DateTime date = DateTime.now();
  String get formattedDate => DateFormat('yyyy-MM-dd').format(date);

  // Constructor, as well as initiate loading of events
  EventCubit(this.eventRepo) : super([]) {
    loadEvents();
  }

  // Load All Events Cubit
  Future<void> loadEvents() async {
    final events = await eventRepo.getEvent();

    emit(events);
  }

  // Adding Event Cubit
  Future<void> addEventCubit(
    String eventName,
    DateTime startDate,
    DateTime endDate,
    String? eventDescription,
    int priorityId,
  ) async {
    final newEvent = EventEntity(
      event_name: eventName,
      start_date: startDate,
      end_date: endDate,
      event_description: eventDescription,
      priority_id: priorityId,
      created_at: DateTime.parse(formattedDate),
    );
    await eventRepo.addEvent(newEvent);
    await loadEvents();
  }

  // Updating Event Cubit
  Future<void> updateEventCubit(
    int? eventId,
    String? eventName,
    DateTime? startDate,
    DateTime? endDate,
    String? eventDescription,
    int? priorityId,
  ) async {
    final updatedEvent = EventEntity(
      id: eventId,
      event_name: eventName,
      start_date: startDate,
      end_date: endDate,
      event_description: eventDescription,
      priority_id: priorityId,
      created_at: DateTime.parse(formattedDate),
    );

    await eventRepo.updateEvent(updatedEvent);
    await loadEvents();
  }

  // Delete an Event Cubit
  Future<void> deleteEventCubit(EventEntity event) async {
    await eventRepo.deleteEvent(event.id!);

    loadEvents();
  }

  // Update only the is_complete status of the event
  Future<void> toggleEventCubit(EventEntity event) async {
    final updatedStatus = event.toggleCompletion();

    await eventRepo.updateEvent(updatedStatus);
    await loadEvents();
  }
}
