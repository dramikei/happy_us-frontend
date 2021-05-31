import 'package:flutter/material.dart';
import 'package:happy_us/widgets/static_info_card.dart';

class OrphanPage extends StatelessWidget {
  static const id = 'OrphanPage';

  const OrphanPage({
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
