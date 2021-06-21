import 'package:flutter/material.dart';

class MyPostsScreen extends StatelessWidget {
  static const id = 'MyPostsScreen';
  const MyPostsScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Center(
            child: Text('MyPostsScreen'),
        ),
      ),
    );
  }
}
