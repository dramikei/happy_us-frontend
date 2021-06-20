import 'package:get/get.dart';
import 'package:happy_us/models/volunteer.dart';

class VolunteerController extends GetxController {
  Rx<Volunteer> volunteer = Volunteer.initialObj().obs;

  bool get isLoggedIn => volunteer.value.age != -1;

  void updateVolunteer(Volunteer updatedVolunteer) {
    volunteer.value = updatedVolunteer;
  }

  void logout() => volunteer.value = Volunteer.initialObj();
}
