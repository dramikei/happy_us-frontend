import 'package:happy_us/models/appointment.dart';
import 'package:happy_us/utils/instances.dart';

class AppointmentRepo {
  static final _dio = Instances.dio;

  static Future<Appointment?> createAppointment({
    required String volunteerId,
    required Map<String, dynamic> userSocial,
    required DateTime time,
  }) async {
    return null;
  }

  static Future<List<Appointment>> getUserAppointments() async {
    return [];
  }

  // to used only by volunteer
  static Future<Appointment?> updateStatus({
    required String status,
    required String appointmentId,
    required String message,
  }) async {}
}
