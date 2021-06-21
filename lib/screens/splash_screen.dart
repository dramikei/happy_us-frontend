import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_us/controllers/user.getx.dart';
import 'package:happy_us/controllers/volunteer.getx.dart';
import 'package:happy_us/models/user.dart';
import 'package:happy_us/models/volunteer.dart';
import 'package:happy_us/repository/auth_repo.dart';
import 'package:happy_us/repository/user_repo.dart';
import 'package:happy_us/repository/volunteer_repo.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/globals.dart';
import 'package:happy_us/widgets/logo.dart';

class SplashScreen extends StatefulWidget {
  static const id = "SplashScreen";

  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void isLoggedIn() async {
    if (Globals.accessToken != null &&
        Globals.refreshToken != null &&
        Globals.userType != null) {
      // it means entity might be logged in
      final authenticatedEntity = Globals.isUser
          ? await UserRepo.getLoggedInUser()
          : await VolunteerRepo.getLoggedInVolunteer();

      // access and refresh token expired
      if (authenticatedEntity == null)
        Globals.removeCredentials();

      // store entity in
      else {
        if (Globals.isUser) {
          final _controller = Get.find<UserController>();
          _controller.updateUser(authenticatedEntity as User);
        } else {
          final _controller = Get.find<VolunteerController>();
          _controller.updateVolunteer(authenticatedEntity as Volunteer);
        }
      }
    }
    await Future.delayed(Duration.zero);
    NavigationService.pop(context);
    NavigationService.push(context, path: NavigationService.homePath);
  }

  @override
  void initState() {
    super.initState();
    () async {
      final success = await AuthRepo.pingServer();
      if (success == null || !success) {
        NavigationService.pop(context);
        NavigationService.push(
          context,
          path: NavigationService.connectionLostPath,
        );
      } else
        isLoggedIn();
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Logo(
              isSplashScreen: true,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
