import 'package:flutter/material.dart';
import 'package:happy_us/models/base_user.dart';
import 'package:happy_us/repository/user_repo.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:get/get.dart';
import 'package:happy_us/controllers/user.getx.dart';
import 'package:happy_us/controllers/volunteer.getx.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:happy_us/widgets/custom_text_field.dart';

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
  bool _editingUsername = false;
  bool _editingSocial = false;
  String? _username;
  Map<String, String> _social = {};

  @override
  Widget build(BuildContext context) {
    final user = Globals.isUser
        ? Get.find<UserController>().user.value
        : Get.find<VolunteerController>().volunteer.value;
    _age ??= user.age;
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              if (Globals.isLoggedIn) ...[
                _profile(user),
                const Divider(
                  color: kFocusColor,
                  thickness: 0.75,
                  indent: 100,
                  endIndent: 100,
                  height: 20,
                ),
                _settingsTile(
                  title: "My Posts",
                  onTap: () {
                    NavigationService.push(context,
                        path: NavigationService.postsPath);
                  },
                ),
                _settingsTile(
                  title: "My Appointments",
                  onTap: () {
                    NavigationService.push(context,
                        path: NavigationService.appointmentPath);
                  },
                ),
                _settingsTile(
                  title: "Notifications",
                  onTap: () {
                    NavigationService.push(context,
                        path: NavigationService.notificationPath);
                  },
                ),
              ],
              _settingsTile(
                title: "About Us",
                onTap: () {
                  NavigationService.push(context,
                      path: NavigationService.aboutPath);
                },
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

  Widget _profile(BaseUser user) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ListTile(
          title: CustomText("Username"),
          subtitle: _editingUsername
              ? Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: CustomTextField(
                    autofocus: true,
                    onChanged: (v) => _username = v,
                  ),
                )
              : CustomText(user.username),
          trailing: Globals.isUser
              ? IconButton(
                  icon: Icon(_editingUsername ? Icons.check : Icons.edit),
                  onPressed: () async {
                    _editingUsername = !_editingUsername;

                    if (!_editingUsername) {
                      if (_username == null || _username!.isEmpty) {
                        return AlertsService.error('Username cannot be empty');
                      }
                      final newUser =
                          await UserRepo.updateUser(username: _username);
                      if (newUser != null) {
                        Get.find<UserController>().updateUser(newUser);
                        AlertsService.success('Username updated!');
                      }
                    }
                    setState(() {});
                  },
                  iconSize: 20,
                )
              : null,
        ),
        const SizedBox(height: 10),
        ListTile(
          title: CustomText("Age: ${_age.toString()}"),
          subtitle: Slider(
            min: 18,
            max: 24,
            inactiveColor: kAccentColor,
            activeColor: kFocusColor,
            onChanged: (double value) {
              if (Globals.isUser)
                setState(() {
                  _age = value.toInt();
                });
            },
            value: _age?.toDouble() ?? 18,
          ),
          trailing: _age != user.age
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () async {
                    final newUser = await UserRepo.updateUser(age: _age);
                    if (newUser != null) {
                      Get.find<UserController>().updateUser(newUser);
                      setState(() {});
                      AlertsService.success('Age updated!');
                    }
                  },
                )
              : null,
        ),
        const SizedBox(height: 10),
        ...user.social.keys.map(
          (socialId) => ListTile(
            title: CustomText('${socialId.capitalize!} ID'),
            subtitle: _editingSocial
                ? Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomTextField(
                      autofocus: true,
                      onChanged: (v) => _social[socialId] = v,
                    ),
                  )
                : CustomText(user.social[socialId]),
            trailing: Globals.isUser
                ? IconButton(
                    icon: Icon(_editingSocial ? Icons.check : Icons.edit),
                    onPressed: () async {
                      _editingSocial = !_editingSocial;

                      if (!_editingSocial) {
                        if (_social[socialId] == null ||
                            _social[socialId]!.isEmpty) {
                          return AlertsService.error(
                              'Invalid social ID entered.');
                        }
                        final newUser =
                            await UserRepo.updateUser(social: _social);
                        if (newUser != null) {
                          Get.find<UserController>().updateUser(newUser);
                          AlertsService.success('Socials updated!');
                        }
                      }
                      setState(() {});
                    },
                    iconSize: 20,
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _settingsTile({
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: CustomText(
        title,
        style: TextStyle(fontSize: 20),
      ),
      onTap: onTap,
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
