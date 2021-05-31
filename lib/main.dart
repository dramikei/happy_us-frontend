import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/screens/home_navigation_screen.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/utils/route_generator.dart';

void main() => runApp(_MainApp());

class _MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isPlatformDark =
        WidgetsBinding.instance!.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? kDarkTheme : kLightTheme;
    return ThemeProvider(
      initTheme: initTheme,
      builder: (context, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: theme,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: HomeNavigationScreen.id,
        );
      },
    );
  }
}
