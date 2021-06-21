import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/models/volunteer.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/utils/globals.dart';

class VolunteerCard extends StatelessWidget {
  static const id = 'VolunteerCard';

  final Volunteer volunteer;

  const VolunteerCard(
    this.volunteer, {
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
                child: Text(
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
                          Expanded(child: Text(hobby)),
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
                    Text(
                      "Volunteer ${volunteer.id}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                      ),
                    ),
                    ElevatedButton(
                      child: Text("Book Appointment"),
                      style: ElevatedButton.styleFrom(primary: kFocusColor),
                      onPressed: () async {
                        if (Globals.isLoggedIn) {
                          final _date = await _showDatePicker(context);
                          print(_date);
                        } else {
                          // go to login
                          NavigationService.push(
                            context,
                            path: NavigationService.loginPath,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<DateTime?> _showDatePicker(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            brightness: Theme.of(context).brightness,
            fontFamily: FONT_FAMILY,
          ).copyWith(
            primaryColor: kFocusColor,
            accentColor: kFocusColor,
            colorScheme: Theme.of(context).brightness == Brightness.light
                ? ColorScheme.light(primary: kFocusColor)
                : ColorScheme.dark(primary: kFocusColor),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
