import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetX;
import 'package:get_storage/get_storage.dart';
import 'package:happy_us/models/appointment.dart';
import 'package:happy_us/models/notification.dart' as notification;
import 'package:happy_us/models/post.dart';
import 'package:happy_us/models/user.dart';
import 'package:happy_us/models/volunteer.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Globals {
  static final box = GetStorage();

  static final dio = Dio(
    BaseOptions(baseUrl: 'http://10.0.2.2:3000/api'),
  )..interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (request, handler) {
          if (accessToken != null && refreshToken != null) {
            request.headers['Authorization'] = 'Bearer $accessToken';
            request.headers['refresh-token'] = refreshToken;
          }
          handler.next(request);
        },
        onResponse: (response, handler) {
          /// just because the guy developing the backend was too lazy!
          response.data['success'] = response.data['status'] == 'Success';

          response.data['tokens'] ??= {};
          (response.data['tokens'] as Map<String, dynamic>)
              .forEach((key, value) => box.write(key, value));

          handler.next(response);
        },
      ),
      PrettyDioLogger(requestHeader: true, requestBody: true),
    ]);

  static String? get accessToken => box.read('accessToken');

  static String? get refreshToken => box.read('refreshToken');

  static void updateThemeMode(ThemeMode themeMode) {
    box.write('theme', themeMode.toString().split('.')[1]);
  }

  static ThemeMode get theme {
    final theme = box.read('theme');
    if (theme == null) return ThemeMode.system;
    return theme == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  static Map<String, Function(Map<String, dynamic>)> _fromJsonReferences = {
    '/notification': (e) => notification.Notification.fromJson(e),
    '/appointment': (e) => Appointment.fromJson(e),
    '/volunteer': (e) => Volunteer.fromJson(e),
    '/post': (e) => Post.fromJson(e),
    '/post/user': (e) => Post.fromJson(e),
    '/user': (e) => User.fromJson(e),
  };

  static Future<ReturnType?> requestHandler<DataType, ReturnType>(
    Future<Response> response,
  ) async {
    try {
      final res = await response;

      if (!res.data['success']) {
        GetX.Get.snackbar(
          'An error occurred',
          res.data['message'],
          backgroundColor: Colors.red,
          animationDuration: const Duration(milliseconds: 500),
        );
        return null;
      }

      if (ReturnType == bool) return res.data['success'];

      late final DataType? _data;
      final List<DataType> _list = [];

      final isList = res.data['data'] is List;

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        final endpoint = res.realUri.path.replaceFirst('/api', '');

        final _fromJson = _fromJsonReferences[endpoint]!;

        if (isList)
          (res.data['data'] as List).forEach((e) => _list.add(_fromJson(e)));
        else
          _data = _fromJson(res.data['data']);

        return (isList ? _list : _data) as ReturnType;
      }
    } catch (e) {
      print(e);
      GetX.Get.snackbar(
        'An error occurred',
        'Something went wrong',
        backgroundColor: Colors.red,
        animationDuration: const Duration(milliseconds: 500),
      );
      return null;
    }
  }
}
