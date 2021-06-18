import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:happy_us/models/base_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Instances {
  static final box = GetStorage();

  static final dio = Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:3000/api',
    ),
  )
    ..interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (request, handler) {
          if (accessToken != null && refreshToken != null) {
            request.headers['Authorization'] = 'Bearer $accessToken';
            request.headers['refresh-token'] = refreshToken;
          }
          handler.next(request);
        },
        onResponse: (response, handler) {
          final data = BaseResponse.fromJson(response.data);
          if (data.tokens.containsKey('accessToken'))
            box.write('accessToken', data.tokens['accessToken']);

          if (data.tokens.containsKey('refreshToken'))
            box.write('refreshToken', data.tokens['refreshToken']);

          handler.next(response);
        },
      ),
      PrettyDioLogger(
        requestHeader: true,
      ),
    ]);

  static String? get accessToken => box.read('accessToken');

  static String? get refreshToken => box.read('refreshToken');

  // to be stored on login
  static String? get userId => box.read('userId');

  // default = user
  static String? get userType {
    final type = box.read('userType');
    return type ?? 'user';
  }

  static void updateThemeMode(ThemeMode themeMode) {
    box.write('theme', themeMode.toString().split('.')[1]);
  }

  static ThemeMode get theme {
    final theme = box.read('theme');
    if (theme == null) return ThemeMode.system;
    return theme == 'light' ? ThemeMode.light : ThemeMode.dark;
  }
}
