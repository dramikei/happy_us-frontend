import 'package:get/get.dart';
import 'package:happy_us/models/notification.dart' as notification;

class NotificationController extends GetxController {
  RxList<notification.Notification> notifications =
      <notification.Notification>[].obs;

  void insertNotifications(
      List<notification.Notification> incomingNotifications) {
    notifications.value = incomingNotifications;
  }

  void updateSeen(String notificationId) {
    // ignore: invalid_use_of_protected_member
    final values = notifications.value;

    for (int i = 0; i < values.length; i++) {
      if (values[i].id == notificationId) {
        // ignore: invalid_use_of_protected_member
        notifications[i].seen = true;
        break;
      }
    }
  }
}
