import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';

customSnackBar(
  BuildContext context,
  String message, {
  Color? backgroundColor = AppColors.kRedColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Text(message, style: AppTextStyle.textWhite16W500),
    ),
  );
}
