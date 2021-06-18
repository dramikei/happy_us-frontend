import 'package:happy_us/models/notification.dart';
import 'package:happy_us/utils/instances.dart';

class NotificationRepo {
  static final _dio = Instances.dio;

  static Future<List<Notification>> getUserNotifications() async {
    return [];
  }

  static Future<bool> markedSeen({required String notificationId}) async {
    return true;
  }
}
