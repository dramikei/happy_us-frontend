import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/repository/auth_repo.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/custom_text_field.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChangePasswordButton extends StatefulWidget {
  const ChangePasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  _ChangePasswordButtonState createState() => _ChangePasswordButtonState();
}

class _ChangePasswordButtonState extends State<ChangePasswordButton> {
  String? _oldPassword;

  String? _newPassword;

  String? _confirmNewPassword;

  String? _validatePassword(String? password) {
    if (password == null || password.trim().isEmpty)
      return "password cannot be empty";
    else if (password.length < 6)
      return "password length cannot be less than 6";
  }

  @override
  Widget build(BuildContext context) {
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
          buttons: [],
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ArgonButton(
                    borderRadius: 7,
                    height: 37,
                    width: 87,
                    loader: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: (startLoading, stopLoading, btnState) async {
                      final _old = _validatePassword(_oldPassword);
                      if (_old != null) return AlertsService.error('Old $_old');
                      final _new = _validatePassword(_newPassword);
                      if (_new != null) return AlertsService.error('New $_new');

                      if (_newPassword != _confirmNewPassword)
                        return AlertsService.error('Passwords do not match');

                      if (btnState == ButtonState.Idle) {
                        startLoading();
                        final res = await AuthRepo.changePassword(
                          oldPassword: _oldPassword!,
                          newPassword: _newPassword!,
                        );
                        if (res == true) {
                          Navigator.pop(context);
                          AlertsService.success('Password changed!');
                        }
                        stopLoading();
                      }
                    },
                    color: kFocusColor,
                  ),
                ],
              )
            ],
          ),
        ).show(),
        child: Text("Change Password"),
      ),
    );
  }
}
