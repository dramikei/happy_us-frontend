import 'package:flutter/material.dart';
import 'package:happy_us/models/base_user.dart';
import 'package:happy_us/repository/auth_repo.dart';
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
import 'package:rflutter_alert/rflutter_alert.dart';

class DashboardPage extends StatefulWidget {
  static const id = 'DashboardPage';

  const DashboardPage({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late int _age;
  bool _editingUsername = false;
  bool _editingSocial = false;
  String? _username;
  Map<String, String> _social = {};

  String? _oldPassword;
  String? _newPassword;
  String? _confirmNewPassword;

  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty)
      return "password cannot be empty";
    else if (password.length < 6)
      return "password length cannot be less than 6";
  }

  @override
  Widget build(BuildContext context) {
    final user = Globals.isUser
        ? Get.find<UserController>().user.value
        : Get.find<VolunteerController>().volunteer.value;
    _age = user.age;
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              if (Globals.isLoggedIn) ...[
                _profile(user),
                _changePasswordButton(),
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

  Widget _changePasswordButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 100),
      child: ElevatedButton(
        onPressed: () => Alert(
          context: context,
          title: 'Change Password',
          style: AlertStyle(
            backgroundColor: Theme.of(context).brightness == Brightness.light
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
                hintText: 'Old password',
                autofocus: true,
                onChanged: (v) => _oldPassword = v,
                maxLines: 1,
                isPasswordField: true,
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hintText: 'New password',
                onChanged: (v) => _newPassword = v,
                maxLines: 1,
                isPasswordField: true,
              ),
              const SizedBox(height: 5),
              CustomTextField(
                hintText: 'Confirm password',
                onChanged: (v) => _confirmNewPassword = v,
                maxLines: 1,
                isPasswordField: true,
              ),
            ],
          ),
          buttons: [
            DialogButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
              color: kFocusColor,
            ),
            DialogButton(
              child: Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                final _old = _validatePassword(_oldPassword);
                if (_old != null) return AlertsService.error('Old $_old');
                final _new = _validatePassword(_newPassword);
                if (_new != null) return AlertsService.error('New $_new');

                if (_newPassword != _confirmNewPassword)
                  return AlertsService.error('Passwords do not match');

                final res = await AuthRepo.changePassword(
                  oldPassword: _oldPassword!,
                  newPassword: _newPassword!,
                );
                if (res == true) {
                  Navigator.pop(context);
                  AlertsService.success('Password changed!');
                }
              },
              color: kFocusColor,
            ),
          ],
        ).show(),
        child: Text("Change Password"),
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
            value: _age.toDouble(),
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
            title: CustomText(
                '${Globals.isUser ? socialId.capitalize! : socialId.replaceFirst('Id', '').capitalize!} ID'),
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
