import 'package:flutter/material.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  NavigationService.initialize();
  runApp(_MainApp());
}

class _MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final isPlatformDark =
    //     WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
    return OverlaySupport.global(
      child: MaterialApp(
        title: 'Happy Us',
        debugShowCheckedModeBanner: false,
        theme: kLightTheme,
        darkTheme: kDarkTheme,
        onGenerateRoute: NavigationService.generateRoute,
        initialRoute: NavigationService.initialPath,
      ),
    );
  }
}
