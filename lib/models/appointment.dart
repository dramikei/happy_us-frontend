class Appointment {
  late final String id;
  late final Map<String, dynamic> userSocial;
  late final String status;
  late final DateTime time;
  late final String userId;
  late final String volunteerId;
  late final String? message;

  Appointment.fromJson(Map<String, dynamic> json) {
    userSocial = json['userSocial'] ?? {};
    status = json['status'];
    id = json['_id'];
    time = DateTime.parse(json['time']);
    userId = json['userId'];
    volunteerId = json['volunteerId'];
    message = json['message'];
  }
}
