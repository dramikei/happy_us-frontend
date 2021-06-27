import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:happy_us/services/navigation_service.dart';
import 'package:happy_us/utils/constants.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatelessWidget {
  static const id = 'IntroScreen';
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    NavigationService.pop(context);
    NavigationService.push(context, path: NavigationService.homePath);
  }

  Widget _buildLottie(String assetName) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Lottie.asset(
        'assets/lottie/$assetName.json',
        width: double.infinity,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IntroductionScreen(
          key: introKey,
          pages: [
            PageViewModel(
              title: "Feeds Page",
              body:
                  "\nOn this page, you will see posts from other people and will be able to react to them.\n\nYou can also share what you are feeling by pressing the plus button!!",
              image: _buildLottie('feed'),
            ),
            PageViewModel(
              title: "Volunteer Page",
              body:
                  "Here you can find the volunteer for you by checking their info and request an appointment with them.\n\nTime Pass 101: Try dragging the stress ball(Yellow button on bottom right) from edges.",
              image: _buildLottie('volunteer'),
            ),
            PageViewModel(
              title: "Reach Out Page",
              body:
                  "\n\nSome simple steps that you can follow for helping people affected by Covid",
              image: _buildLottie('reach_out'),
            ),
            PageViewModel(
              title: "Dashboard",
              body:
                  "\n\nAfter logging in, you will find all your appointments, posts and notification in the page. \n\nYou can also manage your account from this page.",
              image: _buildLottie('dashboard'),
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          // You can override onSkip callback
          showSkipButton: true,
          skipFlex: 0,
          nextFlex: 0,
          skip: EasyContainer(
            color: kFocusColor,
            padding: 10,
            child: Text(
              'Skip',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
          next: EasyContainer(
            padding: 7,
            color: kFocusColor,
            child: Icon(
              Icons.arrow_forward,
              size: 33,
              color: Colors.white,
            ),
          ),
          done: EasyContainer(
            padding: 10,
            color: kFocusColor,
            child: Text(
              'Done',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
          dotsDecorator: DotsDecorator(
            activeColor: kAccentColor,
            size: Size(10.0, 10.0),
            color: Colors.black,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }
}
