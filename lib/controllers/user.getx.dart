import 'package:get/get.dart';
import 'package:happy_us/models/user.dart';

class UserController extends GetxController {
  Rx<User> user = User.initialObj().obs;

  bool get isLoggedIn => user.value.age != -1;

  void updateUser(User updatedUser) {
    user.value = updatedUser;
  }

  void logout() => user.value = User.initialObj();
}
