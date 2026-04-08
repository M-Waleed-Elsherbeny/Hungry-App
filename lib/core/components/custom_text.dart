import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.textStyle,
    this.maxLines,
  });

  final String text;
  final TextStyle? textStyle;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle, maxLines: maxLines);
  }
}
