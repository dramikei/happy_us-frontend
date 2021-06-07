import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/models/volunteer.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';

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
      alignment: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            volunteer.aboutMe,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              volunteer.hobbies.length,
              (index) {
                final hobby = volunteer.hobbies[index];
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 7.5,
                        backgroundColor: Colors.black,
                        child: SizedBox.expand(),
                      ),
                      const SizedBox(width: 10),
                      Expanded(child: Text(hobby)),
                    ],
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              child: Text("Book Appointment"),
              style: ElevatedButton.styleFrom(primary: kFocusColor),
              onPressed: () async {
                // logged in
                if (false) {
                  final _date = await showDatePicker(
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
                            colorScheme:
                                Theme.of(context).brightness == Brightness.light
                                    ? ColorScheme.light(primary: kFocusColor)
                                    : ColorScheme.dark(primary: kFocusColor),
                            buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary,
                            ),
                          ),
                          child: child!,
                        );
                      });

                  //
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
          ),
        ],
      ),
    );
  }
}
