import 'package:flutter/material.dart';

class FeedsPage extends StatelessWidget {
  static const id = 'FeedsPage';

  const FeedsPage({
    Key? key,
  }) : super(key: key);

  // title, description, like, author,

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.separated(
          separatorBuilder: (c,i) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            return Placeholder();
          },
          itemCount: 100,
        ),
      ),
    );
  }
}
