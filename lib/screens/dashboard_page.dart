import 'package:flutter/material.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/change_password_button.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:happy_us/controllers/user.getx.dart';
import 'package:happy_us/controllers/volunteer.getx.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:happy_us/widgets/profile.dart';
import 'package:happy_us/widgets/settings_tile.dart';

class DashboardPage extends StatefulWidget {
  static const id = 'DashboardPage';

  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int? _age;

  @override
  Widget build(BuildContext context) {
    final user = Globals.isUser
        ? Get.find<UserController>().user.value
        : Get.find<VolunteerController>().volunteer.value;
    _age ??= user.age;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (Get.theme.brightness == Brightness.dark) {
              Get.changeThemeMode(ThemeMode.light);
              Globals.updateThemeMode(ThemeMode.light);
            } else {
              Get.changeThemeMode(ThemeMode.dark);
              Globals.updateThemeMode(ThemeMode.dark);
            }
            setState(() {});
          },
          tooltip: 'Toggle theme',
          child: Icon(
              Get.theme.brightness == Brightness.dark
                  ? Icons.light_mode_sharp
                  : Icons.dark_mode_sharp,
              size: 21,
              color: Colors.black),
        ),
        body: Obx(
          () => ListView(
            padding: const EdgeInsets.only(bottom: 20),
            physics: const BouncingScrollPhysics(),
            children: [
              if (Globals.isLoggedIn) ...[
                Profile(user: user),
                ChangePasswordButton(),
                const Divider(
                  color: kFocusColor,
                  thickness: 0.75,
                  indent: 100,
                  endIndent: 100,
                  height: 20,
                ),
                if (Globals.isUser)
                  SettingsTile(
                    title: "My Posts",
                    onTap: () {
                      NavigationService.push(context,
                          path: NavigationService.postsPath);
                    },
                  ),
                SettingsTile(
                  title: "My Appointments",
                  onTap: () {
                    NavigationService.push(context,
                        path: NavigationService.appointmentPath);
                  },
                ),
                SettingsTile(
                  title: "Notifications",
                  onTap: () {
                    NavigationService.push(context,
                        path: NavigationService.notificationPath);
                  },
                ),
              ],
              if (!Globals.isLoggedIn)
                Material(
                  color: kAccentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: CustomText(
                      "Login for a better now!",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                      maxLines: 3,
                    ),
                  ),
                ),
              SettingsTile(
                title: "About Us",
                onTap: () {
                  NavigationService.push(context,
                      path: NavigationService.aboutPath);
                },
              ),
              SettingsTile(
                  title: 'View Terms and Conditions',
                  onTap: () {
                    NavigationService.push(
                      context,
                      path: NavigationService.tncPath,
                    );
                  }),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 100),
                child: ElevatedButton(
                  onPressed: () async {
                    if (Globals.isLoggedIn) {
                      final type = Globals.userType;
                      if (type == 'user')
                        Get.find<UserController>().logout();
                      else
                        Get.find<VolunteerController>().logout();
                      Globals.removeCredentials();
                      AlertsService.success('Logged out!');
                    } else
                      NavigationService.push(
                        context,
                        path: NavigationService.loginPath,
                      );
                  },
                  child: Text(Globals.isLoggedIn ? "Logout" : "Login Now"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
