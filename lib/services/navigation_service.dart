import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:happy_us/screens/about_screen.dart';
import 'package:happy_us/screens/connection_lost_screen.dart';
import 'package:happy_us/screens/home_navigation_screen.dart';
import 'package:happy_us/screens/login_screen.dart';
import 'package:happy_us/screens/my_appointments_screen.dart';
import 'package:happy_us/screens/my_posts_screen.dart';
import 'package:happy_us/screens/notifications_screen.dart';
import 'package:happy_us/screens/register_screen.dart';
import 'package:happy_us/screens/splash_screen.dart';
import 'package:happy_us/screens/tnc.dart';
import 'package:happy_us/screens/create_post_screen.dart';
import 'package:url_strategy/url_strategy.dart';

class NavigationService {
  NavigationService._();

  static String initialPath = '/';
  static String homePath = '/home';
  static String loginPath = '/login';
  static String registerPath = '/register';
  static String tncPath = '/tnc';
  static String notificationPath = '/notifications';
  static String appointmentPath = '/appointments';
  static String postsPath = '/posts';
  static String aboutPath = '/about';
  static String createPostPath = '/create';
  static String connectionLostPath = '/connection-lost';

  static void _defineRoutes(FluroRouter router) {
    router.define(
      initialPath,
      handler: _defaultHandler(SplashScreen()),
    );
    router.define(createPostPath, handler: Handler(
      handlerFunc: (context, params) {
        final args = context!.settings!.arguments as Map;
        return CreatePostScreen(
          refreshPage: args['refreshPage'],
        );
      },
    ));
    router.define(
      notificationPath,
      handler: _defaultHandler(NotificationScreen()),
    );
    router.define(
      appointmentPath,
      handler: _defaultHandler(MyAppointmentsScreen()),
    );
    router.define(
      postsPath,
      handler: _defaultHandler(MyPostsScreen()),
    );
    router.define(
      aboutPath,
      handler: _defaultHandler(AboutScreen()),
    );
    router.define(
      homePath,
      handler: _defaultHandler(HomeNavigationScreen()),
    );
    router.define(
      connectionLostPath,
      handler: _defaultHandler(ConnectionLostScreen()),
    );
    router.define(
      loginPath,
      handler: _defaultHandler(LoginScreen()),
    );
    router.define(
      registerPath,
      handler: _defaultHandler(RegisterScreen()),
    );
    router.define(
      tncPath,
      handler: _defaultHandler(Tnc()),
    );
  }

  static Handler _defaultHandler(Widget widget) {
    return Handler(handlerFunc: (_, __) => widget);
  }

  static late FluroRouter _router;

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
