import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:happy_us/screens/home_navigation_screen.dart';
import 'package:happy_us/screens/login_screen.dart';
import 'package:happy_us/screens/register_screen.dart';
import 'package:url_strategy/url_strategy.dart';

class NavigationService {
  NavigationService._();

  static String initialPath = '/';
  static String loginPath = '/login';
  static String registerPath = '/register';

  static void _defineRoutes(FluroRouter router) {
    router.define(
      initialPath,
      handler: _defaultHandler(HomeNavigationScreen()),
    );
    router.define(
      loginPath,
      handler: _defaultHandler(LoginScreen()),
    );
    router.define(
      registerPath,
      handler: _defaultHandler(RegisterScreen()),
    );
  }

  static Handler _defaultHandler(Widget widget) {
    return Handler(handlerFunc: (_, __) => widget);
  }

  static late FluroRouter _router;

  static String get initialRoute => initialPath.replaceAll('/', '');

  static void initialize() {
    setPathUrlStrategy();
    _router = FluroRouter();
    _defineRoutes(_router);
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) =>
      _router.generator(settings);

  static Future<void> push(
    BuildContext context, {
    required String path,
    Map<String, dynamic>? args,
  }) async {
    _router.navigateTo(
      context,
      path,
      routeSettings: RouteSettings(arguments: args),
      transition: TransitionType.cupertino,
    );
  }

  static void pop(BuildContext context) {
    _router.pop(context);
  }
}
