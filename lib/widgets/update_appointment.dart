import 'package:flutter/material.dart';
import 'package:happy_us/widgets/custom_text.dart';

class UpdateAppointment extends StatelessWidget {
  static const id = 'UpdateAppointment';
  const UpdateAppointment({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Center(
            child: CustomText('UpdateAppointment'),
        ),
      ),
    );
  }
}
