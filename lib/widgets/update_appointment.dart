import 'package:flutter/material.dart';

class UpdateAppointment extends StatelessWidget {
  static const id = 'UpdateAppointment';
  const UpdateAppointment({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Center(
            child: Text('UpdateAppointment'),
        ),
      ),
    );
  }
}
