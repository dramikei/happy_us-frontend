import 'package:flutter/material.dart';
import 'package:happy_us/widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  static const id = 'ProfileScreen';
  const ProfileScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Center(
            child: CustomText('ProfileScreen'),
        ),
      ),
    );
  }
}
