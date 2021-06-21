import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const id = 'ProfileScreen';
  const ProfileScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Center(
            child: Text('ProfileScreen'),
        ),
      ),
    );
  }
}
