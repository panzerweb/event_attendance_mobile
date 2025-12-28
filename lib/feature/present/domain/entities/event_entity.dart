/*
  Business logic of the entire mobile application

  Defines the fields and properties of the app itself, this one in particular
  is for the Events Entity only

  This is free from all the frameworks, this just business logic
*/
class EventEntity {
  final int? id;
  final String? event_name;
  final DateTime? start_date;
  final DateTime? end_date;
  String? event_description;
  final bool? is_complete;
  final int? priority_id;
  final DateTime created_at;

  EventEntity({
    this.id,
    this.event_name,
    this.start_date,
    this.end_date,
    this.event_description,
    this.is_complete = false,
    this.priority_id,
    required this.created_at,
  });

  EventEntity toggleCompletion() {
    return EventEntity(
      id: id,
      event_name: event_name,
      start_date: start_date,
      end_date: end_date,
      event_description: event_description,
      is_complete: !is_complete!,
      priority_id: priority_id,
      created_at: created_at,
    );
  }
}
