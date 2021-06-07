import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static const id = 'DashboardPage';

  const DashboardPage({
    Key? key,
  }) : super(key: key);

  // login/profile button,
  // about us page,
  // my appointments,
  // edit profile, etc.

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ListView.separated(
          separatorBuilder: (c, i) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            return Placeholder(fallbackHeight: 100);
          },
          // about us page button here
          itemCount: 100,
        ),
      ),
    );
  }
}
