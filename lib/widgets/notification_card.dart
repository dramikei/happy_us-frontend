import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/repository/notification_repo.dart';
import 'package:happy_us/controllers/notification.getx.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:happy_us/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:happy_us/models/notification.dart' as notif;
import 'package:happy_us/utils/constants.dart';

class NotificationCard extends StatefulWidget {
  static const id = 'NotificationCard';
  final notif.Notification notification;
  static final isSmallScreen = Get.width < SMALL_SCREEN_WIDTH;

  const NotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    bool isSeen = widget.notification.seen;
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      onTap: () async {
        final success = await NotificationRepo.markedSeen(
            notificationId: widget.notification.id);
        if (success == true) {
          Get.find<NotificationController>().updateSeen(widget.notification.id);
          isSeen = false;
          setState(() {});
        }
        NavigationService.push(context,
            path: widget.notification.redirectTo.split('/')[1] == 'post'
                ? NavigationService.postsPath
                : NavigationService.appointmentPath);
      },
      trailing: !isSeen
          ? CircleAvatar(
              backgroundColor: kAccentColor,
              radius: 5,
            )
          : SizedBox.shrink(),
      horizontalTitleGap: 5,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            '${widget.notification.title}',
            style: TextStyle(fontSize: 20),
            maxLines: 2,
          ),
          CustomText(
            '${timeago.format(widget.notification.time)}\n',
            style: TextStyle(fontSize: 12.5),
          ),
        ],
      ),
      subtitle: CustomText(widget.notification.description),
    );
  }
}
