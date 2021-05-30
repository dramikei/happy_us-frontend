import 'package:flutter/material.dart';
import 'package:happy_us/screens/home_navigation_screen.dart';
import 'package:happy_us/utils/route_generator.dart';

void main() => runApp(_MainApp());

class _MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: HomeNavigationScreen.id,
    );
  }
}
