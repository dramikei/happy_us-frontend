import 'package:flutter/material.dart';

class FeedsPage extends StatelessWidget {
  static const id = 'FeedsPage';

  const FeedsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('FeedsPage'),
        ),
      ),
    );
  }
}
