import 'package:get/get.dart';
import 'package:happy_us/models/appointment.dart';

class AppointmentController extends GetxController {
  RxList<Appointment> appointments = <Appointment>[].obs;

  void insertAppointments(List<Appointment> fetchedAppointments) {
    appointments.value = fetchedAppointments;
  }

  void updateStatus({
    required String appointmentId,
    required String message,
    required String status,
  }) {
    // ignore: invalid_use_of_protected_member
    final values = appointments.value;
    for (int i = 0; i < values.length; i++) {

      if (values[i].id == appointmentId) {
        // ignore: invalid_use_of_protected_member
        appointments.value[i].message = message;
        // ignore: invalid_use_of_protected_member
        appointments.value[i].status = status;
        break;
      }
    }
  }
}
