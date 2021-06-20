import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_us/controllers/user.getx.dart';
import 'package:happy_us/controllers/volunteer.getx.dart';
import 'package:happy_us/repository/auth_repo.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loginAsVolunteer = false;

  String? _username;
  String? _password;

  String? _validate({
    String? username,
    String? password,
  }) {
    if (username == null || username.isEmpty)
      return "Username cannot be empty";
    else if (username.length < 2)
      return "Username length cannot be less than 2";
    else if (password == null || password.isEmpty)
      return "Password cannot be empty";
    else if (password.length < 6)
      return "Password length cannot be less than 6";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final showCarousel = size.width >= SMALL_SCREEN_WIDTH;

    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            if (showCarousel)
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: 10,
                  itemBuilder: (context, index, _) {
                    return Image.network(
                      "https://images.unsplash.com/photo-1622763851108-b82f98dcd86c?ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2MXx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    height: double.infinity,
                    viewportFraction: 1,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 500),
                  ),
                ),
              ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(size.width * 0.08),
                children: [
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Fill in the form and login to your account",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Anonymous Username",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 21,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    autofocus: true,
                    onChanged: (v) => _username = v,
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Dummy Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 21,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    isPasswordField: true,
                    onChanged: (v) => _password = v,
                  ),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    value: _loginAsVolunteer,
                    onChanged: (v) => setState(() => _loginAsVolunteer = v!),
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: kFocusColor,
                    title: Text("Login as volunteer"),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ArgonButton(
                      height: 50,
                      width: 150,
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      loader: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      onTap: (startLoading, stopLoading, btnState) async {
                        final error = _validate(
                          username: _username,
                          password: _password,
                        );

                        if (error != null)
                          AlertsService.error(error);
                        else {
                          if (btnState == ButtonState.Idle) {
                            startLoading();

                            if (_loginAsVolunteer) {
                              final volunteer = await AuthRepo.loginVolunteer(
                                username: _username!,
                                password: _password!,
                              );
                              if (volunteer != null) {
                                Get.find<VolunteerController>()
                                    .updateVolunteer(volunteer);
                                AlertsService.success("Logged in");
                                NavigationService.pop(context);
                              }
                            } else {
                              final user = await AuthRepo.loginUser(
                                username: _username!,
                                password: _password!,
                              );
                              if (user != null) {
                                Get.find<UserController>().updateUser(user);
                                AlertsService.success("Logged in");
                                NavigationService.pop(context);
                              }
                            }
                            stopLoading();
                          }
                        }
                      },
                      color: kFocusColor,
                      borderRadius: 10,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.center,
                    child: EasyContainer(
                      margin: 0,
                      color: Colors.transparent,
                      elevation: 0,
                      customPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      alignment: null,
                      onTap: () {
                        NavigationService.pop(context);
                        NavigationService.push(
                          context,
                          path: NavigationService.registerPath,
                        );
                      },
                      child: Text(
                        "New here? Register now!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
