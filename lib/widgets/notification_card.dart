import 'package:flutter/material.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:happy_us/models/notification.dart' as notif;
import 'package:happy_us/utils/constants.dart';

class NotificationCard extends StatelessWidget {
  static const id = 'NotificationCard';
  final notif.Notification notification;
  static final isSmallScreen = Get.width < SMALL_SCREEN_WIDTH;

  const NotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
          isSmallScreen ? 'small screen' : 'notif-card #${notification.id}'),
    );
  }
}
