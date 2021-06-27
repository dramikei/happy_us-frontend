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
    NavigationService.push(context, path: NavigationService.registerPath);
  }

  Widget _buildImage(String assetName) {
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
              title: "Exams? Worry not!!",
              body:
                  "\nGet access to college-specific curriculum taught by your seniors or that topper friend you have!!",
              image: _buildImage('exam'),
            ),
            PageViewModel(
              title: "Freelancing using academics?",
              body:
                  "Ofcourse, You can teach your friends by uploading courses.\n\n Using our website you can upload courses relevant to your college!!",
              image: _buildImage('money'),
            ),
            PageViewModel(
              title: "\nSave yourself @11Hour",
              body: "\n\nStart enrolling in our courses!!",
              image: _buildImage('clock'),
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
              ),
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
              ),
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
