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
        body: ListView.separated(
          separatorBuilder: (c, i) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            return Placeholder(fallbackHeight: 100);
          },
          // about us page button here
          itemCount: 100,
        ),
      ),
    );
  }
}
