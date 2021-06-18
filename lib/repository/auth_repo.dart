import 'dart:async';

import 'package:happy_us/models/base_user.dart';
import 'package:happy_us/models/user.dart';
import 'package:happy_us/utils/globals.dart';

class AuthRepo {
  static final _dio = Globals.dio;
  static final _requestHandler = Globals.requestHandler;

  static Future login({
    required String username,
    required String password,
    required UserType type,
  }) =>
      _requestHandler(_dio.post(
        '/auth/login',
        data: {
          "username": username,
          "password": password,
          "type": type.userTypeAsString,
        },
      ));

  // only for user -- volunteer can't be created from app
  static Future<User?> register({
    required String username,
    required String password,
    required int age,
    required Map<String, dynamic> social,
    String? fcmToken,
  }) =>
      _requestHandler(_dio.post(
        '/auth/register',
        data: {
          "type": "user",
          "username": username,
          "fcmToken": "string",
          "password": password,
          "age": age,
          "social": social,
        },
      ));

  static Future<bool?> changePassword({
    required String oldPassword,
    required String newPassword,
  }) =>
      _requestHandler<bool>(_dio.patch(
        '/auth/changePassword',
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        },
      ));
}
