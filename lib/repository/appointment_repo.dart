import 'package:happy_us/models/appointment.dart';
import 'package:happy_us/utils/globals.dart';

class AppointmentRepo {
  static final _dio = Globals.dio;
  static final _requestHandler = Globals.requestHandler;

  static Future<Appointment?> createAppointment({
    required String volunteerId,
    required Map<String, dynamic> userSocial,
    required DateTime time,
  }) =>
      _requestHandler<Appointment?, Appointment>(_dio.post(
        '/appointment',
        data: {
          "volunteerId": volunteerId,
          "userSocial": userSocial,
          "time": time.toString(),
        },
      ));

  static Future<List<Appointment>?> getUserAppointments() =>
      _requestHandler<Appointment, List<Appointment>>(_dio.get('/appointment'));

  // to used only by volunteer
  static Future<Appointment?> updateStatus({
    required String status,
    required String appointmentId,
    required String message,
  }) =>
      _requestHandler<Appointment?, Appointment>(_dio.patch(
        '/appointment',
        data: {
          "status": status,
          "appointmentId": appointmentId,
          "message": message,
        },
      ));
}
