import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/controllers/appointment.getx.dart';
import 'package:happy_us/repository/appointment_repo.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:happy_us/models/appointment.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/custom_text_field.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AppointmentCard extends StatefulWidget {
  static const id = 'AppointmentCard';
  final Appointment appointment;
  static final isSmallScreen = Get.width < SMALL_SCREEN_WIDTH;

  const AppointmentCard({
    Key? key,
    required this.appointment,
  }) : super(key: key);

  @override
  _AppointmentCardState createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  String? _message;

  Future<void> _updateStatus(String status) async {
    if (_message == null || _message!.length <= 1)
      return AlertsService.error(
        'The message should range between 1 and 30 in length',
      );

    final res = await AppointmentRepo.updateStatus(
      appointmentId: widget.appointment.id,
      status: status,
      message: _message!,
    );

    if (res != null) {
      Navigator.pop(context);
      Get.find<AppointmentController>().updateStatus(
        appointmentId: widget.appointment.id,
        message: _message!,
        status: status,
      );
      setState(() {});
      AlertsService.success('Status updated!');
    }
  }

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
        tileColor: widget.appointment.status == 'pending'
            ? Colors.purple
            : widget.appointment.status == 'Rejected'
                ? kFocusColor
                : Colors.green,
        horizontalTitleGap: 5,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Status:  ${widget.appointment.status.capitalizeFirst}\n',
              style: TextStyle(fontSize: 20, color: Colors.white),
              maxLines: 2,
            ),
            CustomText(
              'Scheduled for: ${widget.appointment.time.toLocal().toString().substring(0, 16)}\n',
              style: TextStyle(fontSize: 12.5, color: Colors.white),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "Message: " +
                  (widget.appointment.message ?? "Waiting for confirmation") +
                  "\n",
              style: TextStyle(color: Colors.white),
            ),
            CustomText(
              '${widget.appointment.userSocial['platform'].toString().capitalize} ID: ${widget.appointment.userSocial['id']}',
              style: TextStyle(color: Colors.white),
            ),
            if (!Globals.isUser && widget.appointment.message == null)
              ElevatedButton(
                child: CustomText(
                  "Update Appointment",
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(primary: kAccentColor),
                onPressed: () => Alert(
                  context: context,
                  title: 'Update Appointment',
                  style: AlertStyle(
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                    titleStyle: TextStyle(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                    // animationType: AnimationType.fromTop
                  ),
                  content: Column(
                    children: [
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Message',
                        autofocus: true,
                        onChanged: (v) => _message = v,
                        maxLines: 1,
                        maxLength: 30,
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ArgonButton(
                            child: Text(
                              'Reject',
                              style: TextStyle(color: Colors.white),
                            ),
                            borderRadius: 10,
                            height: 39,
                            width: 90,
                            onTap: (startLoading, stopLoading, btnState) async {
                              if (btnState == ButtonState.Idle) {
                                startLoading();
                                await _updateStatus('Rejected');
                                stopLoading();
                              }
                            },
                            loader: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                            color: Colors.red,
                          ),
                          ArgonButton(
                            child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.white),
                            ),
                            borderRadius: 10,
                            height: 39,
                            width: 90,
                            loader: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                            onTap: (startLoading, stopLoading, btnState) async {
                              if (btnState == ButtonState.Idle) {
                                startLoading();
                                await _updateStatus('Accepted');
                                stopLoading();
                              }
                            },
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                  buttons: [],
                ).show(),
              )
          ],
        ),
      ),
    );
  }
}
