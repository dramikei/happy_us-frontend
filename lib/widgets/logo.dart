import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  static const id = 'Logo';
  final bool isSplashScreen;

  const Logo({
    Key? key,
    this.isSplashScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSplashScreen ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Image.asset(
          "assets/images/logo.png",
          height: 65,
        ),
        Text(
          "Happy Us",
          style: TextStyle(
            color: isSplashScreen
                ? Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white
                : Colors.black,
            fontSize: 25,
          ),
        ),
      ],
    );
  }
}
