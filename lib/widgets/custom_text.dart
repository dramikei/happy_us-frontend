import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  static const id = 'CustomText';

  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomText(
    this.text, {
    Key? key,
    this.style,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb && overflow == null)
      return SelectableText(
        text,
        style: style,
        maxLines: maxLines,
      );
    else
      return Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
      );
  }
}
