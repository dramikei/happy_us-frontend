import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_us/repository/user_repo.dart';
import 'package:happy_us/controllers/user.getx.dart';
import 'package:happy_us/models/base_user.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:happy_us/widgets/custom_text.dart';
import 'package:happy_us/widgets/custom_text_field.dart';

class Profile extends StatefulWidget {
  final BaseUser user;

  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _editingUsername = false;
  bool _editingSocial = false;
  int? _age;
  String? _username;
  Map<String, String> _social = {};

  @override
  Widget build(BuildContext context) {
    _age ??= widget.user.age;
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
              : CustomText(widget.user.username),
          trailing: Globals.isUser
              ? FittedBox(
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(_editingUsername ? Icons.check : Icons.edit),
                        iconSize: _editingUsername ? 30 : 20,
                        onPressed: () async {
                          _editingUsername = !_editingUsername;
                          if (!_editingUsername) {
                            if (_username == null || _username!.isEmpty) {
                              return AlertsService.error(
                                  'Username cannot be empty');
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
                      ),
                      if (_editingUsername)
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _editingUsername = false;
                            });
                          },
                          iconSize: 30,
                          icon: Icon(Icons.cancel_outlined),
                        )
                    ],
                  ),
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
            value: _age!.toDouble(),
          ),
          trailing: _age != widget.user.age
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
        ...widget.user.social.keys.map(
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
                : CustomText(widget.user.social[socialId]),
            trailing: Globals.isUser
                ? FittedBox(
                    child: Column(
                      children: [
                        IconButton(
                          icon: Icon(_editingSocial ? Icons.check : Icons.edit),
                          iconSize: _editingSocial ? 30 : 20,
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
                        ),
                        if (_editingSocial)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _editingSocial = false;
                              });
                            },
                            iconSize: 30,
                            icon: Icon(Icons.cancel_outlined),
                          )
                      ],
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
