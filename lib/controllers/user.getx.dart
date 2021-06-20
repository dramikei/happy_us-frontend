import 'package:get/get.dart';
import 'package:happy_us/models/user.dart';

class UserController extends GetxController {
  Rx<User> user = User.initialObj().obs;

  void updateUser(User updatedUser) {
    user.value = updatedUser;
  }
}
