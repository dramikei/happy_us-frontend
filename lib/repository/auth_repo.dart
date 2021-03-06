import 'dart:async';

import 'package:happy_us/models/user.dart';
import 'package:happy_us/models/volunteer.dart';
import 'package:happy_us/utils/globals.dart';

class AuthRepo {
  static final _dio = Globals.dio;
  static final _requestHandler = Globals.requestHandler;

  static Future<bool?> pingServer() =>
      _requestHandler<bool, bool>(_dio.get('/ping'));

  static Future<User?> loginUser({
    required String username,
    required String password,
    String? fcmToken,
  }) =>
      _requestHandler<User, User>(_dio.post(
        '/auth/login',
        data: {
          "username": username,
          "password": password,
          "type": 'user',
          'fcmToken': fcmToken,
        },
      ));

  static Future<Volunteer?> loginVolunteer({
    required String username,
    required String password,
    String? fcmToken,
  }) =>
      _requestHandler<Volunteer, Volunteer>(_dio.post(
        '/auth/login',
        data: {
          "username": username,
          "password": password,
          "type": 'volunteer',
          'fcmToken': fcmToken,
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
      _requestHandler<User, User>(_dio.post(
        '/auth/register',
        data: {
          "type": "user",
          "username": username,
          "fcmToken": fcmToken,
          "password": password,
          "age": age,
          "social": social,
        },
      ));

  static Future<bool?> changePassword({
    required String oldPassword,
    required String newPassword,
  }) =>
      _requestHandler<bool, bool>(_dio.patch(
        '/auth/changePassword',
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        },
      ));
}
