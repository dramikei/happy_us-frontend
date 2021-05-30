import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  static const id = 'AboutUsPage';

  const AboutUsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('AboutUsPage'),
        ),
      ),
    );
  }
}
