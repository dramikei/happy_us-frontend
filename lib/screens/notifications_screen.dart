import 'package:flutter/material.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/notification_card.dart';
import 'package:happy_us/models/notification.dart' as notif;

class NotificationScreen extends StatelessWidget {
  static const id = 'NotificationScreen';

  const NotificationScreen({
    Key? key,
  }) : super(key: key);
  static final notifications = [
    notif.Notification.fromJson({
      "userId": "lol",
      "_id": "q",
      "redirectTo": "",
      "title": "title",
      "description": "desc",
      "seen": true,
      "time": "2021-06-24 00:00:00.000",
    })
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: CustomText('My Notifications')),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: ListView.builder(
            padding: const EdgeInsets.all(30),
            physics: BouncingScrollPhysics(),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return NotificationCard(
                notification: notifications[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
