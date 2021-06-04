import 'package:flutter/material.dart';

const Color kAccentColor = Colors.amber;
const Color kFocusColor = Colors.pink;

const String FONT_FAMILY = 'ProductSans';

const SMALL_SCREEN_WIDTH = 700;

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: FONT_FAMILY,
).copyWith(
  accentColor: kAccentColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kAccentColor,
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

final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: FONT_FAMILY,
).copyWith(
  accentColor: kAccentColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kAccentColor,
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
