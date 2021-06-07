import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static const id = 'DashboardPage';

  const DashboardPage({
    Key? key,
  }) : super(key: key);

  // login/profile button,
  // about us page,
  // my appointments,
  // edit profile, etc.

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
              title: "My Appointments",
              onTap: () {},
            ),
            _settingsTile(
              title: "About Us",
              onTap: () {},
            ),
            _settingsTile(
              title: "Logout",
              onTap: () {},
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
