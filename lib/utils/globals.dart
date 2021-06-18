import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetX;
import 'package:get_storage/get_storage.dart';
import 'package:happy_us/models/appointment.dart';
import 'package:happy_us/models/base_response.dart';
import 'package:happy_us/models/notification.dart' as notification;
import 'package:happy_us/models/post.dart';
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

          final data = BaseResponse.fromJson(response.data);
          if (data.tokens.containsKey('accessToken'))
            box.write('accessToken', data.tokens['accessToken']);

          if (data.tokens.containsKey('refreshToken'))
            box.write('refreshToken', data.tokens['refreshToken']);

          handler.next(response);
        },
      ),
      PrettyDioLogger(requestHeader: true),
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

  static Future<T?> requestHandler<T>(Future<Response> response) async {
    try {
      final res = await response;
      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        final response = BaseResponse<T>.fromJson(res.data);
        if (response.success)
          return response.data;
        else {
          GetX.Get.snackbar('An error occurred!', response.message);
          return null;
        }
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<T>?> listRequestHandler<T>(
    Future<Response> response,
  ) async {
    try {
      final res = await response;

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        final returnType = res.realUri.path;

        switch (returnType) {
          case '/notification':
            res.data = (res.data as List)
                .map((e) => notification.Notification.fromJson(e))
                .toList();
            break;
          case '/appointment':
            res.data =
                (res.data as List).map((e) => Appointment.fromJson(e)).toList();
            break;
          case '/post':
          case '/post/user':
            res.data = (res.data as List).map((e) => Post.fromJson(e)).toList();
            break;
          case '/volunteer':
            res.data =
                (res.data as List).map((e) => Volunteer.fromJson(e)).toList();
            break;
        }
        return res.data;
      }
    } catch (e) {
      return null;
    }
  }
}
