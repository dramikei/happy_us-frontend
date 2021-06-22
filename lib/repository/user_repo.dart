import 'package:happy_us/models/user.dart';
import 'package:happy_us/utils/globals.dart';

class UserRepo {
  static final _dio = Globals.dio;
  static final _requestHandler = Globals.requestHandler;

  static Future<User?> getLoggedInUser() =>
      _requestHandler<User, User>(_dio.get('/user'));

  static Future<User?> updateUser({
    String? username,
    int? age,
    String? fcm,
    Map<String, String>? social,
  }) =>
      _requestHandler<User, User>(_dio.patch(
        '/user',
        data: {
          if (username != null) 'username': username,
          if (age != null) 'age': age,
          if (fcm != null) 'fcmToken': fcm,
          if (social != null) 'social': social,
        },
      ));

  static Future<bool?> deleteUser() =>
      _requestHandler<bool, bool>(_dio.delete('/user'));
}
