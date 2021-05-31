import 'package:flutter/material.dart';
import 'package:happy_us/screens/home_navigation_screen.dart';
import 'package:happy_us/widgets/custom_text.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    print("PUSHED ${settings.name} WITH ARGS: ${settings.arguments}");
    switch (settings.name) {
      case HomeNavigationScreen.id:
        return MaterialPageRoute(builder: (context) => HomeNavigationScreen());
      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? name) {
    return MaterialPageRoute(builder: (_) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: CustomText('Error'),
          ),
          body: Center(
            child: CustomText('ROUTE \n\n$name\n\nNOT FOUND'),
          ),
        ),
      );
    });
  }
}
