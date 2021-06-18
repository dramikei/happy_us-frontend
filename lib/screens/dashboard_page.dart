import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            _settingsTile(
              title: "My Profile",
              onTap: () {},
            ),
            _settingsTile(
              title: "Edit Profile",
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
              title: "Logout",
              onTap: () async {},
            ),
          ],
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
