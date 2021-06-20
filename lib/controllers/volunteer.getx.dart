import 'package:get/get.dart';
import 'package:happy_us/models/volunteer.dart';

class VolunteerController extends GetxController {
  Rx<Volunteer> volunteer = Volunteer.initialObj().obs;

  void updateVolunteer(Volunteer updatedVolunteer) {
    volunteer.value = updatedVolunteer;
  }
}
