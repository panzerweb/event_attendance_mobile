/*

  Model for the Event Priorities

  Data are seeded directly with the DatabaseHelper
  Therefore, there is no need for a domain and repository
*/

class PriorityModel {
  final int id;
  final String priority_name;
  final String created_at;

  PriorityModel({
    required this.id,
    required this.priority_name,
    required this.created_at,
  });

  factory PriorityModel.fromMap(Map<String, dynamic> map) {
    return PriorityModel(
      id: map['id'] as int,
      priority_name: map['priority_name'] as String,
      created_at: map['created_at'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'priority_name': priority_name, 'created_at': created_at};
  }
}
