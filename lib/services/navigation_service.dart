import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:happy_us/screens/home_navigation_screen.dart';
import 'package:happy_us/screens/login_screen.dart';
import 'package:happy_us/screens/register_screen.dart';

class NavigationService {
  NavigationService._();

  static String initialPath = '/';
  static String loginPath = '/login';
  static String registerPath = '/register';

  static void _defineRoutes(FluroRouter router) {
    router.define(loginPath, handler: _loginHandler);
    router.define(initialPath, handler: _homeHandler);
    router.define(registerPath, handler: _registerHandler);
  }

  static final _registerHandler =
      Handler(handlerFunc: (context, params) => RegisterScreen());
  static final _loginHandler = Handler(
    handlerFunc: (context, params) => LoginScreen(),
  );
  static final _homeHandler = Handler(
    handlerFunc: (context, params) => HomeNavigationScreen(),
  );

  static late FluroRouter _router;

  static String get initialRoute => initialPath.replaceAll('/', '');

  static void initialize() {
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
