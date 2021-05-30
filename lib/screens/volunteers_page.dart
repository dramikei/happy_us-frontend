import 'package:flutter/material.dart';

class VolunteersPage extends StatelessWidget {
  static const id = 'VolunteersPage';

  const VolunteersPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('VolunteersPage'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.animation),
          onPressed: () {
            // orphan page?
          },
        ),
      ),
    );
  }
}
