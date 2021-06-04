import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  NavigationService.initialize();
  runApp(_MainApp());
}

class _MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? kDarkTheme : kLightTheme;
    return ThemeProvider(
      initTheme: initTheme,
      builder: (context, theme) {
        return OverlaySupport.global(
          child: MaterialApp(
            title: 'Happy Us',
            debugShowCheckedModeBanner: false,
            theme: theme,
            darkTheme: theme,
            onGenerateRoute: NavigationService.generateRoute,
            initialRoute: NavigationService.initialPath,
          ),
        );
      },
    );
  }
}
