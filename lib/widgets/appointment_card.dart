import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_us/models/appointment.dart';
import 'package:happy_us/utils/constants.dart';

class AppointmentCard extends StatelessWidget {
  static const id = 'AppointmentCard';
  final Appointment appointment;
  static final isSmallScreen = Get.width < SMALL_SCREEN_WIDTH;

  const AppointmentCard({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(isSmallScreen
          ? 'small screen'
          : 'AppointmentCard #${appointment.id}'),
    );
  }
}
