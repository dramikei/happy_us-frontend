import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoData extends StatelessWidget {
  static const id = 'NoData';

  const NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        Lottie.asset('assets/lottie/404.json'),
        Text(
          "Beep boop Beoop boop,\n\n No result found-op",
          style: TextStyle(fontSize: 21),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
