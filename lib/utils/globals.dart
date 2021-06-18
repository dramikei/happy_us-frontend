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
      print(e);
      return null;
    }
  }

  static Future<List<T>?> listRequestHandler<T>(
    Future<Response> response,
  ) async {
    try {
      final res = await response;

      final _list = <T>[];

      if (res.statusCode! >= 200 && res.statusCode! < 300) {
        final endpoint = res.realUri.path.substring(4); // removing /api

        if (!res.data['success']) return null;

        switch (endpoint) {
          case '/notification':
            (res.data['data'] as List).forEach(
                (e) => _list.add(notification.Notification.fromJson(e) as T));
            break;
          case '/appointment':
            (res.data['data'] as List)
                .forEach((e) => _list.add(Appointment.fromJson(e) as T));
            break;
          case '/post':
          case '/post/user':
            (res.data['data'] as List)
                .forEach((e) => _list.add(Post.fromJson(e) as T));
            break;
          case '/volunteer':
            (res.data['data'] as List)
                .forEach((e) => _list.add(Volunteer.fromJson(e) as T));
            break;
        }
        return _list;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
