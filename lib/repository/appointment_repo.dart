import 'package:happy_us/models/appointment.dart';
import 'package:happy_us/utils/instances.dart';

class AppointmentRepo {
  static final _dio = Instances.dio;
  static final _requestHandler = Instances.requestHandler;

  static Future<Appointment?> createAppointment({
    required String volunteerId,
    required Map<String, dynamic> userSocial,
    required DateTime time,
  }) =>
      _requestHandler<Appointment?>(_dio.get(''));

  static Future<List<Appointment>?> getUserAppointments() =>
      _requestHandler<List<Appointment>>(_dio.get(''));

  // to used only by volunteer
  static Future<Appointment?> updateStatus({
    required String status,
    required String appointmentId,
    required String message,
  }) =>
      _requestHandler<Appointment?>(_dio.get(''));
}
