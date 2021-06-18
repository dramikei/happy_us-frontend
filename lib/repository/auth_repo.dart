import 'dart:async';

import 'package:happy_us/models/base_user.dart';
import 'package:happy_us/models/user.dart';
import 'package:happy_us/utils/instances.dart';

class AuthRepo {
  static final _dio = Instances.dio;

  static Future<Map<String, dynamic>?> login({
    required String username,
    required String password,
    required UserType type,
  }) async {
    // based on type return
    // {
    //   type: user,
    //   entity: Instance<User | Volunteer>
    // }
  }

  // only for user -- volunteer can't be created from app
  static Future<User?> register({
    required String username,
    required String password,
    required int age,
    required Map<String, dynamic> social,
    String? fcmToken,
  }) async {}

  static Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    return true;
  }
}
