import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:happy_us/utils/constants.dart';

class ThemeSwitcherIconButton extends StatelessWidget {
  static const id = 'ThemeSwitcherIconButton';

  const ThemeSwitcherIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ThemeProvider.of(context)!.brightness == Brightness.dark;
    return ThemeSwitcher(
      builder: (context) {
        return IconButton(
          icon: Icon(Icons.wb_sunny_outlined),
          color: isDarkMode ? Colors.white : Colors.black,
          onPressed: () {
            ThemeSwitcher.of(context)!
                .changeTheme(theme: isDarkMode ? kLightTheme : kDarkTheme);
          },
        );
      },
    );
  }
}
