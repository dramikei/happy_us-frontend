import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_us/controllers/user.getx.dart';
import 'package:happy_us/controllers/volunteer.getx.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/globals.dart';

class DashboardPage extends StatelessWidget {
  static const id = 'DashboardPage';

  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              if (Globals.isLoggedIn) ...[
                _settingsTile(
                  title: "My Profile",
                  onTap: () {},
                ),
                _settingsTile(
                  title: "Notifications",
                  onTap: () {},
                ),
                _settingsTile(
                  title: "My Posts",
                  onTap: () {},
                ),
                _settingsTile(
                  title: "My Appointments",
                  onTap: () {},
                ),
              ],
              _settingsTile(
                title: "About Us",
                onTap: () {},
              ),
              _settingsTile(
                title: "Change Theme",
                onTap: () {
                  if (Get.theme.brightness == Brightness.dark) {
                    Get.changeThemeMode(ThemeMode.light);
                    Globals.updateThemeMode(ThemeMode.light);
                  } else {
                    Get.changeThemeMode(ThemeMode.dark);
                    Globals.updateThemeMode(ThemeMode.dark);
                  }
                },
              ),
              _settingsTile(
                title: Globals.isLoggedIn ? "Logout" : "Login",
                onTap: () async {
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingsTile({
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      onTap: onTap,
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
