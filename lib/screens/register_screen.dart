import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/services/alerts_service.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:happy_us/widgets/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  static const id = "RegisterScreen";

  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _agreeTnC = false;
  int _age = 18;

  final _acceptedAccounts = ['Snapchat', 'Discord'];
  int _selectedIdIndex = 0;

  String? _username;
  String? _password;
  String? _socialId;

  String? _validate({
    String? username,
    String? password,
    String? socialId,
  }) {
    if (username == null || username.isEmpty)
      return "Username cannot be empty";
    else if (username.length < 2)
      return "Username length cannot be less than 2";
    else if (socialId == null || socialId.isEmpty)
      return "Please enter a valid ${_acceptedAccounts[_selectedIdIndex]} ID";
    else if (password == null || password.isEmpty)
      return "Password cannot be empty";
    else if (password.length < 6)
      return "Password length cannot be less than 6";
    else if (!_agreeTnC) {
      return "Please accept terms and conditions, to continue";
    }
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
                padding: EdgeInsets.all(size.width * 0.06),
                children: [
                  const Text(
                    "Hey there",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Fill in the form and create your account",
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
                  Text(
                    '${_acceptedAccounts[_selectedIdIndex]} ID',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 21,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    onChanged: (v) => _socialId = v,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(
                      _acceptedAccounts.length,
                      (index) => Expanded(
                        child: RadioListTile<String>(
                          title: Text(
                            _acceptedAccounts[index],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          activeColor: kFocusColor,
                          value: _acceptedAccounts[index],
                          groupValue: _acceptedAccounts[_selectedIdIndex],
                          onChanged: (v) =>
                              setState(() => _selectedIdIndex = index),
                        ),
                      ),
                    ),
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
                  underlineText(
                    context: context,
                    text: "View Terms and conditions",
                    onTop: () {
                      NavigationService.push(
                        context,
                        path: NavigationService.tncPath,
                      );
                    },
                  ),
                  CheckboxListTile(
                    value: _agreeTnC,
                    onChanged: (v) => setState(() => _agreeTnC = v!),
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: kFocusColor,
                    title: Text("I agree to terms and conditions."),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Age: ${_age.toString()}",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 21,
                        ),
                      ),
                      Slider(
                        max: 24,
                        min: 18,
                        inactiveColor: kAccentColor,
                        activeColor: kFocusColor,
                        onChanged: (double value) {
                          setState(() {
                            _age = value.toInt();
                          });
                        },
                        value: _age.toDouble(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ArgonButton(
                      height: 50,
                      width: 150,
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      loader: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      onTap: (startLoading, stopLoading, btnState) async {
                        final error = _validate(
                          username: _username,
                          password: _password,
                          socialId: _socialId,
                        );

                        if (error != null)
                          AlertsService.error(error);
                        else {
                          final data = {
                            'username': _username,
                            'password': _password,
                            'type': 'user', //  Default type?
                            'age': _age,
                            'social': {
                              _acceptedAccounts[_selectedIdIndex].toLowerCase():
                                  _socialId
                            },
                          };
                          print(data);

                          if (btnState == ButtonState.Idle) {
                            startLoading();
                            await Future.delayed(Duration(seconds: 1));
                            // await callApi();
                            stopLoading();
                            AlertsService.success("Account Created!");
                          }
                        }
                      },
                      color: kFocusColor,
                      borderRadius: 10,
                    ),
                  ),
                  underlineText(
                      context: context,
                      text: "Already Registered? Login!",
                      onTop: () {
                        NavigationService.pop(context);
                        NavigationService.push(
                          context,
                          path: NavigationService.loginPath,
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget underlineText(
    {required BuildContext context,
    required String text,
    required VoidCallback onTop}) {
  return Align(
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
      onTap: onTop,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white54,
        ),
      ),
    ),
  );
}
