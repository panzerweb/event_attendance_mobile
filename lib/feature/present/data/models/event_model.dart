import 'package:event_attendance_mobile/feature/present/domain/entities/event_entity.dart';

/*

  Model for the Event Entity

  naming case are like that to align with the database fields
  although pwde ra i camelCase nako pero sagdi rani oy
*/

class EventModel {
  final int? id;
  final String? event_name;
  final String? start_date;
  final String? end_date;
  final String? event_description;
  final int? is_complete;
  final int? priority_id;
  final String created_at;

  EventModel({
    this.id,
    this.event_name,
    this.start_date,
    this.end_date,
    this.event_description,
    this.is_complete = 0,
    this.priority_id,
    required this.created_at,
  });

  factory EventModel.fromEntity(EventEntity entity) {
    return EventModel(
      id: entity.id,
      event_name: entity.event_name,
      start_date: entity.start_date?.toIso8601String(),
      end_date: entity.end_date?.toIso8601String(),
      event_description: entity.event_description,
      is_complete: entity.is_complete == false ? 0 : 1,
      priority_id: entity.priority_id,
      created_at: entity.created_at.toIso8601String(),
    );
  }

  EventEntity toEntity() {
    return EventEntity(
      id: id,
      event_name: event_name ?? '',
      start_date: start_date != null ? DateTime.parse(start_date!) : null,
      end_date: end_date != null ? DateTime.parse(end_date!) : null,
      event_description: event_description,
      is_complete: is_complete == 1,
      priority_id: priority_id ?? 0,
      created_at: DateTime.parse(created_at),
    );
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] as int?,
      event_name: map['event_name'] as String?,
      start_date: map['start_date'] as String?,
      end_date: map['end_date'] as String?,
      event_description: map['event_description'] as String?,
      is_complete: map['is_complete'] as int?,
      priority_id: map['priority_id'] as int?,
      created_at:
          map['created_at'] as String? ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'event_name': event_name,
      'start_date': start_date,
      'end_date': end_date,
      'event_description': event_description,
      'is_complete': is_complete,
      'priority_id': priority_id,
      'created_at': created_at,
    };
  }

  EventModel.empty()
    : id = 0,
      event_name = '',
      start_date = '',
      end_date = '',
      event_description = '',
      is_complete = 0,
      priority_id = 0,
      created_at = '';

  @override
  String toString() {
    return 'Event{id: $id, event_name: $event_name, start_date: $start_date, end_date: $end_date}';
  }
}
