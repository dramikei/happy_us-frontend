import 'package:flutter/material.dart';
import 'package:happy_us/widgets/theme_switcher_icon_button.dart';

class SettingsPage extends StatelessWidget {
  static const id = 'SettingsPage';

  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            const ThemeSwitcherIconButton(),
          ],
        ),
        body: Center(
          child: Text('SettingsPage'),
        ),
      ),
    );
  }
}
