import 'package:flutter/material.dart';
import 'package:happy_us/widgets/static_info_card.dart';

class ReachOutPage extends StatelessWidget {
  static const id = 'OrphanPage';

  const ReachOutPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StaticInfoCard(),
      ),
    );
  }
}
