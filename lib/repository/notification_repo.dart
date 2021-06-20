import 'package:happy_us/models/notification.dart';
import 'package:happy_us/utils/globals.dart';

class NotificationRepo {
  static final _dio = Globals.dio;
  static final _requestHandler = Globals.requestHandler;

  static Future<List<Notification>?> getUserNotifications() =>
      _requestHandler<Notification, List<Notification>>(
          _dio.get('/notification'));

  static Future<bool?> markedSeen({required String notificationId}) =>
      _requestHandler<bool, bool>(
          _dio.get('/notification/markSeen/$notificationId'));
}
