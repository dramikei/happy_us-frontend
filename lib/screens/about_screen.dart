import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const id = 'AboutScreen';
  const AboutScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Center(
            child: Text('AboutScreen'),
        ),
      ),
    );
  }
}
