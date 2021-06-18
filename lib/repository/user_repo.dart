import 'package:happy_us/models/user.dart';
import 'package:happy_us/utils/instances.dart';

class UserRepo {
  static final _dio = Instances.dio;

  static Future<User?> findOne() async {}

  static Future<User?> updateUser({
    String? username,
    int? age,
    String? fcm,
    Map<String, String>? social,
  }) async {
    return null;
  }

  static Future<bool> deleteUser() async {
    return true;
  }
}
