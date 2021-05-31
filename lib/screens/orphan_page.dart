import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrphanPage extends StatelessWidget {
  static const id = 'OrphanPage';

  const OrphanPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Lottie.asset("assets/lottie/volunteer.json"),
            Lottie.asset("assets/lottie/loader.json"),
            Lottie.asset("assets/lottie/support.json"),
            Lottie.asset("assets/lottie/orphan.json"),
          ],
        )
      ),
    );
  }
}
