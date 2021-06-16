import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/utils/instances.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  await GetStorage.init();
  NavigationService.initialize();
  runApp(_MainApp());
}

class _MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        title: 'Happy Us',
        debugShowCheckedModeBanner: false,
        theme: kLightTheme,
        darkTheme: kDarkTheme,
        themeMode: Instances.theme,
        onGenerateRoute: NavigationService.generateRoute,
        initialRoute: NavigationService.initialPath,
      ),
    );
  }
}
