import 'package:event_attendance_mobile/feature/present/domain/entities/attendee_entity.dart';

class AttendeeModel {
  final int? id;
  final String? attendee_name;
  final int? event_id;
  final int? is_blacklisted;
  final String created_at;

  AttendeeModel({
    this.id,
    this.attendee_name,
    this.event_id,
    this.is_blacklisted = 0,
    required this.created_at,
  });

  factory AttendeeModel.fromEntity(AttendeeEntity attendee) {
    return AttendeeModel(
      id: attendee.id,
      attendee_name: attendee.attendee_name,
      event_id: attendee.event_id,
      is_blacklisted: attendee.is_blacklisted == false ? 0 : 1,
      created_at: attendee.created_at.toIso8601String(),
    );
  }

  AttendeeEntity toEntity() {
    return AttendeeEntity(
      id: id,
      attendee_name: attendee_name ?? '',
      event_id: event_id!,
      is_blacklisted: is_blacklisted == 1,
      created_at: DateTime.parse(created_at),
    );
  }

  factory AttendeeModel.fromMap(Map<String, dynamic> map) {
    return AttendeeModel(
      id: map['id'] as int?,
      attendee_name: map['attendee_name'] as String?,
      event_id: map['event_id'] as int?,
      is_blacklisted: map['is_blacklisted'] as int?,
      created_at:
          map['created_at'] as String? ?? DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attendee_name': attendee_name,
      'event_id': event_id!,
      'is_blacklisted': is_blacklisted,
      'created_at': created_at,
    };
  }

  AttendeeModel.empty()
    : id = 0,
      attendee_name = '',
      event_id = 0,
      is_blacklisted = 0,
      created_at = '';
}
