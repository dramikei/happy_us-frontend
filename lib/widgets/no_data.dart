import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  static const id = 'NoData';

  const NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('No Data found'),
    );
  }
}
