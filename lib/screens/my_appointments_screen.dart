import 'package:flutter/material.dart';

class MyAppointmentsScreen extends StatelessWidget {
  static const id = 'MyAppointmentsScreen';
  const MyAppointmentsScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Center(
            child: Text('MyAppointmentsScreen'),
        ),
      ),
    );
  }
}
