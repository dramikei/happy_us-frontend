import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:happy_us/controllers/user.getx.dart';
import 'package:happy_us/models/volunteer.dart';
import 'package:happy_us/repository/appointment_repo.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:happy_us/widgets/custom_text.dart';

class VolunteerCard extends StatelessWidget {
  static const id = 'VolunteerCard';

  final Volunteer volunteer;
  final int index;

  const VolunteerCard(
    this.volunteer,
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyContainer(
      margin: 0,
      borderRadius: 10,
      padding: 0,
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 10,
      shadowColor: kFocusColor,
      alignment: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Material(
              color: kFocusColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomText(
                  volunteer.aboutMe,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ...List.generate(
                  volunteer.hobbies.length,
                  (index) {
                    final hobby = volunteer.hobbies[index];
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 6.5,
                            backgroundColor: Theme.of(context).accentColor,
                            child: SizedBox.expand(),
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: CustomText(hobby)),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      "Volunteer ${index + 1}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                    ),
                    Globals.userType != 'volunteer'
                        ? ElevatedButton(
                            child: CustomText("Book Appointment"),
                            style:
                                ElevatedButton.styleFrom(primary: kFocusColor),
                            onPressed: () => Globals.isLoggedIn
                                ? _showTimeDatePicker(context)
                                : NavigationService.push(context,
                                    path: NavigationService.loginPath),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _bookAppointment(BuildContext context, DateTime? _date) async {
    if (Globals.isLoggedIn) {
      if (_date != null) {
        await AppointmentRepo.createAppointment(
          volunteerId: volunteer.id,
          userSocial: Get.find<UserController>().user.value.social,
          time: _date,
        );
        AlertsService.success("Appointment requested successfully!!");
      }
    } else {
      NavigationService.push(
        context,
        path: NavigationService.loginPath,
      );
    }
  }

  Future _showTimeDatePicker(BuildContext context) async {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now().add(
        Duration(hours: 1),
      ),
      maxTime: DateTime.now().add(
        Duration(days: 7),
      ),
      theme: DatePickerTheme(
        headerColor: kFocusColor,
        backgroundColor: Theme.of(context).primaryColor,
        itemStyle: TextStyle(
            color: Colors.white, fontFamily: FONT_FAMILY, fontSize: 18),
        doneStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: FONT_FAMILY,
            fontSize: 20),
        cancelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: FONT_FAMILY,
            fontSize: 20),
      ),
      onConfirm: (date) {
        _bookAppointment(context, date);
      },
    );
  }
}
