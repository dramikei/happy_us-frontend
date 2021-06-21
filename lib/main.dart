import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:happy_us/controllers/appointment.getx.dart';
import 'package:happy_us/controllers/notification.getx.dart';
import 'package:happy_us/controllers/post.getx.dart';
import 'package:happy_us/controllers/user.getx.dart';
import 'package:happy_us/controllers/volunteer.getx.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  await GetStorage.init();
  NavigationService.initialize();
  runApp(_MainApp());
}

class _MainApp extends StatefulWidget {
  @override
  __MainAppState createState() => __MainAppState();
}

class __MainAppState extends State<_MainApp> {
  late final StreamSubscription _connectivitySubscription;

  @override
  void initState() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        NavigationService.push(
          context,
          path: NavigationService.connectionLostPath,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        title: 'Happy Us',
        initialBinding: BindingsBuilder(
          () => {
            Get.put(UserController(), permanent: true),
            Get.put(VolunteerController(), permanent: true),
            Get.put(PostController(), permanent: true),
            Get.put(NotificationController(), permanent: true),
            Get.put(AppointmentController(), permanent: true)
          },
        ),
        debugShowCheckedModeBanner: false,
        theme: kLightTheme,
        darkTheme: kDarkTheme,
        themeMode: Globals.theme,
        onGenerateRoute: NavigationService.generateRoute,
        initialRoute: NavigationService.initialPath,
      ),
    );
  }
}
