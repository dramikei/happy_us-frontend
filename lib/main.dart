import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:happy_us/controllers/appointment.getx.dart';
import 'package:happy_us/controllers/notification.getx.dart';
import 'package:happy_us/controllers/post.getx.dart';
import 'package:happy_us/controllers/user.getx.dart';
import 'package:happy_us/controllers/volunteer.getx.dart';
import 'package:happy_us/repository/user_repo.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_notifications_handler/firebase_notifications_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runZonedGuarded<Future<void>>(() async {
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      originalOnError!(errorDetails);
    };
    await GetStorage.init();
    NavigationService.initialize();
    runApp(_MainApp());
  }, FirebaseCrashlytics.instance.recordError);
}

class _MainApp extends StatefulWidget {
  @override
  __MainAppState createState() => __MainAppState();
}

class __MainAppState extends State<_MainApp> {
  late final StreamSubscription _connectivitySubscription;
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void initState() {
    () async {
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
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
      child: FirebaseNotificationsHandler(
        vapidKey:
            "BFUjMjxmf4Y20YHHpDiiDAmEH0fq28LxzqGA1aouoJ7JKMRzMKwme-dxzdXc2L2WjtGleJoLSgBRv1PUEbe6ssQ",
        onTap: (navigatorState, appState, _) {
          if (appState == AppState.open) {
            final context = navigatorState.currentContext!;

            if (Globals.isLoggedIn)
              NavigationService.push(context, path: '/appointments');
            else
              NavigationService.push(context, path: '/login');
          }
        },
        onFCMTokenInitialize: (_, token) => Globals.fcmToken = token,
        onFCMTokenUpdate: (_, token) {
          Globals.fcmToken = token;
          UserRepo.updateUser(fcm: token);
        },
        child: GetMaterialApp(
          title: 'Happy Us',
          navigatorObservers: <NavigatorObserver>[observer],
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
          navigatorKey: FirebaseNotificationsHandler.navigatorKey,
          themeMode: Globals.theme,
          onGenerateRoute: NavigationService.generateRoute,
          initialRoute: NavigationService.initialPath,
        ),
      ),
    );
  }
}
