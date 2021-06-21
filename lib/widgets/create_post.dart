import 'package:flutter/material.dart';
import 'package:happy_us/widgets/custom_text.dart';

class CreatePost extends StatelessWidget {
  static const id = 'CreatePost';

  const CreatePost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CustomText('CreatePost'),
        ),
      ),
    );
  }
}
