import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_us/repository/notification_repo.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:happy_us/controllers/notification.getx.dart';
import 'package:happy_us/widgets/no_data.dart';
import 'package:happy_us/widgets/notification_card.dart';
import 'package:happy_us/models/notification.dart' as notification;

class NotificationScreen extends StatefulWidget {
  static const id = 'NotificationScreen';

  const NotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<List<notification.Notification>?> _notifications;

  @override
  void initState() {
    _notifications = NotificationRepo.getUserNotifications();
    super.initState();
  }

  Future<void> refreshPage() async {
    _notifications = NotificationRepo.getUserNotifications();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.find<NotificationController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? kFocusColor
              : Colors.transparent,
          elevation: 0,
          title: CustomText('My Notifications'),
        ),
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: FutureBuilder<List<notification.Notification>?>(
            future: _notifications,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                notificationController.insertNotifications(snapshot.data!);
                return snapshot.data!.length > 0
                    ? ListView.builder(
                        padding: const EdgeInsets.all(20),
                        physics: BouncingScrollPhysics(),
                        itemCount: notificationController.notifications.length,
                        itemBuilder: (context, index) {
                          return NotificationCard(
                            notification:
                                notificationController.notifications[index],
                          );
                        },
                      )
                    : NoData();
              } else
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kFocusColor),
                  ),
                );
            },
          ),
        ),
      ),
    );
  }
}
