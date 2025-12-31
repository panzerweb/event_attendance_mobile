class AttendeeEntity {
  final int? id;
  final String? attendee_name;
  final int? event_id;
  final bool? is_blacklisted;
  final DateTime created_at;

  AttendeeEntity({
    this.id,
    this.attendee_name,
    this.event_id,
    this.is_blacklisted = false,
    required this.created_at,
  });

  AttendeeEntity toggleAttendeeStatus() {
    return AttendeeEntity(
      id: id,
      attendee_name: attendee_name,
      event_id: event_id,
      is_blacklisted: !is_blacklisted!,
      created_at: created_at,
    );
  }
}
