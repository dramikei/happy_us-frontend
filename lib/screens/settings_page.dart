import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const id = 'SettingsPage';

  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('SettingsPage'),
        ),
      ),
    );
  }
}
