import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static const id = 'NotificationScreen';
  const NotificationScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Center(
            child: Text('NotificationScreen'),
        ),
      ),
    );
  }
}
