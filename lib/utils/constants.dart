import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color kAccentColor = Colors.amber;
const Color kFocusColor = Colors.pink;

const String FONT_FAMILY = 'ProductSans';

const SMALL_SCREEN_WIDTH = 700;

ThemeData _baseTheme(Brightness brightness) {
  return ThemeData(
    brightness: brightness,
    fontFamily: FONT_FAMILY,
  ).copyWith(
    accentColor: kAccentColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kAccentColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: kFocusColor),
    ),
    toggleableActiveColor: kFocusColor,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: kFocusColor.withOpacity(0.4),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      },
    ),
  );
}

final kLightTheme = _baseTheme(Brightness.light).copyWith(
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 35),
  ),
);
final kDarkTheme = _baseTheme(Brightness.dark).copyWith(
  primaryColor: Color(0xFF17001F),
  scaffoldBackgroundColor: Color(0xFF17001F),
  canvasColor: Color(0xFF17001F),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 35),
  ),
);
