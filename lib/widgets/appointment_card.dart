import 'package:flutter/material.dart';
import 'package:happy_us/widgets/custom_text.dart';
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        onTap: null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: appointment.status == 'pending'
            ? Colors.purple
            : appointment.status == 'rejected'
                ? kFocusColor
                : Colors.green,
        horizontalTitleGap: 5,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Status:  ${appointment.status.capitalizeFirst}\n',
              style: TextStyle(fontSize: 20, color: Colors.white),
              maxLines: 2,
            ),
            CustomText(
              'Scheduled for: ${appointment.time.toLocal().toString().substring(0, 16)}\n',
              style: TextStyle(fontSize: 12.5, color: Colors.white),
            ),
          ],
        ),
        subtitle: CustomText(
          "Message: " + (appointment.message ?? "Waiting for confirmation"),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
