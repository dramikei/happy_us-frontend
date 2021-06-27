class Appointment {
  late final String id;
  late final Map<String, dynamic> userSocial;
  late String status;
  late final DateTime time;
  late final String userId;
  late final String volunteerId;
  late String? message;

  Appointment.fromJson(Map<String, dynamic> json) {
    userSocial = json['userSocial'] ?? {};
    status = json['status'];
    id = json['_id'];
    time = DateTime.parse(json['time']).subtract(
      Duration(hours: 5, minutes: 30),
    );
    userId = json['userId'];
    volunteerId = json['volunteerId'];
    message = json['message'];
  }
}
