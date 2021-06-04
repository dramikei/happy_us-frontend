import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const id = 'LoginScreen';

  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('LoginScreen'),
        ),
      ),
    );
  }
}

