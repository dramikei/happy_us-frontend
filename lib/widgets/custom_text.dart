import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  static const id = 'CustomText';

  final String text;
  final TextStyle? style;

  const CustomText(
    this.text, {
    Key? key,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb)
      return SelectableText(text, style: style);
    else
      return Text(text, style: style);
  }
}
