import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';

class VolunteerCard extends StatelessWidget {
  static const id = 'VolunteerCard';

  const VolunteerCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyContainer(
      elevation: 0,
      margin: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Volunteer 1 details"),
          TextButton(
            child: Text("Book Appointment"),
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
        ],
      ),
    );
  }
}
