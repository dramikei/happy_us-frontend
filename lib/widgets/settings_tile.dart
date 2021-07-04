import 'package:flutter/material.dart';
import 'package:happy_us/widgets/custom_text.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SettingsTile({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomText(
        title,
        style: TextStyle(fontSize: 20),
      ),
      onTap: onTap,
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
